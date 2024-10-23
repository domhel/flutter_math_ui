import 'package:flutter/material.dart';

class SimpleDropdown<T extends Enum> extends StatefulWidget {
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final List<T> values;

  const SimpleDropdown({
    super.key,
    this.initialValue,
    required this.values,
    required this.onChanged,
  });

  @override
  _SimpleDropdownState<T> createState() => _SimpleDropdownState<T>();
}

class _SimpleDropdownState<T extends Enum> extends State<SimpleDropdown<T>> {
  late T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T?>(
      hint: const Text('select'),
      value: selectedValue,
      onChanged: (T? newValue) {
        setState(() {
          selectedValue = newValue;
          widget.onChanged(newValue);
        });
      },
      items: widget.values.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
