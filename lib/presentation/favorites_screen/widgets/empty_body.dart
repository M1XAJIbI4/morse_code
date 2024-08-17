part of '../favorites_screen.dart';

class _EmptyBody extends StatelessWidget {
  const _EmptyBody();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Text(
          'Nothing',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            height: 16.41 / 14,
            color: Color(0xFF848484)
          ),
        ),
    );
  }
}