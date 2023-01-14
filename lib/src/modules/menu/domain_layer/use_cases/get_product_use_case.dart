import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data_layer/models/product_model.dart';
import '../repsitories/base_menu_repository.dart';

class GetProductsUseCase{
  final BaseMenuRepository baseMenuRepository;
  GetProductsUseCase(this.baseMenuRepository);
  Future<Either<FirebaseAuthException,  List<ProductModel>>> get()async{
    return await baseMenuRepository.getProducts();
  }
}