import 'dart:async';

import 'package:flutter/material.dart';

@immutable
abstract class HistoryEvent {}

class HistoryEventGetItemsAction extends HistoryEvent {
  final String id;
  final int limit;
  final dynamic offset;
  final bool isRefresh;
  final Completer? completer;

  HistoryEventGetItemsAction(
      {required this.id,
      required this.limit,
      this.offset,
      this.isRefresh = false,
      this.completer});
}
