import 'package:albaraka_management/src/modules/menu/domain_layer/entities/product.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/offer.dart';

import '../../../menu/data_layer/models/product_model.dart';

class Discount extends Offer {
  final int discount;
  final ProductModel productModel;

  Discount(
      {required this.discount,
      required this.productModel,
      required String state})
      : super(state: state);
}
