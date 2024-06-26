List<String> commonKeyWords = [
  "abstract",
  "as",
  "assert",
  "async",
  "await",
  "break",
  "case",
  "catch",
  "class",
  "const",
  "continue",
  "covariant",
  "default",
  "deferred",
  "do",
  "dynamic",
  "else",
  "enum",
  "export",
  "extends",
  "extension",
  "external",
  "factory",
  "false",
  "final",
  "finally",
  "for",
  "Function",
  "get",
  "hide",
  "if",
  "implements",
  "import",
  "in",
  "interface",
  "is",
  "late",
  "library",
  "mixin",
  "new",
  "null",
  "on",
  "operator",
  "out",
  "part",
  "rethrow",
  "return",
  "set",
  "show",
  "static",
  "super",
  "switch",
  "sync",
  "this",
  "throw",
  "true",
  "try",
  "typedef",
  "var",
  "void",
  "while",
  "with",
  "yield",
  "override",
  "def",
  "in",
  "@"
];

List<String> operators = [
  "+",
  "-",
  "*",
  "/",
  "%",
  "~/",
  "==",
  "!=",
  ">",
  "<",
  ">=",
  "<=",
  "&&",
  "||",
  "!",
  "??",
  "+=",
  "-=",
  "*=",
  "/=",
  "%=",
  "~/=",
  "&",
  "|",
  "^",
  "~",
  "<<",
  ">>",
  ">>>",
  "is",
  "as",
  "??=",
  "..",
  "=>",
  "?"
];

bool isWordCommon(String word) {
  return commonKeyWords.contains(word);
}

bool isOperator(String word) {
  return operators.contains(word);
}
