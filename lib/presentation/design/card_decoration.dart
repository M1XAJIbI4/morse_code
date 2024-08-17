import 'package:flutter/material.dart';
import 'package:morse_code/presentation/application/application.dart';

class CardDecoration extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const CardDecoration({
    required this.child,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ApplicationTheme.CARD_COLOR.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: ApplicationTheme.BORDER_COLOR,
            width: 0.5,
          )
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
          child: child,
        ),
      ),
    );
  }
}
