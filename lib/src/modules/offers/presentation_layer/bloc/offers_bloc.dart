import 'dart:async';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/components/components.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/dep_injection.dart';
import '../../data_layer/models/coupon_model.dart';
import '../../domain_layer/entities/coupon.dart';
import '../../domain_layer/use_cases/add_free_product_use_case.dart';
import '../../domain_layer/use_cases/get_coupons_use_case.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  int tabIndex = 0;
  List<ProductModel> koshary = [];
  List<ProductModel> mashweyat = [];
  List<ProductModel> halaweyat = [];
  List<ProductModel> kosharyOffers = [];
  List<ProductModel> mashweyatOffers = [];
  List<ProductModel> halaweyatOffers = [];
  List<Coupon> coupons = [];
  int selectedOfferTypeIndex = 0;

  static OffersBloc get(BuildContext context) =>
      BlocProvider.of<OffersBloc>(context);
  OffersBloc(OffersInitial offersInitial) : super(OffersInitial()) {
    on<OffersEvent>((event, emit) async {
      if (event is AddCouponEvent) {
        emit(AddCouponsLoadingState());
        var result =
            await AddCouponUseCase(sl()).call(couponModel: event.couponModel);
        result.fold((l) {
          emit(AddCouponsErrorState());
          errorToast(msg: l.message!);
        }, (r) {
          emit(AddCouponsSuccessState());
        });
      } else if (event is AddDiscountEvent)
      {
        emit(AddDiscountLoadingState());
        var result = await AddDiscountUseCase(sl()).call(
            id: event.id,
            discount: event.discount,
            collectionIndex: event.collectionIndex);
        result.fold((l) {
          emit(AddDiscountErrorState());
          errorToast(msg: l.message!);

        }, (r) {
          defaultToast(msg: 'تم إضافة العرض بنجاح');
          emit(AddDiscountSuccessState());
          switch (event.collectionIndex) {
            case 0:
              add(GetKosharyEvent());
              break;
            case 1:
              add(GetMashweyatEvent());
              break;
            default:
              add(GetHalaweyatEvent());
          }
        });
      } else if (event is AddFreeProductEvent)
      {
        emit(AddFreeProductLoadingState());
       var result = await AddFreeProductUseCase(sl()).call(
            id: event.id,
            freeProduct: event.freeProduct,
            collectionIndex: event.collectionIndex);
       result.fold((l) {
         emit(AddFreeProductErrorState());
         errorToast(msg: l.message!);
       }, (r) {
         emit(AddFreeProductSuccessState());
         defaultToast(msg: 'تم إضافة العرض بنجاح');
         switch (event.collectionIndex) {
           case 0:
             add(GetKosharyEvent());
             break;
           case 1:
             add(GetMashweyatEvent());
             break;
           default:
             add(GetHalaweyatEvent());
         }
       });
      } else if (event is GetCouponsEvent)
      {
        coupons.clear();
        var result = await GetCouponsUseCase(sl()).call();
        result.fold((l) {
          errorToast(msg: l.message!);
        }, (r) {
          r.forEach((element) {
            coupons.add(element);
          });
        });
      } else if (event is GetHalaweyatEvent)
      {
        halaweyatOffers = [];
        halaweyat = [];
        emit(GetHalaweyatLoadingState());
        var result = await GetHalaweyatUseCase(sl()).call();
        result.fold((l) {
          emit(GetHalaweyatErrorState());
          errorToast(msg: l.toString());
        }, (r) {
          print(state);
          halaweyatOffers = [];
          halaweyat = [];

          r.forEach((element) {
            print(element);
            if (element.offerState != null) {
              halaweyatOffers.add(element);
            } else {
              halaweyat.add(element);
            }
          });
          emit(GetHalaweyatSuccessState(halaweyat, halaweyatOffers));
        });
      } else if (event is GetKosharyEvent)
      {
        emit(GetKosharyLoadingState());
        var result = await GetKosharyUseCase(sl()).call();
        result.fold((l) {
          emit(GetKosharyErrorState());
          errorToast(msg: l.toString());
        }, (r) {
          koshary = [];
          kosharyOffers = [];

          r.forEach((element) {
            if (element.offerState != null) {
              kosharyOffers.add(element);
            } else {
              koshary.add(element);
            }
          });
          emit(GetKosharySuccessState(koshary, kosharyOffers));
        });
      } else if (event is GetMashweyatEvent)
      {
        emit(GetMashweyatLoadingState());
        var result = await GetMashweyatUseCase(sl()).call();
        result.fold((l) {
          emit(GetMashweyatErrorState());
          errorToast(msg: l.toString());
        }, (r) {
          mashweyat = [];
          mashweyatOffers = [];

          r.forEach((element) {
            if (element.offerState != null) {
              mashweyatOffers.add(element);
            } else {
              mashweyat.add(element);
            }
          });
          emit(GetMashweyatSuccessState(mashweyat, mashweyatOffers));
        });
      } else if (event is RemoveCouponEvent) {
        RemoveCouponUseCase(sl()).call(id: event.id);
      } else if (event is RemoveOfferEvent) {
        RemoveOfferUseCase(sl()).call(
            id: event.id,
            productModel: event.productModel,
            collectionIndex: event.collectionIndex);
      } else if (event is ChangeTabBarEvent) {
        tabIndex = event.index;
        emit(ChangeTabBarState(TabIndex: tabIndex));
      } else if (event is ChangeOfferTypeEvent) {
        emit(ChangeOfferTypeState(selectedOfferTypeIndex));
        selectedOfferTypeIndex = event.index;
        emit(ChangeOfferTypeState(selectedOfferTypeIndex));
      }
    });
  }
}
