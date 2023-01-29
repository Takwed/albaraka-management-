import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:albaraka_management/src/modules/menu/domain_layer/entities/product.dart';
import 'offer.dart';

class FreeProduct extends Offer
{
  final ProductModel product;
  final String offerDetails ;
  int quantity ;

  FreeProduct ({required this.product,required this.quantity ,required super.state , required this.offerDetails});
}
