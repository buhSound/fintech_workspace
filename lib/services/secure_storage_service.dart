import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    //aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveSessionToken(String token) async{
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getSessionToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> deleteSession() async{
    await _storage.delete(key: 'auth_token');
  }
}