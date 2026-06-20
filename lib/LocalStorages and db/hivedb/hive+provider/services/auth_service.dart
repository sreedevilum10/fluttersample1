
import 'package:fluttersample1/LocalStorages%20and%20db/hivedb/hive+provider/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String boxName = "users";

  Future<Box> getBox() async {
    return await Hive.openBox(boxName);
  }

  Future<bool> register(UserModel user) async {
    final box = await getBox();
    if (box.containsKey(user.username)) {
      return false;
    }
    await box.put(
      user.username,
      user.toMap(),
    );
    return true;
  }

  Future<bool> login(String username, String password) async {
    final box = await getBox();
    final data = box.get(username);
    if (data == null) {
      return false;
    }
    return data["password"] == password;
  }
}