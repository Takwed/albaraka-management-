part of 'staff_bloc.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();
}
class ChangeGridStaffEvent extends StaffEvent {
  final int index;

  ChangeGridStaffEvent({required this.index,});
  @override
  List<Object?> get props => [index];
}


class ChangeVisibilityWhenAddMemberEvent extends StaffEvent {
  bool isVisible;
  ChangeVisibilityWhenAddMemberEvent(this.isVisible);
  @override
  // TODO: implement props
  List<Object?> get props => [isVisible];
}

class GetAllStaffEvent extends StaffEvent {

  GetAllStaffEvent();
  @override
  List<Object?> get props => [];
}

class AddMemberEvent extends StaffEvent {
  String email;
  String password;
  String name;
  String phone;

  AddMemberEvent({required this.email,required this.password,required this.name,required this.phone,});
  @override
  // TODO: implement props
  List<Object?> get props => [email,password,name,phone];
}

class DeleteMemberEvent extends StaffEvent {
  final String email;
  final String password;

  DeleteMemberEvent({required this.email,required this.password});
  @override
  List<Object?> get props => [email,password];
}