class Product {
  String? title;
  String? image;
  double? price;
  String? desc;
  String? category;

  Product({this.title, this.image, this.price, this.desc, this.category});

  Product.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    desc = json['desc'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = this.id;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    data['desc'] = desc;
    data['category'] = category;
    return data;
  }
}
