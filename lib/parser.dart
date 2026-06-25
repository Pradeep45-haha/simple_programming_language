import 'package:a_very_simple_lang/expression.dart';
import 'package:a_very_simple_lang/token.dart';

class Parser {
  bool enableLogging = true;
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
    _idx = _idx + 1;
    return _tokens[_idx - 1];
  }

  bool _check({required TokenType tokenType}) {
    if (_isAtEnd()) {
      return tokenType == TokenType.eof;
    }

    return _peek().tokenType == tokenType;
  }

  Token _consume({required TokenType tokenType, required String message}) {
    if (_check(tokenType: tokenType)) {
      return _advance();
    }

    throw ParserError(errorMessage: message, token: _peek());
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

  Expression parse() {
    if (enableLogging == true) print("parse");
    Expression expression = _parseExpression();
    _consume(tokenType: TokenType.eof, message: "No eof token");
    return expression;
  }

  Expression _parseExpression() {
    if (enableLogging == true) print("_parseExpression");
    Expression workingExpression = _parseTerm();

    while (_match(tokenTypeList: [TokenType.plus, TokenType.minus])) {
      Token operator = _previous();
      Expression parsedTerm = _parseTerm();

      workingExpression = BinaryOperator(
        left: workingExpression,
        operator: operator,
        right: parsedTerm,
      );
    }
    return workingExpression;
  }

  Expression _parseTerm() {
    if (enableLogging == true) print("_parseTerm");
    Expression workingExpression = _parseFactor();

    while (_match(tokenTypeList: [TokenType.star, TokenType.slash])) {
      Token operator = _previous();
      Expression parsedFactor = _parseFactor();

      workingExpression = BinaryOperator(
        left: workingExpression,
        operator: operator,
        right: parsedFactor,
      );
    }
    return workingExpression;
  }

  Expression _parseFactor() {
    if (enableLogging == true) print("_parseFactor");
    if (_match(tokenTypeList: [TokenType.number])) {
      return NumberLiteral(val: int.parse(_previous().val));
    }

    if (_match(tokenTypeList: [TokenType.openParanthesis])) {
      Expression parsedExpression = _parseExpression();
  
      _consume(
        tokenType: TokenType.closeParanthesis,
        message: "Missing Close Paranthesis",
      );
      return parsedExpression;
    }

    throw ParserError(errorMessage: "Invalid Token", token: _peek());
  }
}

class ParserError implements Error {
  final String errorMessage;
  final Token token;

  ParserError({required this.errorMessage, required this.token});

  @override
  StackTrace? get stackTrace => StackTrace.fromString("No Stack Trace");
}
