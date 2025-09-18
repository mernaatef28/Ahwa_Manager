
import '../model/menu.dart';
import 'menu_i_repos.dart';

class InMemoryMenuRepository implements MenuIRepository {
  final List<MenuItem> _items = [
    MenuItem(1, "", 10.0 , "Shai (Tea)"),
    MenuItem(2, "", 15.0 , "Turkish Coffee"),
    MenuItem(3, "", 12.0 ,"Hibiscus Tea"),
  ];

  @override
  Future<void> addItemFromMenu(MenuItem newItem) async {
    _items.add(newItem);
  }

  @override
  Future<void> deleteItemFromMenu(int id) async {
    _items.removeWhere((item) => item.id == id);
  }

  @override
  Future<void> updateItemOnTheMenu(MenuItem updatedItem) async {
    final index = _items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _items[index] = updatedItem;
    }
  }

  @override
  Future<List<MenuItem>> watchAllMenu() async {
    // return a copy so caller can't modify directly
    return List<MenuItem>.from(_items);
  }
}
