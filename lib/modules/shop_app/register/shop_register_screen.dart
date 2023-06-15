import 'package:abdulla_mansour/modules/shop_app/register/cubit/cubit.dart';
import 'package:abdulla_mansour/modules/shop_app/register/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cashe_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';

class ShopRegisterScreen  extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
listener:(context, state)
{
  if (state is ShopRegisterSuccessState) {
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
} ,
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
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
                          'REGISTER',
                          style:Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our offers',
                          style:Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height:30,
                        ),
                        dfaultFormfield(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value )
                          {
                            if (value.isEmpty)
                            {
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height:10,
                        ),
                        dfaultFormfield(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value )
                          {
                            if (value.isEmpty)
                            {
                              return 'Email must not be empty';
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
                          suffix: ShopRegisterCubit.get(context).suffix ,

                          onSubmit: (value)
                          {


                          },
                          isPaassword:  ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value )
                          {
                            if (value.isEmpty)
                            {
                              return 'Password must not be empty';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.password,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        dfaultFormfield(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value )
                          {
                            if (value.isEmpty)
                            {
                              return 'Phone must not be empty';
                            }
                          },
                          label: 'Phone ',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if (formKey.currentState.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  name:nameController.text ,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                            background: Colors.blue,
                          ),
                          fallback:  (context)=>Center(child: CircularProgressIndicator()),
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
