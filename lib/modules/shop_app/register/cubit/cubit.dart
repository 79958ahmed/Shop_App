
import 'package:abdulla_mansour/models/shop_app/login_model.dart';
import 'package:abdulla_mansour/modules/shop_app/login/cubit/states.dart';
import 'package:abdulla_mansour/modules/shop_app/register/cubit/states.dart';
import 'package:abdulla_mansour/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/end_points.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super (ShopRegisterInitialState());
static ShopRegisterCubit get(context)=>BlocProvider.of(context);

ShopLoginModel loginModel;

void userRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,

})
{
  emit(ShopRegisterLoadingState());
DioHelper.postData(
  url:REGISTER,
  data:{
    'name':name,
    'email':email,
    'password':password,
    'phone':phone,

  },
).then((value) {
//  print ('khdhkbdhbgvjhgvjkghjjhbbhjjh');
  print(value.data);
///  print ('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
  loginModel= ShopLoginModel.fromjson(value.data);
  //print ('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
  // print (loginModel.message);
  // print (loginModel.data.token);
  // print(value.data['message']);
  emit(ShopRegisterSuccessState(loginModel));
}).catchError((error)
{
  //print ('Error ************************************************');
  print(error.toString());
emit(ShopRegisterErrorState(error.toString()));
  });
}

IconData suffix=Icons.visibility_outlined;
bool isPassword=true;

void changePasswordVisibility()
{
  isPassword=!isPassword;
  suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(ShopRegisterChangePasswordVisibilityState());
}
}