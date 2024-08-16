import 'package:flutter/material.dart';

class DesignAppbar extends StatelessWidget implements PreferredSizeWidget{
  const DesignAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Morse code translator'),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}