import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/presentation/design/design_appbar.dart';
import 'package:morse_code/presentation/design/scaling_button.dart';

part 'widgets/home_screen_bottom_bar.dart';
part 'widgets/tab_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _activeTabNotifier =
      ValueNotifier<HomeScreenTab>(HomeScreenTab.translateTab);
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: HomeScreenTab.values.length,
      vsync: this,
    );
    _initListener();
  }

  void _initListener() {
    _tabController.addListener(_tabListener);
  }

  void _tabListener() {
    _activeTabNotifier.value = HomeScreenTab.values[_tabController.index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DesignAppbar(),
      body: SafeArea(
        child: Stack(
          children: [
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  //TODO: implement
                  Container(
                      width: double.infinity, height: 200, color: Colors.red),
                  Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.green),
                ]),
            Positioned(
              bottom: 17.0,
              left: 0.0,
              right: 0.0,
              child: _HomeScreenBottomBar(
                onTapTapped: (tab) => _onTapTapped(tab), 
                activeTabListenable: _activeTabNotifier,
              )
            )
          ],
        ),
      ),
    );
  }


  void _onTapTapped(HomeScreenTab tab) {
    _tabController.animateTo(tab.tabIndex);
  }

  @override
  void dispose() {
    _activeTabNotifier.dispose();
    _tabController.removeListener(_tabListener);
    _tabController.dispose();
    super.dispose();
  }
}

enum HomeScreenTab {
  translateTab,
  favoritesTab,
}

extension HomeScreenTabExtension on HomeScreenTab {
  String get iconPath => switch (this) {
        HomeScreenTab.translateTab => Assets.images.translateTab.path,
        HomeScreenTab.favoritesTab => Assets.images.favoritesTab.path,
      };

  int get tabIndex => switch (this) {
        HomeScreenTab.translateTab => 0,
        HomeScreenTab.favoritesTab => 1,
      };

  HomeScreenTab getByIndex(int index) {
    if (index == 0) {
      return HomeScreenTab.translateTab;
    } else {
      return HomeScreenTab.favoritesTab;
    }
  }
}
