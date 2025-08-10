import 'dart:collection';

import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  const Coffee({
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.type,
    required this.slung,
    required this.description,
  });
  final String name;
  final double price;
  final String image;
  final double rating;
  final String slung;
  final String type;

  final String description;
  @override
  // TODO: implement props
  List<Object?> get props => [
    name,
    price,
    image,
    rating,
    slung,
    Type,
    description,
  ];

  Coffee copyWith(
    final String? name,
    final double? price,
    final String? description,
    final String? image,
    final String? slung,
    final String? type,
    final double? rating,
  ) {
    return Coffee(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      description: description ?? this.description,
      slung: slung ?? this.slung,
    );
  }
}
