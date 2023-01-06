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

  ChangeGridStaffState({required this.index});
  @override
  List<Object?> get props => [index];
}