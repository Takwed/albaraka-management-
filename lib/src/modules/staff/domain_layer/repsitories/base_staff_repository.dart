import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data_layer/models/staff_model.dart';
import '../entities/member.dart';

abstract class BaseStaffRepository {

  Future<Either<FirebaseAuthException, UserCredential?>> addMemberWithEmailAndPass(
      {required String email,
        required String password,
        required String phone,
        required String name});
  Future<Either<FirebaseAuthException, bool>> removeMember(
      {required String email,
        required String password,});

  Future<Either<FirebaseAuthException, List<MemberModel>>> getStaff();
}
