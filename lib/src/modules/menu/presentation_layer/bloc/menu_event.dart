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
  final int price;

  const AddProductEvent(
      {required this.name, required this.describe, required this.price});

  @override
  List<Object?> get props => [name, describe, price];
}

class GetProductEvent extends MenuEvent {
  const GetProductEvent();
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
  SelectAllProductEvent();
  @override
  List<Object?> get props => [];
}

class DeleteProductEvent extends MenuEvent {
  //final List<int> ids;
  DeleteProductEvent();
  @override
  List<Object?> get props => [];
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

  NavagationToProductsDetailsEvent(
      {required this.context,required this.product,required this.index});

  @override
  List<Object?> get props => [context, product,index];
}

class EditProductEvent extends MenuEvent {
  final String name;
  final String describe;
  final int price;
  final int id;
  final BuildContext context;
  EditProductEvent(
      {required this.name,
      required this.price,
      required this.describe,
      required this.id,
      required this.context});

  @override
  List<Object?> get props => [name, describe, price, id,context];
}

class IsEditProductEvent extends MenuEvent {
  IsEditProductEvent();
  @override
  List<Object?> get props => [];
}
// class ChooseCollectionEvent extends MenuEvent {
//   final String value;
//   ChooseCollectionEvent();
//   @override
//   List<Object?> get props => [];
// }
