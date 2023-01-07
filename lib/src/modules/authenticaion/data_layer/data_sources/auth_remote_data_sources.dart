
 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:dartz/dartz.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/local/shared_prefrences.dart';

 abstract class BaseAuthRemoteDataSource {
   Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass({
     required String email,
     required String password,
   });
   Future<Either<FirebaseAuthException, UserCredential?>>
       registerWithEmailAndPass(
           {required String email,
          required String password,
           required String name});
  Future createUser({required String name, required String uid});
   Future<Either<FirebaseAuthException, void>> forgetPassword(
       {required String email});
 }

 class AuthRemoteDataSource extends BaseAuthRemoteDataSource
 {
   @override
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async
          {
        await CacheHelper.saveData(key: 'uid', value: value.user!.uid).then((value) {
          print ("saved");
        });
      });
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, UserCredential?>>
      registerWithEmailAndPass({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential? response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        print('done');
        await createUser(name: name, uid: value.user!.uid);
        await CacheHelper.saveData(key: 'uid', value: value.user!.uid);
      });
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }
//
  @override
  Future createUser({required String name, required String uid}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({"name": name}).then((value) {
      print ('done .. ');
    }).catchError((error) {
      print(error.toString());
    });
    //throw Exception();
  }
//
  @override
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email}) async {
    print(
        "forgetPassword forgetPassword forgetPassword forgetPassword forgetPassword forgetPassword");
    try {
      void response =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Right(response);

    } on FirebaseAuthException catch (error) {
      return Left(error);
      print(error.message);
    }
    throw UnimplementedError();
   }
 }
