import 'package:shop_app/models/UserModel.dart';

abstract class ShopLoginState{}
class  ShopLoginInitialState extends ShopLoginState{}
class  ShopLoginLoadingState extends ShopLoginState{


}
class  ShopLoginSuccessState extends ShopLoginState{
  UserModel userModel;
  ShopLoginSuccessState(this.userModel);
}
class  ShopLoginErroeState extends ShopLoginState{
  final String error;

  ShopLoginErroeState(this.error);
}
class ChangeVisibilityPasswordSignInState extends ShopLoginState {}