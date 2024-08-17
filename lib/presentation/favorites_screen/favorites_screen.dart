import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:morse_code/domain/bloc/favorites_phrases_cubit/favorites_phrases_cubit.dart';
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
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  late final FavoritesPhrasesCubit _favoritesPhrasesCubit;
  // late final FavoritesActionBloc _favoritesActionBloc;

  @override
  void initState() {
    super.initState();
    _favoritesPhrasesCubit = context.read<FavoritesPhrasesCubit>();
    // _favoritesActionBloc = context.read<FavoritesActionBloc>();
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
              onRemovePressed: (id) => print('FOOBAR onRemovePressed id: $id'),
              onCardPressed: (id) => print('FOOBAR onCardPressed id: $id'),
            )
          },
        );
      },
    );
  }
}
