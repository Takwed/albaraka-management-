import '../../domain_layer/entities/product.dart';
class ProductModel extends Product {
   ProductModel(
      {super.image,
      required super.name,
      required super.newPrice,
      required super.describe,
      required super.oldPrice});
  factory ProductModel.fromJson(Map <String , dynamic> json) {
    return ProductModel(
        image: json['image'],
        name: json['name'],
        describe: json['describe'],
        oldPrice: json['oldPrice'],
        newPrice: json['newPrice']);
  }
  Map<String, dynamic> toJson(){
    return {
      'image' : image,
      'name' : name,
      'describe' : describe,
      'oldPrice' : oldPrice,
      'newPrice' : newPrice,
    };
  }
}
