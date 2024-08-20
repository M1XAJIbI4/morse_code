part of '../home_screen.dart';

class _TabIcon extends StatelessWidget {
  final _HomeScreenTab tab;
  final VoidCallback onTap;
  final ValueListenable<_HomeScreenTab> activeTabListenable;

  const _TabIcon({
    required this.tab,
    required this.onTap,
    required this.activeTabListenable,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 54,
      child: ScalingButton(
        onTap: () {},
        child: ValueListenableBuilder<_HomeScreenTab>(
          valueListenable: activeTabListenable,
          builder: (_, activeTab, __) {
            final isActive = activeTab == tab;
            return AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: ElevatedButton(
                key: ValueKey(isActive),
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                  backgroundColor: WidgetStatePropertyAll(
                      isActive ? const Color(0xFF055349) : Colors.transparent),
                  shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () => onTap.call(),
                child: AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        tab.iconPath,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}