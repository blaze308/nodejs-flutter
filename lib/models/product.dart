class Product {
  String? title;
  String? image;
  double? price;
  String? category;
  String? desc;
  String? createdAt;

  Product({
    this.title,
    this.image,
    this.price,
    this.desc,
    this.category,
    this.createdAt,
  });

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    price = json['price'];
    desc = json['desc'];
    category = json['category'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = this.id;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    data['desc'] = desc;
    data['category'] = category;
    data['createdAt'] = createdAt;
    return data;
  }
}
