import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    super.key, this.onPressed,
  });
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff141E28),
          borderRadius: BorderRadius.circular(40),
        ),
        height: 40,
        width: 40,
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.menu, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
class IconsSearch extends StatelessWidget {
  const IconsSearch({
    super.key, required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Icon(icon, color: Colors.black, size: 24),
        ),
      ),
    );
  }
}
