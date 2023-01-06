import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  static StaffBloc get(BuildContext context) =>
      BlocProvider.of<StaffBloc>(context);
  int currentIndex = 0;
  StaffBloc(StaffInitial staffInitial) : super(StaffInitial()) {
    on<StaffEvent>((event, emit) {
      if (event is ChangeGridStaffEvent) {
        currentIndex = event.index;
        emit(ChangeGridStaffState(index: event.index));
      }
    });
  }
}
