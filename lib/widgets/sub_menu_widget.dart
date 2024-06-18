import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue[900],
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.emoji_events),
              color: Colors.black,
              onPressed: () {},
            ),
            const Expanded(
              child: Center(
                child: Icon(
                  Icons.star,
                  size: 40,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
