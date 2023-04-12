import 'package:first_flutter/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:first_flutter/shared/network/local/cash_helper.dart';
import 'package:first_flutter/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  var boundController=PageController();
  List<BoardingModel> Items=
  [
    BoardingModel(image:'assets/images/onboard_1.jpg',
        title:'title on board 1',
        body:'body on board 1',
    ),
    BoardingModel(image:'assets/images/onboard_1.jpg',
        title:'title on board 2',
        body:'body on board 2',
    ),
    BoardingModel(image:'assets/images/onboard_1.jpg',
        title:'title on board 3',
        body:'body on board 3',
    ),
  ];
bool isLast=false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
              child: Text('SKIP'),),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column
          (
          children: [
            Expanded(
              child: PageView.builder(
                  itemBuilder: (context,index)=>pageViewItem(Items[index]),
                itemCount: Items.length,
                physics: BouncingScrollPhysics(),
                controller: boundController,
                onPageChanged: (index) {
                  if(index==Items.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boundController,
                  count: Items.length,
                  onDotClicked: (index) => Items[index],
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    spacing: 5.0,
                    dotWidth: 10.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios),
                    onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boundController.nextPage(
                        duration:Duration(milliseconds: 750) ,
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                    },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget pageViewItem(BoardingModel Items)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${Items.image}'),
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
      Text(
        Items.title,
        style: TextStyle(
          fontSize: 24.0,
          fontFamily: 'JANNAh',
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        Items.body,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'JANNAh',
        ),
      ),
    ],
  );

  void submit(){
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateAndFinish(context, ShopLoginScreen());
    });

  }
}
