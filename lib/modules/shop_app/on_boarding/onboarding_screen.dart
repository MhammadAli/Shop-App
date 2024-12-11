import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast =
      false; // we must put it here because if we put it inside the build method its value never be true because whenever we press the button in the last index the build method will be called because of the setState method and the value of isLast var. will be false
  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
          image: 'assets/images/on_boarding1.jpg',
          title: 'title 1',
          body: 'body 1'),
      BoardingModel(
          image: 'assets/images/on_boarding1.jpg',
          title: 'title 2',
          body: 'body 2'),
      BoardingModel(
          image: 'assets/images/on_boarding1.jpg',
          title: 'title 3',
          body: 'body 3'),
    ];
    var boardingController = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(onTap: submit, text: 'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    // print('last');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    // print('not last');
                    setState(() {
                      isLast = true;
                    });
                  }
                },
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                      activeDotColor: Colors.deepOrange),
                ),
                Spacer(),
                FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    print(isLast);
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                '${model.image}',
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }
}
