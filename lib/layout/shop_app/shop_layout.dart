
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layout/shop_app/cubit/states.dart';

import '../../modules/shop_app/search/search_screen.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,states){},
      builder: (context,states){
        var cubit=ShopCubit.get(context);

        return Scaffold(

          appBar: AppBar(
            title: Text(
                'Salla'
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                  ),

              onPressed: ()
              {
                navigateTo(context,SearchScreens(),);
              },
              ),
            ],
          ),

       body:cubit.bottomScreen[cubit.currentIndex] ,
bottomNavigationBar: BottomNavigationBar(
  onTap: (index)
  {
    cubit.changeBottom(index);

  },
  currentIndex: cubit.currentIndex,
  items:[
    BottomNavigationBarItem(
      icon: Icon(Icons.home,
),
      label:   'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.apps,
      ),
      label:   'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label:   'Favourite',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label:   'Settings',
    ),
  ],

),
        );

      },
    );
  }
}
