part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class MenuInitial extends MenuState {
  @override
  List<Object> get props => [];
}
class ImagePickedState extends MenuState {
  const ImagePickedState();
  @override
  List<Object?> get props => [];
}

class AddProductSuccessfulState extends MenuState {
  const AddProductSuccessfulState();
  @override
  List<Object?> get props => [];
}class AddProductErrorState extends MenuState {
  const AddProductErrorState();
  @override
  List<Object?> get props => [];
}
class GetProductErrorState extends MenuState {
  const GetProductErrorState();
  @override
  List<Object?> get props => [];
}class GetProductSuccessfulState extends MenuState {
  const GetProductSuccessfulState();
  @override
  List<Object?> get props => [];
}class GetProductLoadingState extends MenuState {
  const GetProductLoadingState();
  @override
  List<Object?> get props => [];
}