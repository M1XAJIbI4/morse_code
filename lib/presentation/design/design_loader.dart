import 'package:flutter/material.dart';
import 'package:morse_code/presentation/application/application.dart';

//TODO: change
class DesignLoader extends StatelessWidget {
  const DesignLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 50.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            color: ApplicationTheme.APPBAR_COLOR,
          ),
          // SizedBox(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //       BoxShadow(
          //           color: ApplicationTheme.APPBAR_COLOR.withOpacity(0.2),
          //           spreadRadius: 10,
          //           blurRadius: 24.0),
          //       BoxShadow(
          //           color: ApplicationTheme.SHADOW_COLOR.withOpacity(0.1),
          //           spreadRadius: 10,
          //           blurRadius: 4.0),
          //     ]),
          //   ),
          // ),
        ],
      ),
    );
  }
}
