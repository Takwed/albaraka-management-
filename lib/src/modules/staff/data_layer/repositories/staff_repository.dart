import 'package:albaraka_management/src/modules/staff/domain_layer/entities/member.dart';
import 'package:albaraka_management/src/modules/staff/domain_layer/repsitories/base_staff_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';

import '../data_sources/staff_remote_data_source.dart';
import '../models/staff_model.dart';

class StaffRepository extends BaseStaffRepository{
  late  BaseStaffRemoteDataSource baseStaffRemoteDataSource;

  StaffRepository(this.baseStaffRemoteDataSource);

  @override
  Future<Either<FirebaseAuthException, UserCredential?>> addMemberWithEmailAndPass(
      {required String email, required String password, required String name,required String phone,}) {
    return baseStaffRemoteDataSource.addMemberWithEmailAndPass(
        email: email, password: password, name: name, phone: phone );
  }
  @override
  Future<Either<FirebaseAuthException, bool>> removeMember(
      {required String email,
        required String password,}) {
    return baseStaffRemoteDataSource.removeMember(email: email, password: password);
  }

  @override
  Future<Either<FirebaseAuthException, List<MemberModel>>?> getStaff()async {
    dynamic res = await baseStaffRemoteDataSource.getStaff();
    print(res);
    return await baseStaffRemoteDataSource.getStaff();
  }

}