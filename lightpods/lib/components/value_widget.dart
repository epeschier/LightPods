import 'package:flutter/material.dart';

abstract class ValueWidget<T> extends StatefulWidget {
  final ValueChanged<T>? onValueChanged;

  const ValueWidget(this.onValueChanged, {super.key});

  void notifyValueChange(T value) {
    onValueChanged?.call(value);
  }
}
