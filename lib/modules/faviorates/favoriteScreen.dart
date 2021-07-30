import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/favorite.dart';
import 'package:shop_app/modules/Home/ShopCubit.dart';
import 'package:shop_app/modules/Home/ShopStates.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuibt,ShopStates>(
        listener: (context ,state){
          if(state is changeFavotitesSuccessState){
            if(!state.favoriteStateModel.status){
              showToast(msg: state.favoriteStateModel.message, state: toastStates.error);
            }

          }
        },
        builder: (context ,state){
          return state ==GetFavoritesLoadingState()?Center(child: CircularProgressIndicator(),):ListView.separated(itemBuilder:(context,index)=> FavoriteItem(context,ShopCuibt.get(context).myFavorite.data.products[index].productInfo),
              separatorBuilder:(context,index)=> Divider(),
              itemCount: ShopCuibt.get(context).myFavorite.data.products.length );
        });
  }
  Widget FavoriteItem(BuildContext context,ProductInfo item)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 120.0,
        height: 120.0,
        child: Row(


            crossAxisAlignment: CrossAxisAlignment.start,


            children: [
            Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
        Image(
        image: NetworkImage(item.image),
        width: 120.0,
        height: 120.0,
      ),
      if (item.discount != 0)Container(
  color: Colors.red,
  padding: EdgeInsets.symmetric(horizontal: 5.0),
  child: Text('DISCOUNT',
  style: TextStyle(
  backgroundColor: Colors.red,
  color: Colors.white,
  fontSize: 8.0,
  ))),
  ],
  ),
  SizedBox(height: 20.0,),
  Expanded(
  child: Padding(
  padding: const EdgeInsets.all(12.0),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  item.name,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(height: 1.3, fontSize: 14.0),
  ),
  Spacer(),
  Row(
  children: [
  Text(
  '${item.price.round()}',
  style: TextStyle(fontSize: 14.0, color: colorAcc),
  ),
  SizedBox(width: 5.0),
  if (item.discount != 0)
  Text(
  '${item.oldPrice.round()}',
  style: TextStyle(
  fontSize: 10.0,
  color: Colors.grey,
  decoration: TextDecoration.lineThrough),
  ),
  Spacer(),
  IconButton(
  padding: EdgeInsets.all(0.0),
  icon: CircleAvatar(
  radius: 15.0,
  backgroundColor:
  ShopCuibt.get(context).favorites[item.id]? colorAcc: Colors.grey,
  child: Icon(Icons.favorite_border,
  color: Colors.white, size: 14.0)),
  onPressed: () {
  ShopCuibt.get(context).changeFavorites(item.id);
  }),
  ],
  ),
  ],
  ),
  ),
  ),
  ],
  ),
  ),
  );
}
