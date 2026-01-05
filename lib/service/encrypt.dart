import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';

class EncryptionHelper {
  static Future<String> decrypt(String encryptedText) async {
    final prefs = await SharedPreferences.getInstance();

    final key = encrypt.Key.fromBase64(prefs.getString('key')!);
    final iv = encrypt.IV.fromBase64(prefs.getString('iv')!);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    return encrypter.decrypt64(encryptedText, iv: iv);
  }
}
