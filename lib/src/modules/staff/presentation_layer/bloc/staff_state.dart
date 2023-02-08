part of 'staff_bloc.dart';

abstract class StaffState extends Equatable {
  const StaffState();
}

class StaffInitial extends StaffState {
  @override
  List<Object> get props => [];
}
class ChangeGridStaffState extends StaffState {
  final int index;

  const ChangeGridStaffState({required this.index});
  @override
  List<Object?> get props => [index];
}
class AddMemberState extends StaffState {
  String email;
  String password;
  String name;
  String phone;

  AddMemberState({required this.email,required this.password,required this.name,required this.phone,});
  @override
  // TODO: implement props
  List<Object?> get props => [email,password,name,phone];
}

class AddMemberSuccessfulStaffState extends StaffState {
  const AddMemberSuccessfulStaffState();
  @override
  List<Object?> get props =>  [];
}

class ChangeVisibilityStaffState extends StaffState {
  final bool isVisible;

  const ChangeVisibilityStaffState({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}

class GetAllStaffSuccessfulState extends StaffState {
  List<MemberModel> staffModel;

  GetAllStaffSuccessfulState({required this.staffModel});
  @override
  List<Object?> get props => [staffModel];
}

class GetAllLoadingStaffState extends StaffState {

  const GetAllLoadingStaffState();
  @override
  List<Object?> get props => [];
}
class DeleteMemberState extends StaffState {
  final String email;
  final String password;

  const DeleteMemberState({required this.email,required this.password});
  @override
  List<Object?> get props => [email,password];
}