import 'package:flutter/material.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Login/LoginScreen.dart';
class onBoardingModel{
  final String image;
  final String title;
  final String body;
  onBoardingModel(@required this.image,@required this.title, @required this.body);


}

class onboardingScreen extends StatefulWidget {
  static const BOARDING_SCREEN='onbording_scrren';
  @override
  _onboardingScreenState createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  var boardcontroller =PageController();
  bool isLastPage=false;

  List<onBoardingModel> boarding =[
    onBoardingModel('assets/images/fogg-order-completed.png', 'onboard 1 title', 'onboard 1 body'),
    onBoardingModel('assets/images/fogg-uploading-1.png', 'onboard 2 title', 'onboard 2 body'),
    onBoardingModel('assets/images/fogg-delivery-1.png', 'onboard 3 title', 'onboard 3 body')
  ];
  void submit(){
    StoragePref.setValue('onboarding', true).then((value) {
      print(value);
      if(value){pushAndReplace(context, LoginScreen.SIGN_IN_SCREEN);}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: Text('SKIP')),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardcontroller,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      isLastPage=true;
                    });

                  }
                  else
                    {
                      isLastPage=false;

                    }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: colorAcc,
                  ),

                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLastPage){
                      submit();

                    }else{
                      boardcontroller.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),

              ],
            ),
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(onBoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
  child: Image(image:AssetImage(model.image)),
  ),
  SizedBox(height: 20),
  Text(model.title,style: TextStyle(fontSize: 24,),),
  SizedBox(height: 10),
  Text(model.body,style: TextStyle(fontSize: 16,),),
  ],
  );
}
