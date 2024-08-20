part of '../home_screen.dart';

class _HomeScreenBottomBar extends StatelessWidget {
  final Function(_HomeScreenTab) onTapTapped;
  final ValueListenable<_HomeScreenTab> activeTabListenable;

  const _HomeScreenBottomBar({
    required this.onTapTapped,
    required this.activeTabListenable,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [..._confugureTabs()],
      ),
    );
  }

  List<Widget> _confugureTabs() {
    final result = <Widget>[];
    for (final tab in _HomeScreenTab.values) {
      final icon = _TabIcon(
          tab: tab,
          onTap: () => onTapTapped.call(tab),
          activeTabListenable: activeTabListenable);
      result.add(icon);
      if (_HomeScreenTab.values.last != tab) {
        result.add(const _Separator());
      }
    }
    return result;
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 84),
        child: const SizedBox(
          width: double.infinity,
        ),
      ),
    );
  }
}