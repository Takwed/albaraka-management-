part of 'offers_bloc.dart';

@immutable
abstract class OffersEvent extends Equatable {}

class AddCouponEvent extends OffersEvent {
  CouponModel couponModel;
  AddCouponEvent(this.couponModel);

  @override

  List<Object?> get props => [couponModel];
}

class AddDiscountEvent extends OffersEvent {
  //id: id, discount: discount, collectionIndex: collectionIndex
  int id;
  Discount discount;
  int collectionIndex;
  AddDiscountEvent(
      {required this.discount,
      required this.id,
      required this.collectionIndex});

  @override
  List<Object?> get props => [id, collectionIndex, discount];
}

class AddFreeProductEvent extends OffersEvent {
  //freeProduct: freeProduct, id: id,
  //         collectionIndex: collectionIndex)
  int id;
  FreeProduct freeProduct;
  int collectionIndex;
  AddFreeProductEvent(
      {required this.id,
      required this.freeProduct,
      required this.collectionIndex});

  @override
  List<Object?> get props => [id, freeProduct, collectionIndex];
}

class GetCouponsEvent extends OffersEvent {
  GetCouponsEvent();

  @override
  List<Object?> get props => [];
}

class GetHalaweyatEvent extends OffersEvent {
  GetHalaweyatEvent();
  @override
  List<Object?> get props => [];
}

class GetKosharyEvent extends OffersEvent {
  GetKosharyEvent();

  @override
  List<Object?> get props => [];
}

class GetMashweyatEvent extends OffersEvent {
  GetMashweyatEvent();

  @override
  List<Object?> get props => [];
}

class RemoveCouponEvent extends OffersEvent {
  String id;
  RemoveCouponEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class RemoveOfferEvent extends OffersEvent {
  // required int id , required ProductModel productModel , required int collectionIndex
  int id;
  ProductModel productModel;
  int collectionIndex;
  RemoveOfferEvent(
      {required this.id,
      required this.productModel,
      required this.collectionIndex});
  @override
  List<Object?> get props => [id, productModel, collectionIndex];
}
