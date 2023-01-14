import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repsitories/base_staff_repository.dart';
class RemoveMemberWithEmailAndPassUseCase {
  final BaseStaffRepository baseStaffRepository;

  RemoveMemberWithEmailAndPassUseCase(this.baseStaffRepository);
  Future<Either<FirebaseAuthException, bool>> excute(
      {required String email,
        required String password,}) async {
    return await baseStaffRepository.removeMember(email: email, password: password);
  }
}
