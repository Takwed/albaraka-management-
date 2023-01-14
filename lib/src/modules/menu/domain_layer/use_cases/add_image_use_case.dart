
import 'dart:io';

import 'package:albaraka_management/src/modules/menu/domain_layer/repsitories/base_menu_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddImageUseCase{
  final BaseMenuRepository baseMenuRepository;
  AddImageUseCase(this.baseMenuRepository);
  Future<Either<FirebaseAuthException, File>> excute(source,context)async {
    return await baseMenuRepository.addImagePicker(source,context);
  }
}