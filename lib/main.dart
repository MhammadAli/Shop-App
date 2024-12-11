import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/layout/home_layout.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/layout/news_app/news_layout.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/modules/shop_app/on_boarding/onboarding_screen.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/shared/styles/themes.dart';

import 'shared/block_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //it runs the applications after everything in the method is done.
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  // final bool isDark = CacheHelper.getData(key: 'isDark');

  late final widget;
  final bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  final String? token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null){
    if(token != null){
      widget = ShopLayout();
    }
    else{
      widget = ShopLoginScreen();
    }

  }
  else{
    widget = OnBoardingScreen();
  }


  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  final Widget startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        // themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home:startWidget,
      ),
    );
  }
}
