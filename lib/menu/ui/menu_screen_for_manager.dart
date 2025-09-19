// lib/presentation/screens/menu_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_deps.dart';
import '../model/menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<void> _addItem(BuildContext context) async {
    final deps = DepsScope.of(context);
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Menu Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Add')),
        ],
      ),
    );

    if (ok == true) {
      final id = DateTime.now().millisecondsSinceEpoch;
      final name = nameCtrl.text.trim();
      final price = double.tryParse(priceCtrl.text) ?? 0;
      await deps.menuService.addMenuItem(MenuItem(id, name, price , ""));
      setState(() {});
    }
  }

  Future<void> _editItem(BuildContext context, MenuItem item) async {
    final deps = DepsScope.of(context);
    final nameCtrl = TextEditingController(text: item.name);
    final priceCtrl = TextEditingController(text: item.price.toString());

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Menu Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );

    if (ok == true) {
      final updated = MenuItem(item.id, nameCtrl.text.trim(), double.tryParse(priceCtrl.text) ?? item.price,"");
      await deps.menuService.updateMenuItem(updated);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final deps = DepsScope.of(context);
    return Scaffold(
      body: FutureBuilder<List<MenuItem>>(
        future: deps.menuService.getMenu(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snap.data ?? const <MenuItem>[];
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (_, i) {
              final m = items[i];
              return ListTile(
                title: Text(m.name),
                subtitle: Text('${m.price.toStringAsFixed(2)} EGP'),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editItem(context, m),
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await deps.menuService.deleteMenuItem(m.id);
                        setState(() {});
                      },
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addItem(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }
}
