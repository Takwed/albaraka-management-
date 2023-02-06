import '../../domain_layer/entities/product.dart';
class ProductModel extends Product {
   ProductModel(
      {String ? image,
      required String name,
      String ? imagePaths,
      required double newPrice,
      required String describe,
      required double points,
        String ? offerState ,
        String ? offerDetails ,
        int ? quantity ,
        required double oldPrice , }) : super (describe: describe , imagePaths: imagePaths,   name: name , newPrice: newPrice
       , oldPrice: oldPrice , points: points , image: image  ,  offerState: offerState );
  factory ProductModel.fromJson(Map <String , dynamic> json) {
    return ProductModel(
        image: json['image'],
        name: json['name'],
        imagePaths: json['imagePaths'],
        describe: json['describe'],
        points: json['points'],
        oldPrice: json['oldPrice'],
        newPrice: json['newPrice']);
  }
  Map<String, dynamic> toJson(){
    return {
      'image' : image,
      'name' : name,
      'imagePaths' : imagePaths,
      'describe' : describe,
      'oldPrice' : oldPrice,
      'points' : points,
      'newPrice' : newPrice,
    };
  }
}
