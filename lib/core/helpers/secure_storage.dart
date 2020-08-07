import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {

  static final storage = FlutterSecureStorage();

  static Future<void> set({String name, String value}) async {
    await storage.write(key: name, value: value);
  }

  static Future<String> get(String name) async {
    String email = await storage.read(key: name);
    return email;
  }

  static Future<void> delete(String name) async {
    await storage.delete(key: name);
  }
}