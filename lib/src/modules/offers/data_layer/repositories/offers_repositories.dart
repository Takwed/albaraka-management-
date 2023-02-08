import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:albaraka_management/src/modules/offers/data_layer/data_sources/offers_remote_data_sources.dart';
import 'package:albaraka_management/src/modules/offers/data_layer/models/coupon_model.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/coupon.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/discount.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/free_product.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/repositories/base_offers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

class OffersRepository extends BaseOffersRepository {
  BaseOffersRemoteDataSource baseOffersRemoteDataSource;
  OffersRepository(this.baseOffersRemoteDataSource);
  @override
  Future<Either<FirebaseException, dynamic>> addCoupon(
      {required CouponModel couponModel}) {
    return baseOffersRemoteDataSource.addCoupon(couponModel: couponModel);
  }

  @override
  Future<Either<FirebaseException, dynamic>> addDiscount(
      {required int id,
      required Discount discount,
      required int collectionIndex}) {
    return baseOffersRemoteDataSource.addDiscount(
        id: id, discount: discount, collectionIndex: collectionIndex);
  }

  @override
  Future<Either<FirebaseException, dynamic>> addFreeProduct(
      {required FreeProduct freeProduct,
      required int id,
      required int collectionIndex}) {
    return baseOffersRemoteDataSource.addFreeProduct(
        freeProduct: freeProduct, id: id, collectionIndex: collectionIndex);
  }

  @override
  Future<Either<FirebaseException, List<Coupon>>> getCoupons() {
    return baseOffersRemoteDataSource.getCoupons();
  }

  @override
  Future<Either<Exception, List<ProductModel>>> getHalaweyat() async {
    print ('getHalaweyat repo ');
    return await baseOffersRemoteDataSource.getHalaweyat();
  }

  @override
  Future<Either<Exception, List<ProductModel>>> getKoshary() {
    return baseOffersRemoteDataSource.getKoshary();
  }

  @override
  Future<Either<Exception, List<ProductModel>>> getMashweyat() {
    return baseOffersRemoteDataSource.getMashweyat();
  }

  @override
  Future<Either<FirebaseException, dynamic>> removeCoupon(
      {required String id}) {
    return baseOffersRemoteDataSource.removeCoupon(id: id);
  }

  @override
  Future<Either<FirebaseException, dynamic>> removeOffer(
      {required int id,
      required ProductModel productModel,
      required int collectionIndex}) {
    return baseOffersRemoteDataSource.removeOffer(
        id: id, productModel: productModel, collectionIndex: collectionIndex);
  }
}
