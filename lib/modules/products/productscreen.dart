import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/Home/ShopCubit.dart';
import 'package:shop_app/modules/Home/ShopStates.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
class ProductScreen extends StatelessWidget {
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
          return ShopCuibt.get(context).homeModel != null &&  ShopCuibt.get(context).categoriesModel != null? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                productBuilder(ShopCuibt.get(context).homeModel,ShopCuibt.get(context).categoriesModel,context),
              ],
            ),
          ):Center(child: CircularProgressIndicator(),);

        });

  }

  Widget productBuilder(HomeModel model ,CategoriesModel categoriesModel , BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data.banners.map((e) => Image(image: NetworkImage('${e.image}'),width: double.infinity,fit: BoxFit.cover,) ).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w800),),
              SizedBox(height: 10.0),
              Container(
                height: 100.0,
                child: ListView.separated(

                    itemBuilder: (context,index)=>BuildCategoryItem(categoriesModel.data.data[index]),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context,index)=>SizedBox(width:10.0),
                    itemCount: categoriesModel.data.data.length),
              ),
              SizedBox(height: 20.0),
              Text('New products',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w800),),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          color: Colors.grey[200],
          child: GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1/1.72,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            children: List.generate(model.data.products.length, (index) => buildProductItem(model.data.products[index],context)),),
        ),

      ],
    );

  }
  Widget BuildCategoryItem(DataModel item)=>Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage('${item.image}'),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100.0,
        child: Text('${item.name}',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
      ),

    ],);
  Widget buildProductItem(ProductModel item ,BuildContext context){
    return Container(
      color: Colors.white,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [

              Image(
                image: NetworkImage(item.image),
                width: double.infinity,
                height: 200.0,

              ),
              if(item.discount!=0)
                Container(
                color:Colors.red ,
                padding: EdgeInsets.symmetric(horizontal: 5.0),child: Text('DISCOUNT',style:TextStyle(backgroundColor:Colors.red,color: Colors.white,fontSize: 8.0,))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3,fontSize: 14.0),),
                Row(
                  children: [
                    Text('${item.price.round()}',
                      style: TextStyle(fontSize: 14.0,color: colorAcc),
                    ),
                    SizedBox(width:5.0),
                    if(item.discount!=0)
                      Text('${item.oldPrice.round()}',style: TextStyle(fontSize: 10.0,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                    Spacer(),
                    IconButton(padding:EdgeInsets.all(0.0),
                      icon: CircleAvatar(radius:15.0,backgroundColor: ShopCuibt.get(context).favorites[item.id]?colorAcc: Colors.grey,
                      child: Icon(Icons.favorite_border,color: Colors.white,size: 14.0)), onPressed: (){
                      ShopCuibt.get(context).changeFavorites(item.id);
                    }),

                  ],
                ),
              ],
            ),
          ),

      ],),
    );

  }
  
}
