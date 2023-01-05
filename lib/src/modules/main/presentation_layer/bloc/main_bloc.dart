import 'dart:async';

import 'package:albaraka_management/core/utils/navigation_manager.dart';
import 'package:albaraka_management/src/modules/offers/presentation_layer/screens/offers_screen.dart';
import 'package:albaraka_management/src/modules/orders/presentation_layer/screens/orders_screen.dart';
import 'package:albaraka_management/src/modules/staff/presentation_layer/screens/staff_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../menu/presentation_layer/screens/menu_screen.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  static MainBloc get(BuildContext context) =>
      BlocProvider.of<MainBloc>(context);
  List<Widget> pages = [
    StaffScreen(),
    MenuScreen(),
    OffersScreen(),
    OrdersScreen(),
  ];
  int currentIndex = 0;
  Widget currentPages = StaffScreen();
  MainBloc(MainInitial mainInitial) : super(MainInitial()) {
    on<MainEvent>((event, emit) {
      if (event is ChangeGridMainEvent) {
        NavigationManager.push(event.context,
        pages[currentIndex]);
        currentPages = pages[event.index];
        currentIndex = event.index;
        emit(ChangeGridMainState(index: event.index));
      }
    });
  }
}
