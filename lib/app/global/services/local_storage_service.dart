import 'package:get_storage/get_storage.dart';

class LocalStoreService {
  // Instance of GetStorage
  final GetStorage _storage = GetStorage();

  /// Read data from storage
  Future<dynamic> read(String key) async {
    return await _storage.read(key);
  }

  /// Write data to storage
  Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  /// Delete data from storage
  Future<void> delete(String key) async {
    await _storage.remove(key);
  }

  /// Clear all data from storage
  Future<void> clear() async {
    await _storage.erase();
  }
}
