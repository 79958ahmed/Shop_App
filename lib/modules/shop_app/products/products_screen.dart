import 'package:abdulla_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/shop_app/cubit/states.dart';
import 'package:abdulla_mansour/models/shop_app/home_model.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:abdulla_mansour/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/categories_model.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavoritesState) {
          if (state.model.status) {
            showToast(
              text: state.model.message,
              state: ToastStates.SUCCESS,
            );
          }
        }
      },
        builder: (context,state)
        {
          return ConditionalBuilder(
          //  condition: state is! ShopLoadingHomeDataState,
            condition: ShopCubit.get(context).homeModel !=null&&
                ShopCubit.get(context).categoriesModel !=null,
            builder: (context)=> builderWidget(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel,context),
            fallback: (context)=>Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
    );
  }
  Widget builderWidget(HomeModel model,CategoriesModel categoriesmodel,context)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
children:
[
CarouselSlider(
    items:model.data.banners.map((e) =>Image(
      image: NetworkImage('${e.image}'),
      width: double.infinity,
      fit: BoxFit.cover,
    ), ).toList(),
    options: CarouselOptions(
      height: 250,
      initialPage: 0,
      viewportFraction: 1,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(seconds: 1),
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
    ),
),
    SizedBox(
      height: 10,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 10,
          ),
Container(
  height: 100,
  child:   ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => buildCategoryItem(categoriesmodel.data.data[index]),
            separatorBuilder:(context, index)=> SizedBox(
              width: 10,
            ) ,
            itemCount: categoriesmodel.data.data.length,
  ),
),
          SizedBox(
            height: 20,
          ),
Text(
          'New Products',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
  ),
        ],
      ),
    ),
  SizedBox(
    height: 10,
  ),
    Container(
      color: Colors.grey[300],
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
mainAxisSpacing: 1,
crossAxisSpacing: 1,
childAspectRatio: 1/1.58,
children: List.generate(
      model.data.products.length,
        (index) => buildGridProduct( model.data.products[index],context),
),
      )
    ),
],
    ),
  );

  Widget buildCategoryItem(DataModel model) =>    Container(
    height: 100,
    width: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children:
      [
        Image(
          image:NetworkImage(model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8,),
          width: double.infinity,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,

            ),
          ),
        ),
      ],
    ),
  );

  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:[
            Image(
            image:NetworkImage(model.image) ,
            width: double.infinity,
            height: 200,
          ),
            if(model.discount !=0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5,),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 8,
color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ) ,
              ),
              Row(
                children:[
                Text(
                  '${model.price.round()}',
                  style:TextStyle(
                    fontSize: 12,
                    color: defaultColor,
                  ) ,
                ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount !=0)
                  Text(
                    '${model.oldPrice.round()}',
                    style:TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ) ,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
ShopCubit.get(context).changeFavorites(model.id);
print(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]?defaultColor:Colors.grey,
                      child: Icon(
                          Icons.favorite_border,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),

                  ),
                  ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
