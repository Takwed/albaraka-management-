import 'package:dartz/dartz.dart';

import '../../../menu/data_layer/models/product_model.dart';
import '../repositories/base_offers_repository.dart';

class GetKosharyUseCase {
  BaseOffersRepository baseOffersRepository;

  GetKosharyUseCase(this.baseOffersRepository);
  Future<Either<Exception, List<ProductModel>>> call() async {
    var result  =await baseOffersRepository.getKoshary();
    return result ;
  }
}
