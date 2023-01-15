import 'dart:async';

import 'package:albaraka_management/src/modules/staff/domain_layer/use_cases/add_member_usecasea.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../authenticaion/presentation_layer/components/components.dart';
import '../../data_layer/models/staff_model.dart';
import '../../domain_layer/use_cases/get_staff_use_case.dart';
import '../../domain_layer/use_cases/remove_member_usecasea.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  static StaffBloc get(BuildContext context) =>
      BlocProvider.of<StaffBloc>(context);
  int currentIndex = 0;
  List<MemberModel> members =[];
  /// change visibility
  bool currentVisibility = false;
  IconData currentSuffix = Icons.visibility;
  TextInputType type = TextInputType.visiblePassword;
  bool confirmCurrentVisibility = false;
  IconData confirmCurrentSuffix = Icons.visibility;
  TextInputType confirmType = TextInputType.visiblePassword;
  void changeVisibilityVoid() {
    currentVisibility = !currentVisibility;
    currentSuffix = !currentVisibility ? Icons.visibility : Icons.visibility_off;
    type = !currentVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }
  void confirmChangeVisibilityVoid() {
    confirmCurrentVisibility = !confirmCurrentVisibility;
    confirmCurrentSuffix = !confirmCurrentVisibility ? Icons.visibility : Icons.visibility_off;
    confirmType = !confirmCurrentVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }
  StaffBloc(StaffInitial staffInitial) : super(StaffInitial()) {
    on<StaffEvent>((event, emit) async{
      if (event is ChangeGridStaffEvent) {
        currentIndex = event.index;

        emit(ChangeGridStaffState(index: event.index));
      }
      else if (event is ChangeVisibilityEvent) {
        changeVisibilityVoid();
        emit(ChangeVisibilityStaffState(isVisible: currentVisibility));
      }
      else if (event is ConfirmChangeVisibilityEvent) {
        confirmChangeVisibilityVoid();
        emit(ConfirmChangeVisibilityStaffState(isVisible: confirmCurrentVisibility));
      }
      else if (event is AddMemberEvent) {
        final result = await addMemberWithEmailAndPassUseCase(sl()).excute(
            email: event.email, password: event.password, name: event.name, phone: event.phone);

        result.fold((l) {
          errorToast(msg: l.message!);
        }, (r)  {
          defaultToast(msg: "Account Created Successfully");
          emit(AddMemberSuccessfulStaffState());
        });
      }
      else if (event is DeleteMemberEvent){
       final result = await RemoveMemberWithEmailAndPassUseCase(sl()).excute(email: event.email, password: event.password);
       result.fold((l){
         errorToast(msg: l.message!);
       } , (r) {
         defaultToast(msg: "Account Deleted Successfully");
         emit(DeleteMemberState(email: event.email,password: event.email));
       });
      }
      else if (event is GetAllStaffEvent){
       emit(GetAllLoadingStaffState());
      final result = await GetStaffUseCase(sl()).excute();
      result.fold((l) {
        errorToast(msg: l.message!);
      } , (r){
        members = r;
        emit(GetAllStaffSuccessfulState(staffModel: r));
      });
      }
    });
  }
}
