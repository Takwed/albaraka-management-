part of 'staff_bloc.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();
}
class ChangeGridStaffEvent extends StaffEvent {
  final int index;

  const ChangeGridStaffEvent({required this.index,});
  @override
  List<Object?> get props => [index];
}


class ChangeVisibilityEvent extends StaffEvent {
  const ChangeVisibilityEvent();
  @override
  List<Object?> get props => [];
}
class ConfirmChangeVisibilityEvent extends StaffEvent {
  const ConfirmChangeVisibilityEvent();
  @override
  List<Object?> get props => [];
}

class GetAllStaffEvent extends StaffEvent {

  const GetAllStaffEvent();
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

  const DeleteMemberEvent({required this.email,required this.password});
  @override
  List<Object?> get props => [email,password];
}