import 'package:flutter/material.dart';

Widget myAppBarIcon(int counter) {
  return SizedBox(
    width: 35,
    height: 30,
    child: Stack(
      children: [
        const Icon(
          Icons.notifications,
          color: Colors.black,
          size: 30,
        ),
        Container(
          width: 30,
          height: 30,
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
