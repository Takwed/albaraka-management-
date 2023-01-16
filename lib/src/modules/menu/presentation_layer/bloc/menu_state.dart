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
  final String name;
  final String describe;
  final double oldPrice;
  final double newPrice;

  const AddProductSuccessfulState(
      {required this.name,
        required this.describe,
        required this.oldPrice,
        required this.newPrice,});

  @override
  List<Object?> get props => [name, describe, oldPrice,newPrice];
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
class NavagationToProductsDetailsStates extends MenuState {
  final BuildContext context;
  final ProductModel product;
  final int index;
  const NavagationToProductsDetailsStates({required this.context,required this.product,required this.index});
  @override
  List<Object?> get props => [context,product,index];
}
class EditProductSuccessfullyStates extends MenuState {
  final String name;
  final String describe;
  final double oldPrice;
  final double newPrice;
  final int id;
  const EditProductSuccessfullyStates({required this.name,
    required this.oldPrice,
    required this.newPrice,
    required this.describe,required this.id});

  @override
  List<Object?> get props => [name,describe,oldPrice,newPrice,id];
}
class EditProductErrorStates extends MenuState {
  // final String error;
  const EditProductErrorStates();
  @override
  List<Object?> get props => [];
}
class EditProductLoadingStates extends MenuState {
  const EditProductLoadingStates();
  @override
  List<Object?> get props => [];
}
class IsEditProductStates extends MenuState {
  final bool isEdit;
  const IsEditProductStates(this.isEdit);
  @override
  List<Object?> get props => [isEdit];
}
class ChooseCollectionState extends MenuState {
  final String value;
  ChooseCollectionState(this.value);
  @override
  List<Object?> get props => [value];
}
