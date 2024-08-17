
part of '../translator_screen.dart';

class _AssetsIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  
  const _AssetsIconButton({
    required this.onPressed,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: () {}, 
      lowerBound: 0.85,
      child: SizedBox.square(
        dimension: 40.0,
        child: IconButton(
          onPressed: () => onPressed.call(), 
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
                ApplicationTheme.APPBAR_COLOR.withOpacity(0.1)),
          ),
          icon: SvgPicture.asset(iconPath),
        ),
      ),
    );
  }
}