import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/favoritesModel.dart';

abstract class ShopStates{}
class initialShopState extends ShopStates{}
class changeNaviState extends ShopStates{}
class  ShopStatesLoadingState extends ShopStates{}
class  ShopStatesSuccessState extends ShopStates{}
class  ShopStatesErroeState extends ShopStates{
  final String error;

  ShopStatesErroeState(this.error);
}
class  ShopCategoriesSuccessState extends ShopStates{}
class  ShopCategoriesErroeState extends ShopStates{
  final String error;

  ShopCategoriesErroeState(this.error);
}
class  changeFavotitesSuccessState extends ShopStates{
  FavoriteStateModel favoriteStateModel;
  changeFavotitesSuccessState(this.favoriteStateModel);
}
class  changeFavotitesErroeState extends ShopStates{
  final String error;

  changeFavotitesErroeState(this.error);
}
class  changeFavotitesLoadingState extends ShopStates{}
class  GetFavoritesSuccessState extends ShopStates{}
class  GetFavoritesLoadingState extends ShopStates{}
class  GetFavoritesErroeState extends ShopStates{
  final String error;

  GetFavoritesErroeState(this.error);
}
class  GetUserModelSuccessState extends ShopStates{}
class  GetUserModelLoadingState extends ShopStates{}
class  GetUserModelErroeState extends ShopStates{
  final String error;

  GetUserModelErroeState(this.error);
}

