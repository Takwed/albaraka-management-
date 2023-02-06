import 'package:dartz/dartz.dart';

import '../../../menu/data_layer/models/product_model.dart';
import '../repositories/base_offers_repository.dart';

class GetMashweyatUseCase {
  BaseOffersRepository baseOffersRepository;

  GetMashweyatUseCase(this.baseOffersRepository);
  Future<Either<Exception, List<ProductModel>>> call() {
    return baseOffersRepository.getMashweyat();
  }
}
