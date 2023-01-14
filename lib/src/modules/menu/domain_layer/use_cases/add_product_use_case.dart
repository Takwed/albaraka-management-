import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repsitories/base_menu_repository.dart';

class AddProductToJsonUseCase{
  final BaseMenuRepository baseMenuRepository;
  AddProductToJsonUseCase(this.baseMenuRepository);
  Future<Either<FirebaseAuthException, void>> send(
      {required String name,
        required String describe,
        required int price,}){
    return baseMenuRepository.addProductToJson(price: price,describe: describe,name: name);
  }

}