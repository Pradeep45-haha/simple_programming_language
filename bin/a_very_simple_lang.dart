import 'package:a_very_simple_lang/lexer.dart';

void main(List<String> arguments) {
  Lexer lexer = Lexer(input: "22+3/4*10+(11+6)+66");

  try {
    print(lexer.scanTokens().toString());
  } catch (e) {
    if (e is LexerError) {
      print("${e.errorMessage} val:${e.val}");
    }
  }
}
