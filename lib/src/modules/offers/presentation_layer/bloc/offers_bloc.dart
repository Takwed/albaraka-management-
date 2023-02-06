import 'dart:async';
import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/discount.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/free_product.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/use_cases/add_coupon_use_case.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/use_cases/add_discount_use_case.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/use_cases/get_halaweyat_use_case.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/use_cases/get_koshary_use_case.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/use_cases/get_mashweyat_use_case.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/use_cases/remove_coupon_use_case.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/use_cases/remove_offer_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/dep_injection.dart';
import '../../data_layer/models/coupon_model.dart';
import '../../domain_layer/use_cases/add_free_product_use_case.dart';
import '../../domain_layer/use_cases/get_coupons_use_case.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersBloc() : super(OffersInitial()) {
    on<OffersEvent>((event, emit) {
      if (event is AddCouponEvent) {
        AddCouponUseCase(sl()).call(couponModel: event.couponModel);
      } else if (event is AddDiscountEvent) {
        AddDiscountUseCase(sl()).call(
            id: event.id,
            discount: event.discount,
            collectionIndex: event.collectionIndex);
      } else if (event is AddFreeProductEvent) {
        AddFreeProductUseCase(sl()).call(
            id: event.id,
            freeProduct: event.freeProduct,
            collectionIndex: event.collectionIndex);
      } else if (event is GetCouponsEvent) {
        GetCouponsUseCase(sl()).call();
      } else if (event is GetHalaweyatEvent) {
        GetHalaweyatUseCase(sl()).call();
      } else if (event is GetKosharyEvent) {
        GetKosharyUseCase(sl()).call();
      } else if (event is GetMashweyatEvent) {
        GetMashweyatUseCase(sl()).call();
      } else if (event is RemoveCouponEvent) {
        RemoveCouponUseCase(sl()).call(id: event.id);
      } else if (event is RemoveOfferEvent) {
        RemoveOfferUseCase(sl()).call(
            id: event.id,
            productModel: event.productModel,
            collectionIndex: event.collectionIndex);
      }
    });
  }
}
