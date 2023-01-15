
import 'dart:io';

import 'package:albaraka_management/src/modules/menu/domain_layer/repsitories/base_menu_repository.dart';
import 'package:dartz/dartz.dart';

class AddImageUseCase{
  final BaseMenuRepository baseMenuRepository;
  AddImageUseCase(this.baseMenuRepository);
  Future<Either<Exception, File>> excute(source,context)async {
    return await baseMenuRepository.addImagePicker(source,context);
  }
}