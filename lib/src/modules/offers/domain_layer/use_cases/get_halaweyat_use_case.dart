import 'package:dartz/dartz.dart';

import '../../../menu/data_layer/models/product_model.dart';
import '../repositories/base_offers_repository.dart';

class GetHalaweyatUseCase {
  BaseOffersRepository baseOffersRepository;

  GetHalaweyatUseCase(this.baseOffersRepository);
  Future<Either<Exception, List<ProductModel>>> call() async {

var result  =await baseOffersRepository.getHalaweyat();
print ('getHalaweyat use case ' +result.toString());
    return result;


  }
}
