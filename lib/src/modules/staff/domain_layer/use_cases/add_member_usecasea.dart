import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repsitories/base_staff_repository.dart';

class addMemberWithEmailAndPassUseCase {
  final BaseStaffRepository baseStaffRepository;

  addMemberWithEmailAndPassUseCase(this.baseStaffRepository);
  Future<Either<FirebaseAuthException, UserCredential?>> excute(
      {required String email,
        required String phone,
        required String password,
        required String name}) async {
    return await baseStaffRepository.addMemberWithEmailAndPass(
        email: email, password: password, name: name, phone: phone);
  }
}
