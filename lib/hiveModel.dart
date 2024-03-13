//Class Hive
import 'package:hive/hive.dart';

var box = Hive.box("favoriteText_box");

class HiveModel {
  //get Hive
  getHive(String get) {
    box.get(get);
  }

  //deleteHive
  deleteHive(String delete) {
    box.delete(delete);
  }

  //putHive
  putHive(String key, var value) {
    box.put(key, value);
  }
}
