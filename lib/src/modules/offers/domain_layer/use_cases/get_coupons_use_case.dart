import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../entities/coupon.dart';
import '../repositories/base_offers_repository.dart';

class GetCouponsUseCase {
  BaseOffersRepository baseOffersRepository;

  GetCouponsUseCase(this.baseOffersRepository);
  Future<Either<FirebaseException, List<Coupon>>> call() {
    return baseOffersRepository.getCoupons();
  }
}
