import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../domain_layer/entities/member.dart';
import '../models/staff_model.dart';
abstract class BaseStaffRemoteDataSource {
  Future<Either<FirebaseAuthException, UserCredential?>> addMemberWithEmailAndPass(
      {required String email,
        required String password,
        required String phone,
        required String name});
  Future<Either<FirebaseAuthException, bool>> removeMember(
      {required String email,
        required String password,});
  Future createUser({required String name,required String phone, required String uid});
  Future<Either<FirebaseAuthException, List<MemberModel>>?> getStaff();

}
class StaffRemoteDataSource extends BaseStaffRemoteDataSource{
  @override
  Future<Either<FirebaseAuthException, UserCredential?>> addMemberWithEmailAndPass(
      {required String email, required String password, required String name,required String phone,}) async{
    try {
      UserCredential? response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,)
          .then((value) {
        createUser(name: name, phone: phone ,uid: value.user!.uid);
        CacheHelper.saveData(key: 'uid', value: value.user!.uid);
      });
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }



  @override
  Future createUser({required String name, required String uid,required String phone,}) async{
    await FirebaseFirestore.instance
        .collection('members')
        .doc(uid)
        .set({"name": name,"phone" : phone}).then((value) {
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Future<Either<FirebaseAuthException, bool>> removeMember({required String email, required String password}) async{
    try {
      final user = FirebaseAuth.instance.currentUser;
      AuthCredential credentials =
      EmailAuthProvider.credential(email: email, password: password);
      print(user);
      final result = await user!.reauthenticateWithCredential(credentials);
      await result.user!.delete();
      return Right(true);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }
  @override
  Future<Either<FirebaseAuthException, List<MemberModel>>?> getStaff() async{
    List<MemberModel> members = [];
    try {
      await FirebaseFirestore.instance
          .collection('members')
          .get().then((value) {
        value.docs.forEach((element) {
          members.add(MemberModel.fromJson(element.data()));
        });
        return Right(members??[]);
      });
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }
}