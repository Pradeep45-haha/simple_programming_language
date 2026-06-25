/*
  E -> E + T
  E -> E - T
  E -> T

  T -> T * F
  T -> T / F
  T -> F

  F -> Integers 
  F -> ( E )
*/

enum TokenType {
  number,
  plus,
  minus,
  star,
  slash,
  openParanthesis,
  closeParanthesis,
  eof
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
