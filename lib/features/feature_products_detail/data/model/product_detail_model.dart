class ProductDetailModel {
  Product? product;
  int? totalPrice;
  List<Gallery>? gallery;
  dynamic percent;
  bool? fav;
  String? brand;
  bool? checkCart;

  ProductDetailModel.fromJson(dynamic json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;

    if (json['gallerys'] != null) {
      gallery = [];
      json['gallerys'].forEach((element) {
        gallery?.add(Gallery.fromJson(element));
      });
    }

    totalPrice = json['total_price'] ?? 0;
    fav = json['fav'] ?? '';
    brand = json['brand'] ?? '';
    checkCart = json['check_cart'];
    percent = json['percent'] ?? '';
  }
}

class Gallery {
  int? id;
  String? path;

  Gallery(this.id, this.path);

  Gallery.fromJson(dynamic json) {
    id = json['id'];
    path = json['path'];
  }
}

class Product {
  int? id;
  String? title;
  String? enName;
  String? defaultPrice;
  String? deliveryPrice;
  String? image;
  String? productBody;

  Product(this.id, this.title, this.enName, this.defaultPrice,
      this.deliveryPrice, this.image);

  Product.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    enName = json['en_name'];
    defaultPrice = json['default_price'];
    deliveryPrice = json['deliver_price'];
    image = json['image'];
    productBody = json['product_body'];
  }
}
