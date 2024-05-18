// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:simple_tex/CoreX/core_xperience.dart';

// ignore: must_be_immutable
class SwitchIconButton extends StatefulWidget {
  IconData onIcon;
  IconData offIcon;
  Color onColor;
  Color offColor;
  double size;
  bool isOn = false;

  SwitchIconButton(
      {super.key,
      required this.onIcon,
      required this.offIcon,
      required this.onColor,
      required this.offColor,
      required this.size});

  @override
  State<StatefulWidget> createState() => SwitchIconButtonState();
}

class SwitchIconButtonState extends State<SwitchIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          widget.isOn = !widget.isOn;
          debugPrint(CoreX.device.width.toString());
        });
      },
      child: Icon(widget.isOn ? widget.onIcon : widget.offIcon,
          size: widget.size,
          color: widget.isOn ? widget.onColor : widget.offColor),
    );
  }
}
