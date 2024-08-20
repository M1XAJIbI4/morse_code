part of '../translator_screen.dart';

class _ResumeSwapButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _ResumeSwapButton({
    required this.onPressed,
  });

  @override
  State<_ResumeSwapButton> createState() => _ResumeSwapButtonState();
}

class _ResumeSwapButtonState extends State<_ResumeSwapButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
        onTap: () {},
        lowerBound: 0.95,
        child: SizedBox(
          width: 50,
          height: 40,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (ctx, child) {
              return Transform.rotate(
                angle: _animationController.value * 3.14,
                child: child,
              );
            },
            child: IconButton(
              onPressed: () {
                _animationController.value > 0.5 
                    ? _animationController.reverse() 
                    : _animationController.forward();
                widget.onPressed.call();
              },
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(
                    ApplicationTheme.APPBAR_COLOR.withOpacity(0.1)),
              ),
              icon: Transform.scale(
                scale: 2.8,
                child: SvgPicture.asset(Assets.images.swapIcon.path),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
