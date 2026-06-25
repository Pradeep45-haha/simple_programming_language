import 'package:a_very_simple_lang/expression.dart';
import 'package:a_very_simple_lang/token.dart';

class Parser {
  final List<Token> _tokens;

  int _idx = 0;

  Parser({required List<Token> tokenList}) : _tokens = tokenList;

  Token _peek() {
    return _tokens[_idx];
  }

  bool _isAtEnd() {
    if (_tokens[_idx].tokenType == TokenType.eof) {
      return true;
    }
    return false;
  }

  Token _previous() {
    return _tokens[(_idx - 1)];
  }

  Token _advance() {
    if (_isAtEnd()) {
      return _tokens[_idx];
    }
    return _tokens[_idx++];
  }

  bool _check({required TokenType tokenType}) {
    if (_isAtEnd()) {
      return tokenType == TokenType.eof;
    }

    return _peek().tokenType == tokenType;
  }

  Token _consume({required TokenType tokenType, required String message}) {
    Token token = _advance();
    if (_check(tokenType: tokenType)) {
      return token;
    }
    throw ParserError(errorMessage: "Invalid Token Type", token: token);
  }

  bool _match({required List<TokenType> tokenTypeList}) {
    for (var tokenType in tokenTypeList) {
      if (_check(tokenType: tokenType)) {
        _advance();
        return true;
      }
    }
    return false;
  }

  Expression parse() {}

  Expression parseExpression() {
    Expression workingExpression = parseTerm();

    while (_match(tokenTypeList: [TokenType.plus, TokenType.minus])) {
      Token operator = _previous();
      Expression parsedTerm = parseTerm();

      workingExpression = BinaryOperator(
        left: workingExpression,
        operator: operator,
        right: parsedTerm,
      );
    }
    return workingExpression;
  }

  Expression parseTerm() {
    
  }

  Expression parseFactor() {
    if (_match(tokenTypeList: [TokenType.number])) {
      return NumberLiteral(val: int.parse(_previous().val));
    }

    if (_match(tokenTypeList: [TokenType.openParanthesis])) {
      Expression parsedExpression = parseExpression();
      _consume(
        tokenType: TokenType.closeParanthesis,
        message: "Missing Close Paranthesis",
      );
      return parsedExpression;
    }
  }
}

class ParserError implements Error {
  final String errorMessage;
  final Token token;

  ParserError({required this.errorMessage, required this.token});

  @override
  StackTrace? get stackTrace => StackTrace.fromString("No Stack Trace");
}
