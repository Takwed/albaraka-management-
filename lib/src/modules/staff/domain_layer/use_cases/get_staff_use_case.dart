import 'package:albaraka_management/src/modules/staff/domain_layer/entities/member.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data_layer/models/staff_model.dart';
import '../repsitories/base_staff_repository.dart';

class GetStaffUseCase {
  final BaseStaffRepository baseStaffRepository;

  GetStaffUseCase(this.baseStaffRepository);

  Future<Either<FirebaseAuthException, List<MemberModel>>> excute() async {
    return await baseStaffRepository.getStaff();
  }}