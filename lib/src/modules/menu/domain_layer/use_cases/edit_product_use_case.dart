import 'package:dartz/dartz.dart';
import '../repsitories/base_menu_repository.dart';

class EditProductUseCase{
  final BaseMenuRepository baseMenuRepository;
  EditProductUseCase(this.baseMenuRepository);
  Future<Either<Exception,  void>> edit({required int id,
    required String name,
    required String describe,
    required double oldPrice,
    required double points,
    required int collectionIndex,
    String? offerDetails,
    String? offerState,
    int? quantity,
    required double newPrice,})async{
    return await baseMenuRepository.editProduct(id: id, name: name, describe: describe, collectionIndex: collectionIndex, oldPrice: oldPrice,
        points: points, newPrice: newPrice, offerDetails: offerDetails!, offerState: offerState!, quantity: quantity!);
  }
}