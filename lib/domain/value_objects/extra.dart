import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';

class Extra extends Equatable {
  final String id;
  final String name;
  final Price price;
  const Extra({required this.id, required this.name, required this.price});

  @override
  List<Object?> get props => [id, name, price];
}
