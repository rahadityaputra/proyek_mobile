import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rational/rational.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

enum BinaryOperator { addition, substraction, multiplication, division }

final _binaryOperatorsSymbolMap = {
  BinaryOperator.addition: "+",
  BinaryOperator.substraction: "-",
  BinaryOperator.multiplication: "×",
  BinaryOperator.division: "/",
};

class HistoryItem {
  final String operations;
  final Rational result;

  HistoryItem({required this.operations, required this.result});
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<Rational> _numberStack = [];
  BinaryOperator? _operator = null;
  Rational? _operationResult = null;
  bool _operationReversed = false;
  Rational? _currentNumberOverride = null;
  String _currentNumberAbsolute = "0";
  bool _currentNumberPositive = true;
  List<HistoryItem> _histories = [];

  String get _currentNumberText {
    // return _currentNumberRational.toDecimal(scaleOnInfinitePrecision: 9).toString();
    // this will make zero after decimal gone
    if (_operationResult != null) return _operationResult!.toDecimal(scaleOnInfinitePrecision: 9).toString();
    if (_currentNumberOverride != null) return _currentNumberOverride!.toDecimal(scaleOnInfinitePrecision: 9).toString();
    return (_currentNumberPositive ? "" : "-") + _currentNumberAbsolute;
  }

  Rational get _currentNumberRational {
    if (_operationResult != null) return _operationResult!;
    if (_currentNumberOverride != null) return _currentNumberOverride!;
    return Rational.parse(_currentNumberAbsolute) *
        Rational.fromInt(_currentNumberPositive ? 1 : -1);
  }

  String get _stackPreview {
    if (_numberStack.isEmpty) return "";

    String result = "${_numberStack.first.toDecimal(scaleOnInfinitePrecision: 9)}";
    if (_operator != null) {
      result += " ${_binaryOperatorsSymbolMap[_operator]}";
    }
    if (_numberStack.length > 1) {
      result += " ${_numberStack[1].toDecimal(scaleOnInfinitePrecision: 9)}";
    }
    if (_operationReversed) {
      result = "-($result)";
    }
    if (_operationResult != null) {
      result += " =";
    }
    return result;
  }

  void _resetCurrentNumber() {
    _currentNumberOverride = null;
    _currentNumberAbsolute = "0";
    _currentNumberPositive = true;
  }

  void _resetOperationResult() {
    if (_operationResult != null) {
      _numberStack.clear();
      _operationResult = null;
      _operationReversed = false;
      _operator = null;
      _resetCurrentNumber();
    }
  }

  void _reset() {
    setState(() {
      _numberStack.clear();
      _operationResult = null;
      _operationReversed = false;
      _operator = null;
      _resetCurrentNumber();
    });
  }

  void _addDigit(String digit) {
    setState(() {
      _resetOperationResult();
      _currentNumberOverride = null;
      if (_currentNumberAbsolute == "0") {
        _currentNumberAbsolute = digit;
        return;
      }
      _currentNumberAbsolute += digit;
    });
  }

  void _removeLastChar() {
    setState(() {
      _currentNumberOverride = null;
      if (_operationResult != null) {
        final last = _operationResult!;
        _resetOperationResult();
        _currentNumberAbsolute = last.abs().toDecimal(scaleOnInfinitePrecision: 9).toString();
        _currentNumberPositive = last.signum > 0;
      }
      _currentNumberAbsolute = _currentNumberAbsolute.substring(
        0,
        _currentNumberAbsolute.length - 1,
      );
      if (_currentNumberAbsolute.isEmpty) _currentNumberAbsolute = "0";
    });
  }

  void _reverseSign() {
    setState(() {
      if (_operationResult != null) {
        _operationResult = _operationResult! * Rational.parse("-1");
        _operationReversed = !_operationReversed;
      } else {
        _currentNumberPositive = !_currentNumberPositive;
        if (_currentNumberOverride != null) {
          _currentNumberOverride = _currentNumberOverride! * Rational.parse("-1");
        }
      }
    });
  }

  void _addDecimalSeparator() {
    setState(() {
      if (_operationResult != null) _resetOperationResult();
      if (_currentNumberAbsolute.contains(".")) return;

      _resetOperationResult();
      _currentNumberOverride = null;
      _currentNumberAbsolute += ".";
    });
  }

  void _setOperator(BinaryOperator operator) {
    setState(() {
      if (_operationResult != null) {
        _numberStack.clear();
        _numberStack.add(_operationResult!);
        _operationResult = null;
        _operationReversed = false;
        _resetCurrentNumber();
      } else if (_operator == null) {
        _numberStack.add(_currentNumberRational);
        _resetCurrentNumber();
      }
      _operator = operator;
    });
  }

  void _submit() {
    setState(() {
      if (_numberStack.length == 1 &&
          _operator == BinaryOperator.division &&
          _currentNumberRational == Rational.parse("0")) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text("Division by zero"),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        return;
      }
      if (_numberStack.isEmpty ||
          (_numberStack.length == 1 && _operator != null)) {
        _numberStack.add(_currentNumberRational);
      } else {
        _numberStack[0] = _currentNumberRational;
      }

      if (_numberStack.length == 1) {
        _operationResult = _numberStack.first;
        _operationReversed = false;
      } else if (_numberStack.length == 2) {
        Rational c = Rational.parse("0");
        final a = _numberStack[0];
        final b = _numberStack[1];
        switch (_operator) {
          case null:
            return;
          case BinaryOperator.addition:
            c = a + b;
            break;
          case BinaryOperator.substraction:
            c = a - b;
            break;
          case BinaryOperator.multiplication:
            c = a * b;
            break;
          case BinaryOperator.division:
            c = a / b;
            break;
        }
        _operationResult = c;
        _operationReversed = false;
      }

      _histories.insert(
        0,
        HistoryItem(operations: _stackPreview, result: _currentNumberRational),
      );
    });
  }

  static bool _isPrime(BigInt value) {
    if (value == BigInt.from(1)) {
      return false;
    }
    for (BigInt i = BigInt.from(2); i < value; i += BigInt.from(1)) {
      if (value % i == BigInt.from(0)) {
        return false;
      }
    }
    return true;
  }

  void _showInfoDialog() {
    final number = _currentNumberRational;
    final jenis = !number.isInteger
        ? "Desimal"
        : number.toBigInt() % BigInt.from(2) == BigInt.from(0)
        ? "Genap"
        : "Ganjil";
    final prima = !number.isInteger || number < Rational.parse("1")
        ? Future.value(false)
        : compute(_isPrime, number.toBigInt());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Informasi Angka"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Angka $number adalah $jenis"),
              FutureBuilder(
                future: prima,
                builder: (context, future) {
                  if (!future.hasData) {
                    return Column(
                      children: [
                        Text("Menguji apakah bilangan prima atau bukan"),
                        LinearProgressIndicator(),
                      ],
                    );
                  }
                  return Text(
                    !number.isInteger
                        ? "Bilangan desimal jelas bukan prima"
                        : future.data!
                        ? "Ini bilangan prima"
                        : "Ini bukan bilangan prima",
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showHistorySheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildHistoryList(context, true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width <= 768;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: isMobile
            ? [
                IconButton(
                  onPressed: _showHistorySheet,
                  icon: Icon(Icons.history),
                ),
              ]
            : [],
      ),
      body: SafeArea(
        child: isMobile
            ? _buildMainView(context)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 480),
                    child: _buildMainView(context),
                  ),
                  Flexible(child: _buildHistoryList(context, false)),
                ],
              ),
      ),
    );
  }

  Column _buildHistoryList(BuildContext context, bool isBottomSheet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("History", style: Theme.of(context).textTheme.titleLarge),
        ),
        Expanded(
          child: _histories.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Empty",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : ListView.builder(
                  itemCount: _histories.length,
                  itemBuilder: (context, index) {
                    final item = _histories[index];
                    return _buildHistoryItem(item, isBottomSheet, context);
                  },
                ),
        ),
      ],
    );
  }

  Column _buildHistoryItem(
    HistoryItem item,
    bool isBottomSheet,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            _reset();
            if (!item.result.hasFinitePrecision) {
              _currentNumberOverride = item.result;
            } else {
              _currentNumberOverride = null;
            }
            _currentNumberAbsolute = item.result.toDecimal(scaleOnInfinitePrecision: 9).abs().toString();
            _currentNumberPositive = item.result.signum >= 0;
            if (isBottomSheet) {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.operations,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  item.result.toDecimal(scaleOnInfinitePrecision: 9).toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        Divider(height: 0),
      ],
    );
  }

  Column _buildMainView(BuildContext context) {
    final secondaryColor = Colors.grey[700];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SingleChildScrollView(
                child: Text(
                  _stackPreview,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  _currentNumberText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(onPressed: _showInfoDialog, icon: Icon(Icons.info)),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildGridRow([
                _buildGridButtonText(
                  "C",
                  onTap: _reset,
                  flex: 2,
                  color: Colors.grey[300],
                ),
                _buildGridButton(
                  child: Icon(Icons.backspace, color: Colors.white),
                  onTap: _removeLastChar,
                  color: Colors.red,
                ),
                _buildGridButtonText(
                  "÷",
                  onTap: () => _setOperator(BinaryOperator.division),
                  color: secondaryColor,
                  foreground: Colors.white,
                ),
              ]),
              _buildGridRow([
                _buildDigitButton("7"),
                _buildDigitButton("8"),
                _buildDigitButton("9"),
                _buildGridButtonText(
                  "×",
                  onTap: () => _setOperator(BinaryOperator.multiplication),
                  color: secondaryColor,
                  foreground: Colors.white,
                ),
              ]),
              _buildGridRow([
                _buildDigitButton("4"),
                _buildDigitButton("5"),
                _buildDigitButton("6"),
                _buildGridButtonText(
                  "-",
                  onTap: () => _setOperator(BinaryOperator.substraction),
                  color: secondaryColor,
                  foreground: Colors.white,
                ),
              ]),
              _buildGridRow([
                _buildDigitButton("1"),
                _buildDigitButton("2"),
                _buildDigitButton("3"),
                _buildGridButtonText(
                  "+",
                  onTap: () => _setOperator(BinaryOperator.addition),
                  color: secondaryColor,
                  foreground: Colors.white,
                ),
              ]),
              _buildGridRow([
                _buildGridButtonText("+/-", onTap: _reverseSign),
                _buildDigitButton("0"),
                _buildGridButtonText(".", onTap: _addDecimalSeparator),
                _buildGridButtonText(
                  "=",
                  onTap: _submit,
                  color: Colors.green,
                  foreground: Colors.white,
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGridRow(List<Widget> children) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 80),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDigitButton(String digit) {
    return _buildGridButtonText(
      digit,
      onTap: () {
        _addDigit(digit);
      },
    );
  }

  Widget _buildGridButtonText(
    String text, {
    void Function()? onTap,
    int flex = 1,
    Color? color,
    Color? foreground,
  }) {
    return _buildGridButton(
      onTap: onTap,
      flex: flex,
      color: color,
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: foreground),
      ),
    );
  }

  Widget _buildGridButton({
    required Widget child,
    void Function()? onTap,
    int flex = 1,
    Color? color,
  }) {
    return Expanded(
      flex: flex,
      child: Card.outlined(
        color: color ?? null,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}
