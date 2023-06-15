
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/shop_app/search/cubit/cubit.dart';

import '../../../shared/components/components.dart';
import 'cubit/states.dart';

class SearchScreens extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child:BlocConsumer <SearchCubit ,SearchStates>(
        listener:(context, state) {},
      builder:(context,state) {
          return Scaffold(
              appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column
              (
              children:
              [
                dfaultFormfield(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                    return 'error text to search';
                    }
                    return null;
                  },
                  onSubmit: (String text)
                  {
SearchCubit.get(context).search(text);
                  },
                    label: 'search',
                    prefix: Icons.search,
                ),
                SizedBox(
height: 12,
                ),

                if(state is SearchLoadingState)
                LinearProgressIndicator(),
                SizedBox(
                  height: 12,
                ),
          if(state is SearchSuccessState)
          Expanded(
            child: ListView.separated(
              itemBuilder: (context,index)=>buildListProduct( SearchCubit.get(context).model.data.data[index],context, isOldPrice:false,),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: SearchCubit.get(context).model.data.data.length,
            ),
          ),
              ],
            ),
          ),
        ),
          );
      },
      ),
    );
  }
}
