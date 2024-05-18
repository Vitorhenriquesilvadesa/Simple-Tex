import 'package:flutter/material.dart';
import 'package:simple_tex/widgets/profile_ring.dart';

class AssistanceNotifier extends StatelessWidget {
  const AssistanceNotifier({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 144,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                bottom: 16, top: (MediaQuery.of(context).size.height / 24.0)),
            child: OfflineProfileRing(
              size: MediaQuery.of(context).size.width / 5,
              borderWidth: 5,
              colors: const <Color>[
                Color.fromARGB(255, 0, 255, 140),
                Color.fromARGB(255, 0, 255, 213),
                Color.fromARGB(255, 0, 157, 255),
                Color.fromARGB(255, 0, 83, 192),
                Color.fromARGB(255, 70, 0, 192),
              ],
              imageUrl: "res/images/teacher001.png",
            ),
          ),
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height / 24.0), right: 4),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.info, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
