import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/UserModel.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/modules/Home/ShopStates.dart';
import 'package:shop_app/modules/categories/categoriesScrren.dart';
import 'package:shop_app/modules/faviorates/favoriteScreen.dart';
import 'package:shop_app/modules/products/productscreen.dart';
import 'package:shop_app/modules/settings/settingScreen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCuibt extends Cubit<ShopStates>{
  ShopCuibt() : super(initialShopState());
  HomeModel homeModel;
  CategoriesModel categoriesModel;
  Map<int , bool> favorites={};
  void getHomeData(){
    DioHelper.getData(endPointUrl: END_POINT_HOME ,token: token).then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites
        });
      });
      //print(favorites.toString());
      emit(ShopStatesSuccessState());
    }
    ).catchError((e){
      print(e.toString());
      emit(ShopStatesErroeState(e.toString()));
    });
  }
  void getCategoriesModel(){
    DioHelper.getData(endPointUrl: END_POINT_CATEGORY ,token: token).then((value){
      //printWrapped(value.toString());


      categoriesModel=CategoriesModel.fromJson(value.data  );

      //printWrapped(homeModel.data.products.toString());
      emit(ShopCategoriesSuccessState());
    }
    ).catchError((e){
      print(e.toString());
      emit(ShopCategoriesErroeState(e.toString()));
    });
  }
  static ShopCuibt get(context)=>BlocProvider.of(context);
  int currentIndexView=0;
  List<Widget> bottonWidgets=[
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),

  ];
  void changeBottom(int index)
  {
    currentIndexView=index;
    emit(changeNaviState());
  }
  FavoriteStateModel favoriteStateModel;
  void changeFavorites(int id){
    favorites[id]=!favorites[id];
    emit(changeFavotitesLoadingState());
    DioHelper.postData(endPointUrl: END_POINT_FAVORITE, data: {'product_id': id},token: token)
        .then((value) {
          favoriteStateModel=FavoriteStateModel.fromJson(value.data);
          if(!favoriteStateModel.status){
            favorites[id]=!favorites[id];

          }else{
            getFavorite();

          }
          emit(changeFavotitesSuccessState(favoriteStateModel));


        })
    .catchError((e){
      favorites[id]=!favorites[id];
      emit(changeFavotitesErroeState(e));});
  }
  GetFavorite myFavorite;
  void getFavorite(){
    //print(token);
    emit(GetFavoritesLoadingState());
    DioHelper.getData(endPointUrl: END_POINT_FAVORITE ,token: token).then((value){
      //printWrapped(value.toString());


      myFavorite=GetFavorite.fromJson(value.data  );

      //printWrapped(homeModel.data.products.toString());
      emit(GetFavoritesSuccessState());
    }
    ).catchError((e){
      print(e.toString());
      emit(GetFavoritesErroeState(e.toString()));
    });
  }
  UserModel userModel;
  void getUserModel(){
   // print(token);
    emit(GetUserModelLoadingState());
    DioHelper.getData(endPointUrl: END_POINT_PROFILE ,token: token).then((value){
    //  printWrapped(value.toString());


     // userModel=UserModel.fromJsonLogin(value.data);

      printWrapped(userModel.toString());
      emit(GetUserModelSuccessState());
    }
    ).catchError((e){
      print(e.toString());
      emit(GetUserModelErroeState(e.toString()));
    });
  }
}