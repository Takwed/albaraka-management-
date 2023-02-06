part of 'offers_bloc.dart';

@immutable
abstract class OffersState {

}

class OffersInitial extends OffersState {}

class AddCouponLoadingState extends OffersState {}
class AddCouponSuccessState extends OffersState {}
class AddCouponErrorState extends OffersState {}


class AddDiscountLoadingState extends OffersState {}
class AddDiscountSuccessState extends OffersState {}
class AddDiscountErrorState extends OffersState {}



class AddFreeProductLoadingState extends OffersState {}
class AddFreeProductSuccessState extends OffersState {}
class AddFreeProductErrorState extends OffersState {}

class GetCouponsLoadingState extends OffersState {}
class GetCouponsSuccessState extends OffersState {}
class GetCouponsErrorState extends OffersState {}


class GetHalaweyatLoadingState extends OffersState {}
class GetHalaweyatSuccessState extends OffersState {}
class GetHalaweyatErrorState extends OffersState {}

class GetKosharyLoadingState extends OffersState {}
class GetKosharySuccessState extends OffersState {}
class GetKosharyErrorState extends OffersState {}

class GetMashweyatLoadingState extends OffersState {}
class GetMashweyatSuccessState extends OffersState {}
class GetMashweyatErrorState extends OffersState {}

class RemoveCouponLoadingState extends OffersState {}
class RemoveCouponSuccessState extends OffersState {}
class RemoveCouponErrorState extends OffersState {}

class RemoveOfferLoadingState extends OffersState {}
class RemoveOfferSuccessState extends OffersState {}
class RemoveOfferErrorState extends OffersState {}
