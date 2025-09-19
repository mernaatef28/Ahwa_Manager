import 'package:flutter/material.dart';
import 'package:smart_ahwa_app/report/ui/daily_report_screen.dart';

import 'menu/ui/menu_screen_for_manager.dart';
import 'order/ui/orders_for_manager.dart';

// import 'menu/ui/menu_screen.dart';
// import 'order/ui/orders_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = const [MenuScreen(), OrdersScreen(), ReportScreen()];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Ahwa Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      body: tabs[_tab],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (i) => setState(() => _tab = i),
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.local_cafe_outlined),
              selectedIcon: Icon(Icons.local_cafe),
              label: 'Menu',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'Orders',
            ), NavigationDestination(
              icon: Icon(Icons.report),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'report',
            ),
          ],
        ),
      ),
    );
  }
}