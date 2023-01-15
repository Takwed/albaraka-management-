import 'package:dartz/dartz.dart';
import '../repsitories/base_menu_repository.dart';

class DeleteProductsUseCase{
  final BaseMenuRepository baseMenuRepository;
  DeleteProductsUseCase(this.baseMenuRepository);
  Future<Either<Exception,  bool>> delete(List<int> ids)async{
    return await baseMenuRepository.deleteProducts(ids);
  }
}