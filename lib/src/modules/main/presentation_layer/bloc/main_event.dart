part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}
class ChangeGridMainEvent extends MainEvent {
  final int index;

  ChangeGridMainEvent({required this.index});
  @override
  List<Object?> get props => [index];
}