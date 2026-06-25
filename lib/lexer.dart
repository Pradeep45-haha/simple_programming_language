import 'package:a_very_simple_lang/token.dart';

class Lexer {
  String input;

  Lexer({required this.input});

  final List<Token> _tokens = [];
  int _currentPosition = 0;

  String _advance() {
    String returnChar = input[_currentPosition];
    _currentPosition++;
    return returnChar;
  }

  bool _isAtEnd() {
    if (_currentPosition >= input.length) {
      return true;
    }
    return false;
  }

  void _scanNextToken() {
    String currentChar = _advance();
    if (currentChar == '(') {
      _tokens.add(Token(tokenType: TokenType.openParanthesis));
    } else if (currentChar == ')') {
      _tokens.add(Token(tokenType: TokenType.closeParanthesis));
    } else if (currentChar == '+') {
      _tokens.add(Token(tokenType: TokenType.plus));
    } else if (currentChar == '-') {
      _tokens.add(Token(tokenType: TokenType.minus));
    } else if (currentChar == '*') {
      _tokens.add(Token(tokenType: TokenType.star));
    } else if (currentChar == '/') {
      _tokens.add(Token(tokenType: TokenType.slash));
    } else if (<String>[
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ].contains(currentChar)) {
      if (_tokens.isNotEmpty && _tokens.last.tokenType == TokenType.number) {
        int i = _tokens.length - 1;
        Token prevToken = _tokens[i];
        String tokenVal = prevToken.val + currentChar;
        Token currToken = Token.val(tokenType: TokenType.number, val: tokenVal);
        _tokens[i] = currToken;
      } else {
        _tokens.add(Token.val(tokenType: TokenType.number, val: currentChar));
      }
    } else if (currentChar == ' ' ||
        currentChar == '\n' ||
        currentChar == 't' ||
        currentChar == '\r') {
    } else {
      throw LexerError(
        errorMessage: "Invalid Character at $_currentPosition",
        val: currentChar,
      );
    }
  }

  List<Token> scanTokens() {
    while (!_isAtEnd()) {
      _scanNextToken();
    }
    if(_tokens.last.tokenType!= TokenType.eof)
    {
      _tokens.add(Token(tokenType: TokenType.eof));
    }
    return _tokens;
  }

  @override
  String toString() {
    String str = "";
    for (int i = 0; i < _tokens.length; i++) {
      str = str + _tokens[i].toString();
    }
    return str;
  }
}

class LexerError implements Error {
  final String errorMessage;
  final String val;

  LexerError({required this.errorMessage, required this.val});

  @override
  StackTrace? get stackTrace => StackTrace.fromString("No Stack Trace");
}
