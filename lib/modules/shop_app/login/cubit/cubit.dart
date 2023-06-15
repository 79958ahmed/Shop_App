
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../register/cubit/states.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super (ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url:LOGIN,
      data:{
        'email':email,
        'password':password,
      },
    ).then((value) {
      //print ('khdhkbdhbgvjhgvjkghjjhbbhjjh');
      print(value.data);
     // print ('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
      loginModel= ShopLoginModel.fromjson(value.data);
      //print ('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      // print (loginModel.message);
      // print (loginModel.data.token);
      // print(value.data['message']);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error)
    {
 //     print ('Error ************************************************');
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;

  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}