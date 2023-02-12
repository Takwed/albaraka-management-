part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class ImagePickedEvent extends MenuEvent {
  final ImageSource source;
  final BuildContext context;
  const ImagePickedEvent({required this.source, required this.context});
  @override
  List<Object?> get props => [source, context];
}

class AddProductEvent extends MenuEvent {
  final String name;
  final String describe;
  final double oldPrice;
  final double points;
  final double newPrice;
  final int collectionIndex;

  const AddProductEvent(
      {required this.name,
        required this.describe,
        required this.oldPrice,
        required this.points,
        required this.collectionIndex,
        required this.newPrice,});

  @override
  List<Object?> get props => [name, describe, oldPrice,collectionIndex,newPrice,points];
}

class GetMashweyatEvent extends MenuEvent {
  const GetMashweyatEvent();
  @override
  List<Object?> get props => [];
}
class GetKosharyEvent extends MenuEvent {
  const GetKosharyEvent();
  @override
  List<Object?> get props => [];
}
class GetHalaweyatEvent extends MenuEvent {
  const GetHalaweyatEvent();
  @override
  List<Object?> get props => [];
}

class ChangeIsSelectedEvent extends MenuEvent {
  ChangeIsSelectedEvent();
  @override
  List<Object?> get props => [];
}

class IsSelectedProductEvent extends MenuEvent {
  IsSelectedProductEvent();
  @override
  List<Object?> get props => [];
}

class SelectAllProductEvent extends MenuEvent {
  final List<ProductModel> product;
  SelectAllProductEvent(this.product);
  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends MenuEvent {
  final List<ProductModel> product;
  final int collectionIndex;
  DeleteProductEvent(this.product,this.collectionIndex);
  @override
  List<Object?> get props => [product,collectionIndex];
}

class BackToDefaultBeforeSelectEvent extends MenuEvent {
  BackToDefaultBeforeSelectEvent();
  @override
  List<Object?> get props => [];
}

class NavagationToProductsDetailsEvent extends MenuEvent {
  final BuildContext context;
  final ProductModel product;
  final int index;
  final int collectionIndex;

  NavagationToProductsDetailsEvent(
      {required this.context, required this.product, required this.index,required this.collectionIndex});

  @override
  List<Object?> get props => [context, product, index,collectionIndex];
}

class EditProductEvent extends MenuEvent {
  final String name;
  final String describe;
  final double oldPrice;
  final double points;
  final double newPrice;
  final int id;
  String? offerDetails;
  String? offerState;
  int? quantity;
  final int collectionIndex;
  final BuildContext context;
  EditProductEvent(
      {required this.name,
      required this.oldPrice,
      required this.newPrice,
      required this.points,
      required this.describe,
      required this.offerDetails,
      required this.offerState,
      required this.quantity,
      required this.collectionIndex,
      required this.id,
      required this.context});

  @override
  List<Object?> get props => [name, describe,collectionIndex, oldPrice, newPrice, points,id, context,offerDetails,offerState,quantity];
}

class IsEditProductEvent extends MenuEvent {
  IsEditProductEvent();
  @override
  List<Object?> get props => [];
}
class ChooseCollectionEvent extends MenuEvent {
  final String value;
  ChooseCollectionEvent(this.value);
  @override
  List<Object?> get props => [value];
}
class ChangeTabBarEvent extends MenuEvent {
  final int changeTab;
  ChangeTabBarEvent(
      {required this.changeTab});
  @override
  List<Object?> get props => [changeTab];
}

