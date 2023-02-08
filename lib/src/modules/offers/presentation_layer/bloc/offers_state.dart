part of 'offers_bloc.dart';

@immutable
abstract class OffersState extends Equatable {

}

class OffersInitial extends OffersState {
  @override
  List<Object?> get props => [];
}
class ChangeTabBarState extends OffersState {
  final int TabIndex;
  ChangeTabBarState({required this.TabIndex});
  @override
  List<Object?> get props => [TabIndex];
}
class ChangeOfferTypeState extends OffersState {
   int index;
 ChangeOfferTypeState(this.index);
  @override
  List<Object?> get props => [index];

}

class AddCouponLoadingState extends OffersState {
  @override
  List<Object?> get props => [];
}
class AddCouponSuccessState extends OffersState {

  @override
  List<Object?> get props => [];
}
class AddCouponErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}


class AddDiscountLoadingState extends OffersState {

  @override
  List<Object?> get props => [];
}
class AddDiscountSuccessState extends OffersState {

  @override
  List<Object?> get props => [];
}
class AddDiscountErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}



class AddFreeProductLoadingState extends OffersState {

  @override
  List<Object?> get props => [];
}
class AddFreeProductSuccessState extends OffersState {

  @override
  List<Object?> get props => [];
}
class AddFreeProductErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}

class GetCouponsLoadingState extends OffersState {

  @override
  List<Object?> get props => [];
}
class GetCouponsSuccessState extends OffersState {
List coupons  ;
GetCouponsSuccessState(this.coupons);
  @override
  List<Object?> get props => [];
}
class GetCouponsErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}


class GetHalaweyatLoadingState extends OffersState {

  @override
  List<Object?> get props => [];
}
class GetHalaweyatSuccessState extends OffersState {

  List <ProductModel> products ;
  List <ProductModel> productsOffers ;
  GetHalaweyatSuccessState(this.products , this.productsOffers);
  @override
  List<Object?> get props => [products , productsOffers];
}
class GetHalaweyatErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}

class GetKosharyLoadingState extends OffersState {


  @override
  List<Object?> get props => [];
}
class GetKosharySuccessState extends OffersState {
  List <ProductModel> products ;
  List <ProductModel> productsOffers ;
  GetKosharySuccessState(this.products , this.productsOffers);
  @override
  List<Object?> get props => [products , productsOffers];
}
class GetKosharyErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}

class GetMashweyatLoadingState extends OffersState {

  @override
  List<Object?> get props => [];
}
class GetMashweyatSuccessState extends OffersState {
  List <ProductModel> products ;
  List <ProductModel> productsOffers ;
  GetMashweyatSuccessState(this.products , this.productsOffers);
  @override
  List<Object?> get props => [products , productsOffers];
}
class GetMashweyatErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}

class RemoveCouponLoadingState extends OffersState {

  @override
  List<Object?> get props => [];
}
class RemoveCouponSuccessState extends OffersState {

  @override
  List<Object?> get props => [];
}
class RemoveCouponErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}

class RemoveOfferLoadingState extends OffersState {
  @override
  List<Object?> get props => [];
}
class RemoveOfferSuccessState extends OffersState {

  @override
  List<Object?> get props => [];
}
class RemoveOfferErrorState extends OffersState {

  @override
  List<Object?> get props => [];
}
class AddCouponsLoadingState extends OffersState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class AddCouponsSuccessState extends OffersState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class AddCouponsErrorState extends OffersState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
