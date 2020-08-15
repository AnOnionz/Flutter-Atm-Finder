import 'package:flutter/material.dart';
class FloatButton extends StatelessWidget {
  final double size;
  final Icon icon;
  final Color color;
  final VoidCallback onPressed;

  const FloatButton({Key key, this.icon, this.color, this.onPressed, this.size} ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: icon,
      shape: CircleBorder(),
      color: color,
      padding: EdgeInsets.all(size??10.0),
      elevation: 3,
      onPressed: onPressed,
    );
  }
}
