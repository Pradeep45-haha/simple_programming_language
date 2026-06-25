// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_very_simple_lang/token.dart';

abstract class Expression {}

class NumberLiteral extends Expression {
  final int val;
  NumberLiteral({required this.val});

  @override
  String toString() {
    return "NumberLiteral:$val";
  }
}

class BinaryOperator extends Expression {
  final Expression left;
  final Expression right;
  final Token operator;

  BinaryOperator({
    required this.left,
    required this.right,
    required this.operator,
  });

  @override
  String toString() {
    return "${left.toString()} ${operator.tokenType} ${right.toString()}";
  }
}
