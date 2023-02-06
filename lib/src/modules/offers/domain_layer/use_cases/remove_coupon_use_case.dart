import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../repositories/base_offers_repository.dart';

class RemoveCouponUseCase {
  BaseOffersRepository baseOffersRepository;

  RemoveCouponUseCase(this.baseOffersRepository);
  Future<Either<FirebaseException, dynamic>> call({required String id}) {
    return baseOffersRepository.removeCoupon(id: id);
  }
}
