part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class ResetAc extends CalculatorEvent {}

class Del extends CalculatorEvent {}

class AddNumber extends CalculatorEvent {
  final String number;

  AddNumber(this.number);
}

class ChangeOperator extends CalculatorEvent {
  final String operator;

  ChangeOperator(this.operator);
}

class Result extends CalculatorEvent {}

class ChangeNegativePositive extends CalculatorEvent {}
