import 'package:albaraka_management/src/modules/menu/data_layer/data_sources/menu_remote_data_source.dart';
import 'package:albaraka_management/src/modules/offers/data_layer/models/coupon_model.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/coupon.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/discount.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/free_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../menu/data_layer/models/product_model.dart';
import '../../../menu/domain_layer/entities/product.dart';

abstract class BaseOffersRemoteDataSource {
  Future<Either<FirebaseException, dynamic>> addDiscount({required String id, required Discount discount, required int collectionIndex});
  Future<Either<FirebaseException, dynamic>>  addFreeProduct ({required
  FreeProduct freeProduct ,required String id  , required int collectionIndex });
  Future<Either<FirebaseException, dynamic>> removeDiscount({required String id, required ProductModel productModel, required int collectionIndex});
  Future<Either<FirebaseException, dynamic>> addCoupon({required CouponModel couponModel});
  Future<Either<FirebaseException, dynamic>> removeCoupon({required String id});
  Future<Either<FirebaseException, List<List>>> getCoupons();
}

class OffersRemoteDataSource extends BaseOffersRemoteDataSource {
  @override
  Future<Either<FirebaseException, dynamic>> addDiscount(
      {required String id,
      required Discount discount,
      required int collectionIndex}) async {
         discount.productModel.offerState =  ' خصم ${discount.discount}%';

    discount.productModel.newPrice = discount.productModel.oldPrice - (discount.discount / 100);
    try {
      _updateProduct(collectionIndex, discount.productModel, id);

      return const Right(0);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, dynamic>> removeDiscount(
      {required String id,
      required ProductModel productModel,
      required int collectionIndex}) async {
    try {
      productModel.offerState = null ;
      productModel.newPrice = productModel.oldPrice;

      await _updateProduct(collectionIndex, productModel, id);
      return const Right(0);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }



  @override
  Future<Either<FirebaseException, dynamic>> addCoupon(
      {required CouponModel couponModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('coupons')
          .add(couponModel.toJson());
      return const Right(true);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }


  @override
  Future<Either<FirebaseException, dynamic>> removeCoupon(
      {required String id}) async {
    try {
      await FirebaseFirestore.instance.doc('coupons/$id').delete();
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, List<List>>> getCoupons() async {
    List<String> ids = [];
    List<Coupon> coupons = [];
    try {
      await FirebaseFirestore.instance
          .collection('coupons')
          .get()
          .then((value) {
        for (var element in value.docs) {
          ids.add(element.id);
          coupons.add(CouponModel.fromJson(element.data()));
        }
      });
      return Right([coupons, ids]);
    } on FirebaseException catch (error)
    {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, dynamic>> addFreeProduct({required FreeProduct freeProduct ,required
  String id , required int collectionIndex }) {

   freeProduct.product.offerDetails = freeProduct.offerDetails ;
   freeProduct.state =  '${freeProduct.quantity} +هدية ' ;
   freeProduct.product.offerDetails = freeProduct.offerDetails ;
   freeProduct.product.quantity = freeProduct.quantity;
   _updateProduct(collectionIndex, freeProduct.product, id);

    throw UnimplementedError();
  }
 /// private methods
  Future<void> _updateProduct(int collectionIndex, ProductModel productModel, String id) async {
    if (collectionIndex == 0) {
      await FirebaseFirestore.instance
          .collection("koshary")
          .doc(id)
          .set(productModel.toJson());
    } else if (collectionIndex == 1) {
      await FirebaseFirestore.instance
          .collection("mashweyat")
          .doc(id)
          .set(productModel.toJson());
    } else if (collectionIndex == 2) {
      await FirebaseFirestore.instance
          .collection("halaweyat")
          .doc()
          .set(productModel.toJson());
    }
  }




}
