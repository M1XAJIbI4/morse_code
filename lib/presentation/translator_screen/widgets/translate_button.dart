part of '../translator_screen.dart';

class _TranslateButton extends StatelessWidget {
  final VoidCallback onTranslatePressed;

  const _TranslateButton({
    required this.onTranslatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: () {},
      lowerBound: 0.9,
      child: SizedBox(
        height: 40.0,
        child: ElevatedButton(
          onPressed: () => onTranslatePressed.call(),
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFFFF6600)),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 24, vertical: 10)
            ),
          ),
          child: const Text(
            'Translate',
            style: TextStyle(
              fontFamily: FontFamily.roboto,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              letterSpacing: 0.1,
              height: 20.0 / 14.0,
            ),
          ),
        ),
      ),
    );
  }
}