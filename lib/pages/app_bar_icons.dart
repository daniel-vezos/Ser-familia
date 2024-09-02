import 'package:flutter/material.dart';

Widget myAppBarIcon(BuildContext context, int counter) {
  return SizedBox(
    width: 39,
    height: 70,
    child: Stack(
      children: [
        Positioned(
          top: 0,
          right: 3,
          child: IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notificationpage');
            },
          ),
        ),
        Container(
          width: 40,
          height: 60,
          alignment: Alignment.topRight,
          margin: const EdgeInsets.only(top: 5, right: 5),
          child: Container(
            width: 15,
            height: 19,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffc32c37),
                border: Border.all(color: Colors.white, width: 1)),
            child: Center(
              child: Text(
                counter.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
