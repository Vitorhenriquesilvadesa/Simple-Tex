import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnlineProfileRing extends StatefulWidget {
  double size;
  String imageUrl;
  int borderWidth;
  List<Color> gradient;

  OnlineProfileRing({
    required this.size,
    required this.borderWidth,
    required this.imageUrl,
    required this.gradient,
    super.key,
  });

  @override
  State<OnlineProfileRing> createState() => OnlineProfileRingState();
}

class OnlineProfileRingState extends State<OnlineProfileRing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: widget.gradient,
        ),
        borderRadius: BorderRadius.circular(widget.size / 2),
      ),
      alignment: Alignment.center,
      child: Container(
          width: widget.size - widget.borderWidth,
          height: widget.size - widget.borderWidth,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(widget.size / 2),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: widget.size - widget.borderWidth,
            backgroundImage: NetworkImage(widget.imageUrl),
          )),
    );
  }
}

// ignore: must_be_immutable
class OfflineProfileRing extends StatefulWidget {
  double size;
  String imageUrl;
  int borderWidth;
  List<Color> colors;

  OfflineProfileRing({
    required this.size,
    required this.borderWidth,
    required this.imageUrl,
    required this.colors,
    super.key,
  });

  @override
  State<OfflineProfileRing> createState() => OfflineProfileRingState();
}

class OfflineProfileRingState extends State<OfflineProfileRing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: widget.colors,
        ),
        borderRadius: BorderRadius.circular(widget.size / 2),
      ),
      alignment: Alignment.center,
      child: Container(
        width: widget.size - widget.borderWidth,
        height: widget.size - widget.borderWidth,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(widget.size / 2),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: widget.size - widget.borderWidth,
          backgroundImage: AssetImage(widget.imageUrl),
        ),
      ),
    );
  }
}
