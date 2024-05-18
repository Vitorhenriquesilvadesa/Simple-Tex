// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:simple_tex/core/app/app_config.dart';

// ignore: must_be_immutable
class LabelIconButton extends StatefulWidget {
  IconData icon;
  Color color;
  double size;
  Function onTap;
  TextStyle? style;
  String label;

  LabelIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
    required this.onTap,
    required this.style,
    required this.label,
  });

  @override
  State<StatefulWidget> createState() => LabelIconButtonState();
}

class LabelIconButtonState extends State<LabelIconButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.color,
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: Text(
            widget.label,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppConfig.publicationProfileFontSize / 2,
            ),
          ),
        ),
      ],
    );
  }
}
