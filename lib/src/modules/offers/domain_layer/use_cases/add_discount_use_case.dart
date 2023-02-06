import 'package:albaraka_management/src/modules/offers/domain_layer/entities/discount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../repositories/base_offers_repository.dart';

class AddDiscountUseCase {
  BaseOffersRepository baseOffersRepository;

  AddDiscountUseCase(this.baseOffersRepository);
  Future<Either<FirebaseException, dynamic>> call(
      {required int id,
      required Discount discount,
      required int collectionIndex}) async {
    return baseOffersRepository.addDiscount(
        id: id, discount: discount, collectionIndex: collectionIndex);
  }
}
