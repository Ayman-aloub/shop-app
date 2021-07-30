import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/UserModel.dart';
import 'package:shop_app/modules/Login/cuibt/states.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../LoginScreen.dart';

class ShopLoginCuibt extends Cubit<ShopLoginState>{
  ShopLoginCuibt() : super(ShopLoginInitialState());
  static ShopLoginCuibt get(context)=>BlocProvider.of(context);
  bool isSecure =true;
  UserModel userModel;
  Icon icon = Icon(Icons.visibility_off_outlined);
  void changeVisibilityIcon() {
    isSecure = !isSecure;
    isSecure
        ? icon = Icon(Icons.visibility_off_outlined)
        : icon = Icon(Icons.visibility_outlined);
      emit(ChangeVisibilityPasswordSignInState());

  }
  void userLogin({@required final String email,@required final String password}){

    emit(ShopLoginLoadingState());
    DioHelper.postData(endPointUrl: END_POINT_SIGN_IN, data: {
      'email':email,
      'password':password,
    }).then((value){
      print(value);
      userModel =UserModel.fromJsonLogin(value.data);
      //print(userModel.dataLogin.token);
      emit(ShopLoginSuccessState(userModel));

    }).catchError((e){print(e.toString());emit(ShopLoginErroeState(e.toString()));});

  }

}