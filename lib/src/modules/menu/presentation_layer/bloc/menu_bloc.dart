import 'dart:async';
import 'dart:io';

import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:albaraka_management/src/modules/menu/domain_layer/use_cases/get_product_use_case.dart';
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
  bool deleteProduct = false;
  bool selectAllProduct = false;
  List<ProductModel> products = [];
  List<ProductModel> selectProducts = [];
  List<int> productsId = [];
  void changeIsSelected() {
    isSelected = !isSelected;
  }

  void changeSelectProduct() {
    selectProduct = !selectProduct;
  }

  void deleteSelectProduct() {
    deleteProduct = !deleteProduct;
    if (deleteProduct) {
      selectProducts.forEach((element) {
        products.remove(element);
      });
      isSelected = false;
    }
  }

  void determineSelectAllProduct() {
    if (selectProducts.length == products.length) {
      selectProducts.clear();
      productsId.clear();
    } else {
      selectProducts.clear();
      productsId.clear();
      for (int i = 0; i < products.length; i++) {
        selectProducts.add(products[i]);
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
        result.fold((l) {}, (r) {
          imageFile = r;
        });
        emit(const ImagePickedState());
      } else if (event is AddProductEvent) {
        final result = await AddProductToJsonUseCase(sl()).send(
            name: event.name, describe: event.describe, price: event.price);
        result.fold((l) {
          emit(const AddProductErrorState());
        }, (r) {
          emit(AddProductSuccessfulState(describe: event.describe,price: event.price,name: event.name));
        });
      } else if (event is GetProductEvent) {
        emit(const GetProductLoadingState());
        final result = await GetProductsUseCase(sl()).get();
        result.fold((l) {
          emit(const GetProductSuccessfulState());
        }, (r) {
          products = r;
          emit(const GetProductErrorState());
        });
      } else if (event is ChangeIsSelectedEvent) {
        changeIsSelected();
        emit(ChangeIsSelectedState(isSelected));
      } else if (event is IsSelectedProductEvent) {
        changeSelectProduct();
        emit(IsSelectedProductState(selectProduct));
      } else if (event is DeleteProductEvent) {
        deleteSelectProduct();
        final res = await DeleteProductsUseCase(sl()).delete(productsId);
        res.fold((l) {
          // errorToast(msg: l);
        }, (r) {});
        emit(DeleteProductState(deleteProduct: deleteProduct));
      } else if (event is BackToDefaultBeforeSelectEvent) {
        isSelected = false;
        selectProducts.clear();
        productsId.clear();
        emit(BackToDefaultBeforeSelectState(isSelected));
      } else if (event is SelectAllProductEvent) {
        determineSelectAllProduct();
        emit(SelectAllProductStates(
            length: selectProducts.length, selectAllProduct: selectAllProduct));
      } else if (event is NavagationToProductsDetailsEvent) {

        NavigationManager.push(event.context, ProductDetails(event.index,event.product));
        emit(NavagationToProductsDetailsStates(index: event.index,
            product: event.product, context: event.context));
      }
      else if (event is EditProductEvent) {
        emit(EditProductLoadingStates());
        final res = await EditProductUseCase(sl()).edit(
            id: event.id,
            name: event.name,
            describe: event.describe,
            price: event.price);
        res.fold((l) {
          errorToast(msg: 'msg');
          emit(const EditProductErrorStates());
        }, (r) {
          isEdit = true;
          defaultToast(msg: "Product Updated Successfully");
          add(const GetProductEvent());
          NavigationManager.pop(event.context);
          emit(EditProductSuccessfullyStates(
              name: event.name,
              price: event.price,
              describe: event.describe,
              id: event.id));
        });
      }
      else if (event is IsEditProductEvent) {
        changeIsEditProduct();
        emit(IsEditProductStates(isEdit));
      }
    });
  }
}
