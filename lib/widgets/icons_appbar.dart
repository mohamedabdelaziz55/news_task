import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.05;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff141E28),
          shape: BoxShape.circle,
        ),
        width: iconSize * 2.2,
        height: iconSize * 2.2,
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

class IconsSearch extends StatelessWidget {
  const IconsSearch({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.05;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: iconSize * 2.4,
          height: iconSize * 2.4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black87, width: 1.8),
          ),
          child: Icon(
            icon,
            color: Colors.black,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
