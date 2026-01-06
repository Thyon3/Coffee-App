import 'package:equatable/equatable.dart';

class Price extends Equatable {
  final double amount;
  final String currency;

  const Price({required this.amount, this.currency = 'USD'})
      : assert(amount >= 0, 'Price amount must be non-negative');

  Price copyWith({double? amount, String? currency}) => Price(
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  @override
  List<Object?> get props => [amount, currency];
}
