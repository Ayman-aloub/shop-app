import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/onboardingScreen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


import 'modules/Home/ShopCubit.dart';
import 'modules/Home/ShopLayout.dart';
import 'modules/Login/LoginScreen.dart';
import 'shared/network/local/shared_pref.dart';
import 'shared/styles/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initialDio();
  await StoragePref.getInstance();
  token = StoragePref.getValue('token');
  String _routeName ;
  bool isOnboarding=StoragePref.getValue('onboarding')??false;
  if (isOnboarding == true) {
    if (token != null) {
      _routeName = ShopLayout.Shop_SCREEN;
    } else {
      _routeName = LoginScreen.SIGN_IN_SCREEN;
    }
  } else {
    _routeName = onboardingScreen.BOARDING_SCREEN;
  }

  runApp(MyApp(routeName:  _routeName));
}

class MyApp extends StatelessWidget {
  String routeName ;
  MyApp({this.routeName});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //String _routeName = (isOnboarding==true)?LoginScreen.SIGN_IN_SCREEN: onboardingScreen.BOARDING_SCREEN;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> ShopCuibt()..getHomeData()..getCategoriesModel()..getFavorite()..getUserModel()),
      ],
      child: MaterialApp(
        initialRoute: routeName,
        routes: {
          onboardingScreen.BOARDING_SCREEN: (_) => onboardingScreen(),
          LoginScreen.SIGN_IN_SCREEN: (_) => LoginScreen(),
          ShopLayout.Shop_SCREEN:(_)=>ShopLayout(),

        },
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        darkTheme: themeDark,
        title: 'Flutter Demo',
        //home: isOnboarding?LoginScreen():onboardingScreen(),
      ),
    );
  }

}

