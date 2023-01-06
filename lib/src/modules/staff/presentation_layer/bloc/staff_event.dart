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