import '../../domain_layer/entities/product.dart';
class ProductModel extends Product {
   ProductModel(
      {super.image,
      required super.name,
      required super.describe,
      required super.price});
  factory ProductModel.fromJson(Map <String , dynamic> json) {
    return ProductModel(
        image: json['image'],
        name: json['name'],
        describe: json['describe'],
        price: json['price']);
  }
  Map<String, dynamic> toJson(){
    return {
      'image' : image,
      'name' : name,
      'describe' : describe,
      'price' : price,
    };
  }
}
