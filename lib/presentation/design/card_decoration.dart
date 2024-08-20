// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:morse_code/presentation/application/application.dart';

class CardDecoration extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;

  const CardDecoration({
    required this.child,
    this.padding,
    this.borderRadius = 16.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ApplicationTheme.CARD_COLOR.withOpacity(0.05),
          borderRadius: BorderRadius.circular(borderRadius),
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
