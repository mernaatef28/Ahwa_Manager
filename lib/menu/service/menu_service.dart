
import '../model/menu.dart';
import '../repos/in_memory_menu_repos.dart';

class MenuService {
  final InMemoryMenuRepository _repo ;
  MenuService(this._repo) ;

  Future<List<MenuItem>> getMenu() {
    return _repo.watchAllMenu();
  }

  Future<void> addMenuItem(MenuItem item) {
    return _repo.addItemFromMenu(item);
  }

  Future<void> deleteMenuItem(int id) {
    return _repo.deleteItemFromMenu(id);
  }

  Future<void> updateMenuItem(MenuItem item) {
    return _repo.updateItemOnTheMenu(item);
  }
}
