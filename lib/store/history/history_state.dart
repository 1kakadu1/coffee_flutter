import 'package:coffe_flutter/models/order.model.dart';
import 'package:equatable/equatable.dart';

class HistoryState extends Equatable {
  final List<OrderModel> items;
  final bool isLoading;
  final String? error;

  const HistoryState(
      {required this.items, required this.isLoading, this.error});

  HistoryState copyWith(
      {List<OrderModel>? items, String? error, bool? isLoading}) {
    return HistoryState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
