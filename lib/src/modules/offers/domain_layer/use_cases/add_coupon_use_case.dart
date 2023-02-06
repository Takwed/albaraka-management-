import 'package:albaraka_management/src/modules/offers/data_layer/models/coupon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../repositories/base_offers_repository.dart';

class AddCouponUseCase {
  BaseOffersRepository baseOffersRepository;

  AddCouponUseCase(this.baseOffersRepository);
  Future<Either<FirebaseException, dynamic>> call(
      {required CouponModel couponModel}) {
    return baseOffersRepository.addCoupon(couponModel: couponModel);
  }
}
