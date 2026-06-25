/*
  E -> E ( '+' | '-' T )*
  T -> F ( '*' | '/' F )*
  F -> Integer | '(' E ')'
  
  E => Expression
  T => Term
  F => Factor
*/

enum TokenType {
  number,
  plus,
  minus,
  star,
  slash,
  openParanthesis,
  closeParanthesis,
  eof,
}

class Token {
  TokenType tokenType;
  String val = "";

  Token({required this.tokenType});
  Token.val({required this.tokenType, required this.val});

  set setVal(String val) {
    this.val = val;
  }

  @override
  String toString() {
    return "[$tokenType Val: $val]\n";
  }
}
