import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';

/// State class for coffee-related operations
abstract class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object?> get props => [];
}

class CoffeeInitial extends CoffeeState {}

class CoffeeLoading extends CoffeeState {}

class CoffeeLoaded extends CoffeeState {
  final List<CoffeeEntity> coffees;

  const CoffeeLoaded(this.coffees);

  @override
  List<Object?> get props => [coffees];
}

class CoffeeError extends CoffeeState {
  final String message;

  const CoffeeError(this.message);

  @override
  List<Object?> get props => [message];
}
