import 'package:abdulla_mansour/layout/shop_app/shop_layout.dart';
import 'package:abdulla_mansour/modules/shop_app/login/cubit/cubit.dart';
import 'package:abdulla_mansour/modules/shop_app/login/cubit/states.dart';
import 'package:abdulla_mansour/modules/shop_app/register/shop_register_screen.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:abdulla_mansour/shared/components/constants.dart';
import 'package:abdulla_mansour/shared/network/local/cashe_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
listener: (context, state)
{
  if (state is ShopLoginSuccessState) {
  //  print ('ahmaaaaa54845645aaaaaaaa00000000000000000000000000a');
    if (state.loginModel.status)
    {
    //  print ('ahmaaaaaaaaaaaaa00000000000000000000000000a');
      print(state.loginModel.message);
      print(state.loginModel.data.token);

      CasheHelper.saveData(
        key: 'token',
        value: state.loginModel.data.token,
      ).then((value){
        token=state.loginModel.data.token;
        navigateAndFinish(
          context,
          ShopLayout(),
        );
      });
    }
    else {
      print(state.loginModel.message);

      showToast(
        text: state.loginModel.message,
        state: ToastStates.ERROR,
      );
    }
  }
},
        builder: (context, state)
        {
           return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key:formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'LOGIN',
                    style:Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Login now to browse our offers',
                    style:Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height:30,
                  ),
                  dfaultFormfield(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value )
                    {
                      if (value.isEmpty)
                      {
                        return 'must not be empty';
                      }
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height:10,
                  ),
                  dfaultFormfield(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    suffix: ShopLoginCubit.get(context).suffix ,

                    onSubmit: (value)
                    {
                      if (formKey.currentState.validate())
                      {
                        ShopLoginCubit.get(context).userLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                    isPaassword:  ShopLoginCubit.get(context).isPassword,
                    suffixPressed: ()
                    {
                      ShopLoginCubit.get(context).changePasswordVisibility();
                    },
                    validate: (String value )
                    {
                      if (value.isEmpty)
                      {
                        return 'must not be empty';
                      }
                    },
                    label: 'Password',
                    prefix: Icons.password,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: state is! ShopLoginLoadingState,
                    builder: (context)=>defaultButton(
                      function: (){
                        if (formKey.currentState.validate())
                          {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                            );
                          }
                      },
                      text: 'login',
                      isUpperCase: true,
                      background: Colors.blue,
                    ),
                 fallback:  (context)=>Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row
                    (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Text
                        (
                        'Don\'t have an account?',
                      ),
                      defaultTextButton(
                        function: (){
                          navigateTo(
                            context,
                            ShopRegisterScreen(),
                          );
                        },
                        text: 'register',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
  );
        },
      ),
    );
  }
}
