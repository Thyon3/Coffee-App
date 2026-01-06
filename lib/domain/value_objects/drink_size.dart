import 'package:equatable/equatable.dart';

enum DrinkSizeType { small, medium, large }

class DrinkSize extends Equatable {
  final DrinkSizeType type;
  final double volumeMl; // approximate volume to help pricing rules if needed

  const DrinkSize({required this.type, required this.volumeMl})
      : assert(volumeMl > 0, 'Volume must be positive');

  const DrinkSize.small() : this(type: DrinkSizeType.small, volumeMl: 240);
  const DrinkSize.medium() : this(type: DrinkSizeType.medium, volumeMl: 350);
  const DrinkSize.large() : this(type: DrinkSizeType.large, volumeMl: 470);

  @override
  List<Object?> get props => [type, volumeMl];
}
