import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ListContainer extends StatelessWidget {
  final Widget child;

  const ListContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) => _getContainer(child);

  Widget _getContainer(Widget w) => Container(
        color: ThemeColors.backgroundColor,
        padding: const EdgeInsets.all(10),
        child: w,
      );
}
