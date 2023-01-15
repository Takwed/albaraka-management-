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
}

class AddProductErrorState extends MenuState {
  const AddProductErrorState();
  @override
  List<Object?> get props => [];
}

class GetProductErrorState extends MenuState {
  const GetProductErrorState();
  @override
  List<Object?> get props => [];
}

class GetProductSuccessfulState extends MenuState {
  const GetProductSuccessfulState();
  @override
  List<Object?> get props => [];
}

class GetProductLoadingState extends MenuState {
  const GetProductLoadingState();
  @override
  List<Object?> get props => [];
}

class ChangeIsSelectedState extends MenuState {
  final bool isSelected;
  const ChangeIsSelectedState(this.isSelected);
  @override
  List<Object?> get props => [isSelected];
}

class IsSelectedProductState extends MenuState {
  final bool selectProduct;
  const IsSelectedProductState(this.selectProduct);
  @override
  List<Object?> get props => [selectProduct];
}

class DeleteProductState extends MenuState {
  final bool deleteProduct;
  const DeleteProductState({required this.deleteProduct});
  @override
  List<Object?> get props => [deleteProduct];
}

class BackToDefaultBeforeSelectState extends MenuState {
  final bool isSelected;
  const BackToDefaultBeforeSelectState(this.isSelected);
  @override
  List<Object?> get props => [isSelected];
}
class SelectAllProductStates extends MenuState {
  final bool selectAllProduct;
  final int length;
  const SelectAllProductStates({required this.selectAllProduct,required this.length});
  @override
  List<Object?> get props => [selectAllProduct,length];
}