part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class MenuInitial extends MenuState {
  @override
  List<Object> get props => [];
}
class ImagePickedSuccessfullyState extends MenuState {
  final File imageFile;
  const ImagePickedSuccessfullyState(this.imageFile);
  @override
  List<Object?> get props => [imageFile];
}
class ImagePickedErrorState extends MenuState {
  final String error;
  const ImagePickedErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class AddProductSuccessfulState extends MenuState {
  final String name;
  final String describe;
  final double oldPrice;
  final double newPrice;
  final int collectionIndex;

  const AddProductSuccessfulState(
      {required this.name,
        required this.describe,
        required this.oldPrice,
        required this.newPrice,
        required this.collectionIndex,});

  @override
  List<Object?> get props => [name, describe, oldPrice,newPrice,collectionIndex];
}

class AddProductErrorState extends MenuState {
  const AddProductErrorState();
  @override
  List<Object?> get props => [];
}
//// Koshary
class GetKosharyErrorState extends MenuState {
  const GetKosharyErrorState();
  @override
  List<Object?> get props => [];
}

class GetKosharySuccessfulState extends MenuState {
  final List<ProductModel> Koshary;
  const GetKosharySuccessfulState(this.Koshary);
  @override
  List<Object?> get props => [Koshary];
}

class GetKosharyLoadingState extends MenuState {
  const GetKosharyLoadingState();
  @override
  List<Object?> get props => [];
}

class ChangeIsSelectedState extends MenuState {
  final bool isSelected;
  const ChangeIsSelectedState(this.isSelected);
  @override
  List<Object?> get props => [isSelected];
}
 // halaweyat

class GetHalaweyatErrorState extends MenuState {
  const GetHalaweyatErrorState();
  @override
  List<Object?> get props => [];
}

class GetHalaweyatSuccessfulState extends MenuState {
  final List<ProductModel> halaweyat;

  const GetHalaweyatSuccessfulState(this.halaweyat);
  @override
  List<Object?> get props => [halaweyat];
}

class GetHalaweyatLoadingState extends MenuState {
  const GetHalaweyatLoadingState();
  @override
  List<Object?> get props => [];
}
 // mashweyat

class GetMashweyatErrorState extends MenuState {
  const GetMashweyatErrorState();
  @override
  List<Object?> get props => [];
}

class GetMashweyatSuccessfulState extends MenuState {
  final List<ProductModel> mashweyat;
  const GetMashweyatSuccessfulState(this.mashweyat);
  @override
  List<Object?> get props => [mashweyat];
}

class GetMashweyatLoadingState extends MenuState {
  const GetMashweyatLoadingState();
  @override
  List<Object?> get props => [];
}

class IsSelectedProductState extends MenuState {
  final bool selectProduct;
  const IsSelectedProductState(this.selectProduct);
  @override
  List<Object?> get props => [selectProduct];
}

class DeleteProductState extends MenuState {
  // final bool deleteProduct;
  final int collectionIndex;
  final List<ProductModel> product;
  const DeleteProductState({required this.collectionIndex,required this.product});
  @override
  List<Object?> get props => [collectionIndex,product];
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
  final List<ProductModel> product;

  const SelectAllProductStates({required this.product,required this.selectAllProduct,required this.length});
  @override
  List<Object?> get props => [product,selectAllProduct,length];
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
  final int collectionIndex;
  const EditProductSuccessfullyStates({required this.name,
    required this.oldPrice,
    required this.newPrice,
    required this.collectionIndex,
    required this.describe,required this.id});

  @override
  List<Object?> get props => [name,describe,oldPrice,newPrice,collectionIndex,id];
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
