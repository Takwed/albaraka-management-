import 'dart:async';
import 'dart:io';

import 'package:albaraka_management/src/modules/menu/domain_layer/use_cases/get_product_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/dep_injection.dart';
import '../../data_layer/models/product_model.dart';
import '../../domain_layer/use_cases/add_image_use_case.dart';
import '../../domain_layer/use_cases/add_product_use_case.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  static MenuBloc get(BuildContext context) =>
      BlocProvider.of<MenuBloc>(context);
  String? imageUrl;
  File? imageFile;
  List<ProductModel> products = [];
  MenuBloc(MenuInitial menuInitial) : super(MenuInitial()) {
    on<MenuEvent>((event, emit)async {
      if (event is ImagePickedEvent) {
        final result = await AddImageUseCase(sl()).excute(event.source, event.context);
        result.fold((l) {

        } , (r) {
          imageFile = r;
        } );
        emit(const ImagePickedState());
      }
      else if (event is AddProductEvent){
        final result = await AddProductToJsonUseCase(sl()).send(
            name: event.name, describe: event.describe, price: event.price);
        result.fold((l) {
          emit(const AddProductErrorState());
        }, (r) {
          emit(const AddProductSuccessfulState());
        });
      }
      else if (event is GetProductEvent){
        emit(const GetProductLoadingState());
        final result = await GetProductsUseCase(sl()).get();
        result.fold((l) {
          emit(const GetProductSuccessfulState());
        }, (r) {
          products = r;
          emit(const GetProductErrorState());
        });
      }
    });
  }
}
