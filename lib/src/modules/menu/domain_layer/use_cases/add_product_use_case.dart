import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repsitories/base_menu_repository.dart';

class AddProductToJsonUseCase{
  final BaseMenuRepository baseMenuRepository;
  AddProductToJsonUseCase(this.baseMenuRepository);
  Future<Either<Exception, void>> send(
      {required String name,
        required String describe,
        required double oldPrice,
        required double newPrice,}){
    return baseMenuRepository.addProduct(oldPrice: oldPrice,describe: describe,name: name,newPrice: newPrice);
  }

}