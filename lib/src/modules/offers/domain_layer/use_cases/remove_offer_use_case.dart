import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/repositories/base_offers_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class RemoveOfferUseCase {
  BaseOffersRepository baseOffersRepository;

  RemoveOfferUseCase(this.baseOffersRepository);
  Future<Either<FirebaseException, dynamic>> call(
      {required int id,
      required ProductModel productModel,
      required int collectionIndex}) {
    return baseOffersRepository.removeOffer(
        id: id, productModel: productModel, collectionIndex: collectionIndex);
  }
}
