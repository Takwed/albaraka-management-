import 'package:albaraka_management/src/modules/offers/domain_layer/entities/free_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../repositories/base_offers_repository.dart';

class AddFreeProductUseCase {
  BaseOffersRepository baseOffersRepository;

  AddFreeProductUseCase(this.baseOffersRepository);
  Future<Either<FirebaseException, dynamic>> call(
      {required int id,
      required FreeProduct freeProduct,
      required int collectionIndex}) {
    return baseOffersRepository.addFreeProduct(
        freeProduct: freeProduct, id: id, collectionIndex: collectionIndex);
  }
}
