class GetFavorite {
  bool status;
  FavoriteData data;

  GetFavorite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoriteData.fromJson(json['data']);
  }
}

class FavoriteData {
  List<Data> products = [];

  FavoriteData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      products.add(Data.fromJson(element));
    });
  }
}

class Data {
  ProductInfo productInfo;

  Data.fromJson(Map<String, dynamic> json) {
    productInfo = ProductInfo.fromJson(json['product']);
  }
}

class ProductInfo {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  bool inFavorites;
  bool inCart;

  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}