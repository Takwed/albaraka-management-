
import 'package:equatable/equatable.dart';

class Product extends Equatable
{

double newPrice ;
double oldPrice ;
  Product({required this.newPrice , required this.oldPrice}) ;
  @override
  List<Object?> get props => [newPrice , oldPrice ];
}