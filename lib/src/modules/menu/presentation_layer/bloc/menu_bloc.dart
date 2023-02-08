import 'dart:async';
import 'dart:io';

import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:albaraka_management/src/modules/menu/domain_layer/use_cases/get_halaweyat_use_case.dart';
import 'package:albaraka_management/src/modules/menu/domain_layer/use_cases/get_mashweyat_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../data_layer/models/product_model.dart';
import '../../domain_layer/use_cases/add_image_use_case.dart';
import '../../domain_layer/use_cases/add_product_use_case.dart';
import '../../domain_layer/use_cases/delete_products_use_case.dart';
import '../../domain_layer/use_cases/edit_product_use_case.dart';
import '../../domain_layer/use_cases/get_koshary_use_case.dart';
import '../screens/product_details_screen.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  static MenuBloc get(BuildContext context) =>
      BlocProvider.of<MenuBloc>(context);
  File? imageFile;
  bool isSelected = false;
  bool isEdit = false;
  bool selectProduct = false;
  List<ProductModel> koshary = [];
  List<ProductModel> mashweyat = [];
  List<ProductModel> halaweyat = [];
  List<ProductModel> selectProducts = [];
  List<int> productsId = [];
  String value = "كشري";
  int changeTab = 0;
  void changeIsSelected() {
    isSelected = !isSelected;
  }
  void changeSelectProduct() {
    selectProduct = !selectProduct;
  }

  void deleteSelectProduct(List<ProductModel> product) {
      selectProducts.forEach((element) {
        product.remove(element);
      });
      isSelected = false;
  }

  void determineSelectAllProduct(List<ProductModel> product) {
    if (selectProducts.length == product.length) {
      selectProducts.clear();
      productsId.clear();
    } else {
      selectProducts.clear();
      productsId.clear();
      for (int i = 0; i < product.length; i++) {
        selectProducts.add(product[i]);
        productsId.add(i);
      }
    }
  }
  void changeIsEditProduct() {
    isEdit = !isEdit;
  }
  MenuBloc(MenuInitial menuInitial) : super(MenuInitial()) {
    on<MenuEvent>((event, emit) async {
      if (event is ImagePickedEvent) {
        final result =
            await AddImageUseCase(sl()).excute(event.source, event.context);
        result!.fold((l) {
          errorToast(msg: "you are not picked image");
          emit(ImagePickedErrorState(l.toString()));
        }, (r) {
          imageFile = r;
          emit(ImagePickedSuccessfullyState(imageFile!));
        });
      }
      else if (event is AddProductEvent) {
        final result = await AddProductToJsonUseCase(sl()).send(
          points: event.points,
          collectionIndex: event.collectionIndex,
            name: event.name, describe: event.describe, oldPrice: event.oldPrice,newPrice: event.newPrice);
        result.fold((l) {
          emit(const AddProductErrorState());
        }, (r) {
          emit(AddProductSuccessfulState(
              describe: event.describe,
              points: event.points,
              collectionIndex: event.collectionIndex,
              oldPrice: event.oldPrice,name: event.name,newPrice: event.newPrice));
          imageFile = null;
          if (event.collectionIndex == 0) {
            add(const GetKosharyEvent());
          }else if (event.collectionIndex == 1) {
            add(const GetMashweyatEvent());
          }else if (event.collectionIndex == 2) {
            add(const GetHalaweyatEvent());
          }
        });
      }

      else if (event is GetHalaweyatEvent) {
        emit(const GetHalaweyatLoadingState());
        final result = await GetHalaweyatUseCase(sl()).get();
        result.fold((l) {
          emit(const GetHalaweyatErrorState());

        }, (r) {
          halaweyat = r;
          emit( GetHalaweyatSuccessfulState(halaweyat));

        });
      }
      else if (event is GetKosharyEvent) {
        emit(const GetKosharyLoadingState());
        final result = await GetKosharyUseCase(sl()).get();
        result.fold((l) {
          emit(const GetKosharyErrorState());
        }, (r) {
          koshary = r;
          emit( GetKosharySuccessfulState(koshary));
        });
      }
      else if (event is GetMashweyatEvent) {
        emit(const GetMashweyatLoadingState());
        final result = await GetMashweyatUseCase(sl()).get();
        result.fold((l) {
          emit(const GetMashweyatErrorState());
        }, (r) {
          mashweyat = r;
          emit(GetMashweyatSuccessfulState(mashweyat));
        });
      }

      else if (event is ChangeIsSelectedEvent) {
        changeIsSelected();
        emit(ChangeIsSelectedState(isSelected));
      }
      else if (event is IsSelectedProductEvent) {
        changeSelectProduct();
        emit(IsSelectedProductState(selectProduct));
      }
      else if (event is DeleteProductEvent) {
        final res = await DeleteProductsUseCase(sl()).delete(productsId,event.collectionIndex);
        res.fold((l) {
        }, (r) {
          deleteSelectProduct(event.product);
          emit(DeleteProductState(product: event.product,collectionIndex: event.collectionIndex));
          productsId.clear();
          selectProducts.clear();
          isSelected = false;
        });
      }
      else if (event is BackToDefaultBeforeSelectEvent) {
        productsId.clear();
        selectProducts.clear();
        isSelected = false;
        emit(BackToDefaultBeforeSelectState(isSelected));
      }
      else if (event is SelectAllProductEvent) {
        determineSelectAllProduct(event.product);
        emit(SelectAllProductStates(product: event.product,
            length: selectProducts.length));
      }
      else if (event is NavagationToProductsDetailsEvent) {
        NavigationManager.push(event.context, ProductDetails(event.index,event.product,event.collectionIndex));
        emit(NavagationToProductsDetailsStates(index: event.index,
            product: event.product, context: event.context));
      }
      else if (event is EditProductEvent) {
        emit(const EditProductLoadingStates());
        final res = await EditProductUseCase(sl()).edit(
            id: event.id,
            points: event.points,
            collectionIndex: event.collectionIndex,
            name: event.name,
            describe: event.describe,
            newPrice: event.newPrice,
            oldPrice: event.oldPrice);
        res.fold((l) {
          errorToast(msg: 'msg');
          emit(const EditProductErrorStates());
        }, (r) {
          defaultToast(msg: "Product Updated Successfully");
          emit(EditProductSuccessfullyStates(
              name: event.name,
              oldPrice: event.oldPrice,
              newPrice: event.newPrice,
              describe: event.describe,
              points: event.points,
              collectionIndex: event.collectionIndex,
              id: event.id));
        });
        if (event.collectionIndex == 0) {
          add(const GetKosharyEvent());
        }else if (event.collectionIndex == 1) {
          add(const GetMashweyatEvent());
        }else if (event.collectionIndex == 2) {
          add(const GetHalaweyatEvent());
        }
        NavigationManager.pop(event.context);
      }
      else if (event is IsEditProductEvent) {
        changeIsEditProduct();
        emit(IsEditProductStates(isEdit));
      }
      else if (event is ChooseCollectionEvent) {
        value = event.value;
        emit(ChooseCollectionState(value));
      }
      else if (event is ChangeTabBarEvent) {
        changeTab = event.changeTab;
        emit(ChangeTabBarState(changeTab: changeTab));
      }
    });
  }
}
