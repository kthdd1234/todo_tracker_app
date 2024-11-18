import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/util/constants.dart';

class SpeedDialButton extends StatelessWidget {
  SpeedDialButton({
    super.key,
    required this.icon,
    required this.activeBackgroundColor,
    required this.backgroundColor,
    required this.children,
  });

  IconData icon;
  Color activeBackgroundColor, backgroundColor;
  List<SpeedDialChild> children;
  Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: icon,
      spacing: 3,
      buttonSize: const Size(50, 50),
      childrenButtonSize: const Size(50, 50),
      spaceBetweenChildren: 7,
      iconTheme: const IconThemeData(color: Colors.white, size: 30),
      activeIcon: Icons.close,
      activeBackgroundColor: activeBackgroundColor,
      visible: true,
      overlayOpacity: 0.4,
      overlayColor: Colors.black87,
      backgroundColor: backgroundColor,
      children: children,
    );
  }
}
