//import 'package:flutter/cupertino.dart';


import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double  width=double.infinity,
   Color background=Colors.blue,
  bool isUpperCase =true,
  double radius =3,
 @required Function function,
  @required String text,
}) =>
    Container(
      width:width,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase? text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular
          (
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,

})=>
    TextButton(
      onPressed:function,
      child :Text(
        text.toUpperCase()
      ),
    );

Widget dfaultFormfield({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPaassword=false,
  @required Function validate,
  @required String label,
@required IconData prefix,
   IconData suffix,
Function suffixPressed,
bool isClickable =true ,
})=>  TextFormField(
    controller:controller ,
    keyboardType : type,
    obscureText: isPaassword,
  //  keyboardType: TextInputType.emailAddress ,
    onFieldSubmitted:onSubmit,
    onChanged: onChange,
    onTap:onTap ,
    enabled: isClickable,
    validator: validate,
    decoration:InputDecoration (
      labelText: label,
      prefixIcon: Icon(
       prefix,
      ),
      suffixIcon:suffix !=null? IconButton(
        onPressed: suffixPressed,
        icon: Icon(
           suffix,
        ),
      ):null ,
      border: OutlineInputBorder(),
    )
);


Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
})=>AppBar(
leading: IconButton(
  onPressed: ()
  {
    Navigator.pop(context);
  },
  icon: Icon(
    Icons.arrow_back_ios,
  ),
),
titleSpacing: 5,
title: Text(
  title,
),
  actions:actions,
);


Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40,
  
          child: Text(
  
            '${model['time']}',
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children:
  
            [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18,
  
                  fontWeight:FontWeight.bold,
  
                ),
  
              ),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                  // fontSize: 15,
  
                  //fontWeight: FontWeight.normal,
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
  
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        IconButton(
  
  onPressed: ()
  
  {
  
    AppCubit.get(context).updateData(
  
    status: 'Done',
  
    id :model['id'],
  
  );
  
  },
  
            icon: Icon(
  
              Icons.check_circle,
  
              color: Colors.green,
  
  
  
            ),
  
        ),
  
        IconButton(
  
          onPressed: ()
  
          {
  
            AppCubit.get(context).updateData(
  
              status: 'archive',
  
              id :model['id'],
  
            );
  
          },
  
          icon: Icon(
  
            Icons.archive,
  
  color: Colors.grey,
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
  onDismissed: (direction)
  {
AppCubit.get(context).deleteData( id: model['id'],);

  },
);
Widget tasksBuilder(
@required List<Map>tasks,
)=>ConditionalBuilder(
  condition:tasks.length>0 ,
  builder:(context)=>ListView.separated(
    itemBuilder: (context, index)
    {
      print('task status ${tasks [index]['status']}');
      return buildTaskItem(tasks[index], context);
    },
    separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    ),
    itemCount: tasks.length,
  ),
  fallback: (context)=>Center(
    child:   Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Icon(

          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),

        Text(

          'NO TASKS YET,PLEASE ADD ONE YABRO',
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
            fontWeight:FontWeight.bold,
          ),
        ),
      ],



    ),
  ),

);

Widget myDivider()=> Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
     navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(10.0,),
            image:DecorationImage(
              image: NetworkImage ('${article['urlToImage']}'),
              fit:BoxFit.cover,
            ),


          ),
        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

               children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style:Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(List,  context,{ isSearch=false}) => ConditionalBuilder(
condition:List.length>0 ,
builder: (context)=>ListView.separated(
physics: BouncingScrollPhysics(),
itemBuilder: (context,index)=>buildArticleItem(List[index], context),
separatorBuilder: (context,index)=>myDivider(),
itemCount: 10,),

fallback:(context)=> Center(child: CircularProgressIndicator()) ,

);

void navigateTo(context , widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder:(context)=>widget,

  ),
);
void navigateAndFinish(context , widget)=>
    Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>widget,
    ),
    (route)
    {
     return false;
    },
  );

void showToast({
  @required String text,
@required ToastStates state,
})=>
    Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

//enum
enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}
Widget buildListProduct( model,
    context, {
  bool isOldPrice=true
}) =>
    Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:[
            Image(
              image:NetworkImage(model.image) ,
              width:120,
              height: 120,

            ),
            if(model.discount!=0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
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
        SizedBox(
          width: 20,
        ),
        Expanded(
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
              Spacer(),
              Row(
                children:[
                  Text(
                    model.price.toString(),
                    style:TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ) ,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount !=0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
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

                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                      ShopCubit.get(context).favorites[model.id]
                          ?defaultColor
                          :Colors.grey,
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
  ),
);
