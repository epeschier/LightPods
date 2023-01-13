import 'package:flutter/material.dart';
import '../theme/theme.dart';

class HeaderWithValue extends StatelessWidget {
  final String text;
  final String? value;

  const HeaderWithValue({super.key, this.value, required this.text});

  @override
  Widget build(BuildContext context) => _getHeaderWithValue(text, value);

  Widget _getHeaderWithValue(String text, String? value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: ThemeColors.headerText,
          ),
          Text(
            value ?? '',
            style: ThemeColors.headerValueText,
          ),
        ],
      );
}
