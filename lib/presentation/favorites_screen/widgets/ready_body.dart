part of '../favorites_screen.dart';

class _ReadyBody extends StatelessWidget {
  final List<MorsePhrase> phrases;
  final Function(String) onRemovePressed;
  final Function(String) onCardPressed;

  const _ReadyBody({
    required this.phrases,
    required this.onRemovePressed,
    required this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20) +
          const EdgeInsets.only(top: 16),
      child: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: phrases.isEmpty
            ? const _EmptyBody()
            : ListView.builder(
                itemCount: phrases.length,
                itemBuilder: (_, index) {
                  final (item, id) = (phrases[index], phrases[index].id);
                  return _Item(
                    item: item,
                    onPressed: () => onCardPressed.call(id),
                    onStarPressed: () => onRemovePressed.call(id),
                    key: ValueKey(id),
                  );
                },
              ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final MorsePhrase item;
  final VoidCallback onPressed;
  final VoidCallback onStarPressed;

  const _Item({
    required this.item,
    required this.onPressed,
    required this.onStarPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: ElevatedButton(
        onPressed: () => onPressed.call(),
        style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            overlayColor: WidgetStatePropertyAll(ApplicationTheme.APPBAR_COLOR.withOpacity(0.1)),
            shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)))),
        child: CardDecoration(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignTitleText(text: item.locale.title),
              const Gap(8),
              DesignDefaultText(text: item.originalText),
              const Gap(8),
              const DesignTitleText(text: 'Morse'),
              const Gap(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DesignDefaultText(
                      text: item.morseText,
                      fontSize: 18.0,
                      height: 21.09 / 18.0,
                    ),
                    // DesignDefaultText(text: item.morseText),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0, -3),
                    child: ScalingButton(
                      onTap: () {},
                      child: StarIconButton(
                        onPressed: () => onStarPressed.call(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
