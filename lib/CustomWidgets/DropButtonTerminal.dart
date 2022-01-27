import 'package:flutter/material.dart';



class DropButtonTerminal extends StatefulWidget {
  const DropButtonTerminal({Key? key}) : super(key: key);

  @override
  State<DropButtonTerminal> createState() => _DropButtonTerminalState();
}

class _DropButtonTerminalState extends State<DropButtonTerminal> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Tinkoff', 'Alpha']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
