import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  CustomBottomMenu({required this.selectedIndex, required this.callback});

  final int selectedIndex;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    //BottomNavigationBar is automatically set to type 'fixed'
    // when there are three of less items
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: callback,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Terminal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Report',
        )
      ],

    );
  }

}
