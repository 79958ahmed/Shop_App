
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class SettingsScreens extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
var nameController =TextEditingController();
var emailController =TextEditingController();
var phoneController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context, state)
     {
       /*
if (state is ShopSuccessUserDataState)
  {
    print(state.loginModel.data.name);
    print(state.loginModel.data.email);
    print(state.loginModel.data.phone);

    nameController.text=state.loginModel.data.name;
   emailController.text=state.loginModel.data.email;
    phoneController.text=state.loginModel.data.phone ;

  }*/
     },
      builder: (context,state){
       var model = ShopCubit.get(context).userModel;

       nameController.text=model.data.name;
       emailController.text=model.data.email;
       phoneController.text=model.data.phone ;

       return ConditionalBuilder(
         condition: ShopCubit.get(context).userModel !=null ,
     builder: (context)=> Padding(
       padding: const EdgeInsets.all(20.0),
       child: Form(
         key: formKey,
         child: Column(
           children: [
            if(state is ShopLoadingUpdateUserState)
            LinearProgressIndicator(),
             SizedBox(
               height: 20,
             ),
             dfaultFormfield(
               controller: nameController,
               type: TextInputType.name,
               validate: (String value)
               {
                 if(value.isEmpty)
                 {
                   return 'Name Must Not Be Empty';
                 }
                 return null;
               },
               label: 'name',
               prefix: Icons.person,
             ),
             SizedBox(
               height: 20,
             ),
             dfaultFormfield(
               controller: emailController,
               type: TextInputType.emailAddress,
               validate: (String value)
               {
                 if(value.isEmpty)
                 {
                   return 'Email Must Not Be Empty';
                 }
                 return null;
               },
               label: 'email',
               prefix: Icons.email,
             ),
             SizedBox(
               height: 20,
             ),
             dfaultFormfield(
               controller: phoneController,
               type: TextInputType.phone,
               validate: (String value)
               {
                 if(value.isEmpty)
                 {
                   return 'Phone Must Not Be Empty';
                 }
                 return null;
               },
               label: 'phone',
               prefix: Icons.phone,
             ),
             SizedBox(
               height: 20,
             ),
             defaultButton(
               function: ()
               {
                 if(formKey.currentState!.validate()) {
                   ShopCubit.get(context).updateUserData(
                     name: nameController.text,
                     phone: phoneController.text,
                     email: emailController.text,
                   );
                 }
               },
               text: 'Update',
               isUpperCase: true,
               background: Colors.blue,
             ),
             SizedBox(
               height: 20,
             ),
             defaultButton(
                 function: ()
             {
               signOut(context);
             },
                 text: 'Logout',
               isUpperCase: true,
               background: Colors.blue,
             ),
           ],

         ),
       ),
     ),
         fallback: (context)=>Center(child: CircularProgressIndicator()),
       );
      },
    );
  }
}
