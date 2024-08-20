// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:morse_code/domain/bloc/favorites_action_bloc/favorites_action_bloc.dart';
import 'package:morse_code/domain/bloc/favorites_phrases_cubit/favorites_phrases_cubit.dart';
import 'package:morse_code/domain/bloc/translator_bloc/translator_bloc.dart';
import 'package:morse_code/domain/models/morse_phrase.dart';
import 'package:morse_code/domain/models/sup_locale.dart';
import 'package:morse_code/presentation/application/application.dart';
import 'package:morse_code/presentation/design/card_decoration.dart';
import 'package:morse_code/presentation/design/design_loader.dart';
import 'package:morse_code/presentation/design/desing_default_text.dart';
import 'package:morse_code/presentation/design/desing_title_text.dart';
import 'package:morse_code/presentation/design/scaling_button.dart';
import 'package:morse_code/presentation/design/star_icon_button.dart';

part 'widgets/empty_body.dart';
part 'widgets/loading_body.dart';
part 'widgets/ready_body.dart';

class FavoritesScreen extends StatefulWidget {
  final VoidCallback onCardTapped;

  const FavoritesScreen({
    required this.onCardTapped,
    super.key,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  late final FavoritesPhrasesCubit _favoritesPhrasesCubit;
  late final FavoritesActionBloc _favoritesActionBloc;
  late final TranslatorBloc _translatorBloc;

  @override
  void initState() {
    super.initState();
    _favoritesPhrasesCubit = context.read<FavoritesPhrasesCubit>();
    _favoritesActionBloc = context.read<FavoritesActionBloc>();
    _translatorBloc = context.read<TranslatorBloc>();
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesPhrasesCubit, FavoritesPhrasesState>(
      bloc: _favoritesPhrasesCubit,
      builder: (_, phrasesState) {
        return AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: switch (phrasesState) {
            FavoritesPhrasesStateLoading _ => const _LoadingBody(),
            FavoritesPhrasesStateReady ready => _ReadyBody(
              phrases: ready.morsePhrases,
              onRemovePressed: _onRemoveTapped,
              onCardPressed: (id) => _onCardTapped(id, ready.morsePhrases),
            )
          },
        );
      },
    );
  }

  void _onRemoveTapped(String id) => _favoritesActionBloc.add(
    FavoritesActionRemovePhraseEvent(id),
  );

  void _onCardTapped(String id, List<MorsePhrase> phrases) {
     final index = phrases.indexWhere((e) => e.id == id);
    if (index > -1) {
      final item = phrases[index];
      _translatorBloc.add(TranslatorInitializeEvent(
        originalText: item.originalText, 
        morseText: item.morseText,
      ));
      widget.onCardTapped.call();
    }
  }
}
