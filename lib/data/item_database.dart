import 'package:hive_flutter/hive_flutter.dart';

class ItemsDatabase {
  List itemsList = [];

  //reference our box
  final _itemsBox = Hive.box('itemsBox');

  // run this method if this is first time opening the aoo
  void createInitialData() {
    itemsList = [
      ["Welcome To Item List", false],
      ["Slide to Left to Delete Item", false],
    ];
  }

  // load the data from Database
  void loadData() {
    itemsList = _itemsBox.get("ITEMSLIST");
  }

  //update the Database
  void updateDataBase() {
    _itemsBox.put("ITEMSLIST", itemsList);
  }
}
