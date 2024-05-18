import 'package:flutter/material.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/widgets/common_keywords.dart';

// ignore: must_be_immutable
class CodeScope extends StatelessWidget {
  String language;
  String code;

  CodeScope({super.key, required this.language, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: 800,
      margin: const EdgeInsets.only(left: 60, right: 60, bottom: 60, top: 60),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                  color: AppColors.get(Palette.codeScopeHeader),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Icon(
                        //   Icons.circle,
                        //   size: AppConfig.publicationProfileFontSize / 1.75,
                        //   color: Colors.white,
                        // ),
                        Container(width: 5, color: Colors.white),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                  bottom: 12, left: 10, right: 10),
                              child: Text(
                                language,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "RobotoMono",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(width: 10),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.greenAccent,
                          ),
                          Icon(
                            Icons.circle,
                            color: Colors.yellowAccent,
                          ),
                          Icon(
                            Icons.circle,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.get(Palette.cardMainColor),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: generateCodeScope(code),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Adicione um contêiner para a sombra acima do contêiner principal
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 10, // Ajuste conforme necessário
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                    spreadRadius: 8,
                    blurRadius: 32,
                    offset: const Offset(0, 35),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const TextStyle codeLineStyle = TextStyle(
  fontSize: 14,
  fontFamily: "RobotoMono",
  color: Colors.white,
  letterSpacing: 1,
);

const TextStyle commentLineStyle = TextStyle(
  fontSize: 14,
  fontFamily: "RobotoMono",
  color: Color.fromRGBO(85, 85, 85, 1),
  letterSpacing: 1,
);

List<Widget> generateCodeScope(String text) {
  List<String> lines = text.split("\n");
  List<Widget> scope = [];
  int lineIndex = 1;

  for (String line in lines) {
    List<Widget> lineComponents = [];
    bool isComment = false;
    Color wordColor = Colors.white;
    for (String word in line.split(" ")) {
      if (isWordCommon(word.replaceAll("@", ""))) {
        wordColor = const Color.fromRGBO(198, 120, 221, 1);
      }

      if (isOperator(word)) {
        wordColor = const Color.fromRGBO(67, 182, 194, 1);
      }

      if (word.startsWith("//")) {
        isComment = true;
      }

      if (word.startsWith("'") || word.startsWith("\"")) {
        wordColor = const Color.fromRGBO(152, 195, 121, 1);
      }

      if (word.endsWith(":")) {
        wordColor = const Color.fromARGB(255, 255, 115, 15);
      }

      if (word.isNotEmpty) {
        RegExp regex = RegExp(r'^[a-zA-Z]');
        if (regex.hasMatch(word[0])) {
          if (word[0] == word[0].toUpperCase()) {
            wordColor = const Color.fromARGB(255, 229, 192, 123);
          }
        }
      }

      TextStyle style = TextStyle(
        fontSize: 14,
        fontFamily: "RobotoMono",
        color: isComment ? const Color.fromRGBO(80, 80, 80, 1) : wordColor,
        letterSpacing: 1,
      );

      if (word.startsWith("\t")) {}

      lineComponents.add(
        Text(word, style: style),
      );

      lineComponents.add(
        Container(
          color: Colors.transparent,
          width: 10,
          height: 30,
        ),
      );

      wordColor = Colors.white;
    }

    scope.add(
      Row(
          children: <Widget>[
                Container(
                  height: 25,
                  width: 15 * lines.length.toString().length.toDouble(),
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  child: Text(
                    lineIndex.toString(),
                    style: const TextStyle(
                      color: Color.fromRGBO(113, 113, 113, 1),
                      fontSize: 16,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                )
              ] +
              lineComponents),
    );

    lineIndex++;
  }

  scope.add(
    Container(
      color: Colors.transparent,
      width: 10,
      height: 30,
    ),
  );

  return scope;
}
