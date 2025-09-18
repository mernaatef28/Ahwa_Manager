import 'package:smart_ahwa_app/menu/model/menu.dart';

abstract class MenuIRepository {
  Future<void> watchAllMenu () ;
  Future<void> deleteItemFromMenu (int id ) ;
  Future<void> addItemFromMenu (MenuItem newItem ) ;
  Future<void> updateItemOnTheMenu (MenuItem updatedItem) ;
}