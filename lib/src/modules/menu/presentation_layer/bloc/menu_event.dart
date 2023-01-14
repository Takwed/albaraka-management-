part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}
class ImagePickedEvent extends MenuEvent {
  final ImageSource source;
  final BuildContext context;
  const ImagePickedEvent({required this.source, required this.context});
  @override
  List<Object?> get props => [source,context];
}
class AddProductEvent extends MenuEvent {
  final String name;
  final String describe;
  final int price;

  const AddProductEvent({required this.name, required this.describe,required this.price});

  @override
  List<Object?> get props => [name,describe,price];
}
class GetProductEvent extends MenuEvent {
   const GetProductEvent();
  @override
  List<Object?> get props => [];
}
class SelectProductEvent extends MenuEvent {
    SelectProductEvent();
  @override
  List<Object?> get props => [];
}