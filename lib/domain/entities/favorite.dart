import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';

class Favorite extends Equatable {
  final String id;
  final String userId;
  final String coffeeId;
  final DateTime createdAt;

  const Favorite({
    required this.id,
    required this.userId,
    required this.coffeeId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, coffeeId, createdAt];

  Favorite copyWith({
    String? id,
    String? userId,
    String? coffeeId,
    DateTime? createdAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      coffeeId: coffeeId ?? this.coffeeId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
