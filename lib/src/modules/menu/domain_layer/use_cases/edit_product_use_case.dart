import 'package:dartz/dartz.dart';
import '../repsitories/base_menu_repository.dart';

class EditProductUseCase{
  final BaseMenuRepository baseMenuRepository;
  EditProductUseCase(this.baseMenuRepository);
  Future<Either<Exception,  void>> edit({required int id,
    required String name,
    required String describe,
    required double oldPrice,
    required int collectionIndex,
    required double newPrice,})async{
    return await baseMenuRepository.editProduct(id: id, name: name, describe: describe, oldPrice: oldPrice,newPrice: newPrice,collectionIndex: collectionIndex);
  }
}