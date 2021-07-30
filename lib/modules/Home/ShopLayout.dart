import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Home/ShopCubit.dart';
import 'package:shop_app/modules/Home/ShopStates.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
class ShopLayout extends StatelessWidget {
  static const String Shop_SCREEN = 'nav_bar';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuibt,ShopStates>(listener: (context,state){},builder: (context,state){
      var cubit=ShopCuibt.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: cubit.bottonWidgets[cubit.currentIndexView] ,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            cubit.changeBottom(index);
          },
          currentIndex: cubit.currentIndexView,
          selectedItemColor: colorAcc,
          backgroundColor: Colors.grey,
          showUnselectedLabels: true,
          // unselectedLabelStyle: TextStyle(color: Colors.red,fontSize: 20),
          unselectedItemColor: Colors.black,
          items: [
              BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_rounded), label: 'Home'),
              BottomNavigationBarItem(icon:  Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Faviorate'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),],


        ),


      );
    });
  }
}
