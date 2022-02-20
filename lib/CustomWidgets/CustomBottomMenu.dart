import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  CustomBottomMenu({required this.selectedIndex, required this.callback});

  final int selectedIndex;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: callback,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Терминал',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Отчет',
        )
      ],
    );
  }
}