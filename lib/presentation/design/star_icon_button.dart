import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/presentation/application/application.dart';

class StarIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StarIconButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 30.0,
      child: ClipOval(
        child: IconButton(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(ApplicationTheme.APPBAR_COLOR.withOpacity(0.25))
          ),
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Transform.scale(
            scale: 2,
            child: IconButton(
              icon: SvgPicture.asset(
                Assets.images.starActiveIcon.path,
              ),
              onPressed: () => onPressed.call(),
            ),
          ),
        ),
      ),
    );
  }
}
