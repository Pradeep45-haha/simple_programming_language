import 'package:a_very_simple_lang/expression.dart';
import 'package:a_very_simple_lang/lexer.dart';
import 'package:a_very_simple_lang/parser.dart';
import 'package:a_very_simple_lang/token.dart';

void main(List<String> arguments) {
  try {
    // E -> E ( '+' | '-' T )*
    // T -> F ( '*' | '/' F )*
    // F -> Integer | '(' E ')'

    // E => Expression
    // T => Term
    // F => Factor

    Lexer lexer = Lexer(input: "6+(2*3)/4");
    List<Token> tokens = lexer.scanTokens();
    print(tokens.toString());
    Parser parser = Parser(tokenList: tokens);
    Expression expression = parser.parse();
    print(expression.toString());
  } catch (e) {
    if (e is LexerError) {
      print("${e.errorMessage} val:${e.val}");
    }
    if (e is ParserError) {
      print("${e.errorMessage} val:${e.token}");
    }
  }
}
