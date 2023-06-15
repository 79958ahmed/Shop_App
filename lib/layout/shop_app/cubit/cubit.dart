
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layout/shop_app/cubit/states.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../modules/shop_app/ctegories/ctegories_screen.dart';
import '../../../modules/shop_app/favourites/favourites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List <Widget> bottomScreen =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreens(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
Map <int, bool> favorites= {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel.toString());

      print(homeModel.data.banners[0].image);
      print(homeModel.status);
      homeModel.data.products.forEach((element)
      {
favorites.addAll({
  element.id:element.inFavorites,
});
      });
     // print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {

    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printFullText(homeModel.toString());


      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId]=!favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          'product_id':productId,
        },
      token: token,
    ).then((value)
    {
      changeFavoritesModel =ChangeFavoritesModel.fromJson(value.data);
print(value.data );

if (!changeFavoritesModel.status)
  {
    favorites[productId]=!favorites[productId];
  } else{
  getFavorites();
  }

      emit(ShopSuccessFavoritesState(changeFavoritesModel));
    }).catchError((error)
        {
          favorites[productId]=!favorites[productId];

          emit(ShopErrorFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() 
  {
emit(ShopLoadingGetFavoritesState());
    
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
     // printFullText(value.data.toString());


      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
  ShopLoginModel userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
       userModel= ShopLoginModel.fromjson(value.data);
   //printFullText(userModel.data.name);


      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  void updateUserData( {
    required String name,
    required String email,
    required String phone,
    })
  {
  emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,

      },
    ).then((value) {
      userModel= ShopLoginModel.fromjson(value.data);
      //printFullText(userModel.data.name);


      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}

