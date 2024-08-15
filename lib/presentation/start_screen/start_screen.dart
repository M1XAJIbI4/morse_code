import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/presentation/home_screen/home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       Future.delayed(const Duration(seconds: 1)).then((_) {
        _pushHomeScreen();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          Assets.images.logoSvg.path,
          
        ),
      ),
    );
  }

  void _pushHomeScreen() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (ctx, animation, __) => FadeTransition(
          opacity: CurvedAnimation(
            parent: animation, 
            curve: Curves.fastOutSlowIn,
          ),
          child: const HomeScreen(),
        ),
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }
}
