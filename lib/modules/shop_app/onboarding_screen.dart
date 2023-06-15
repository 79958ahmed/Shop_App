
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cashe_helper.dart';
import '../../shared/styles/colors.dart';
import 'login/shop_login_screen.dart';

class BoardingModel
{
final String image;
final String title;
final String body;

BoardingModel({
  required this.title,
  required this.body,
  required this.image,
});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();

  List<BoardingModel> Boarding =[
    BoardingModel(
      image:'assets/images/onboard_1.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image:'assets/images/onboard_1.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image:'assets/images/onboard_1.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  bool isLast =false;
  void submit (){
    CasheHelper.saveData(key: 'onBoarding', value: true,).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function:submit,
              text: 'skip',
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
children: [
Expanded(
  child:   PageView.builder(
    physics: BouncingScrollPhysics(),
controller: boardController,
    onPageChanged: (int index){
      if(index ==Boarding.length-1){
    setState(() {
      isLast=true;
    });
      }else {
        setState(() {
          isLast=false;
        });

      }


    },
    itemBuilder: (context,index)=>buildBordingItem(Boarding[index]),

  itemCount:Boarding.length,

  ),
),
SizedBox(
  height: 40,
),
  Row(
    children:
    [
      SmoothPageIndicator(
        controller: boardController,
        count: Boarding.length,
        effect: ExpandingDotsEffect(
          dotColor: Colors.grey,
          activeDotColor: defaultColor,
          dotHeight:10,
          dotWidth: 10,
          expansionFactor: 4,
          spacing: 5,
        ),
      ),
      Spacer(),
      FloatingActionButton(onPressed: ()
      {
        if (isLast)
        {
submit();
        }
        else{
          boardController.nextPage(duration: Duration(
            milliseconds: 750,
          ),
            curve:Curves.fastLinearToSlowEaseIn  ,
          );

        }


      },
      child:Icon(
    Icons.arrow_forward_ios_outlined,
    ),
      ),

    ],
  ),
],
        ),
      ),
    );
  }

  Widget buildBordingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}
