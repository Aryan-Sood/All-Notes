import 'package:flutter/material.dart';

class NotesAppBar extends StatelessWidget implements PreferredSizeWidget {
  NotesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
