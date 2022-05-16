import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState());

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    //Button Reset
    if (event is ResetAc) {
      //Llama a function
      yield* this._resetAC();

      //Agregar numeros
    } else if (event is AddNumber) {
      yield state.copyWith(
          mathResult: (state.mathResult == '0')
              ? event.number
              : state.mathResult + event.number);

      //Button Del
    } else if (event is Del) {
      yield state.copyWith(
          mathResult: state.mathResult.length > 1
              ? state.mathResult.substring(0, state.mathResult.length - 1)
              : '0');

      //Button changeOperator
    } else if (event is ChangeOperator) {
      yield state.copyWith(
          operation: event.operator,
          firstNumber: state.mathResult,
          secondNumber: '0',
          mathResult: '0');

      //Button Result
    } else if (event is Result) {
      yield* this._result();

      //Button Change Sign
    } else if (event is ChangeNegativePositive) {
      yield state.copyWith(
          mathResult: (state.mathResult.contains('-'))
              ? state.mathResult.replaceFirst('-', '')
              : '-' + state.mathResult);
    }
  }

  //Function to reset
  Stream<CalculatorState> _resetAC() async* {
    yield CalculatorState(
        firstNumber: '0', mathResult: '0', secondNumber: '0', operation: '+');
  }

  //Function to result
  Stream<CalculatorState> _result() async* {
    final double num1 = double.parse(state.firstNumber);
    final double num2 = double.parse(state.mathResult);

    switch (state.operation) {
      case '+':
        yield state.copyWith(
            mathResult: '${num1 + num2}', secondNumber: state.mathResult);
        break;
      default:
        yield state;
    }
  }
}
