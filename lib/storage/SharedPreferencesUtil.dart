import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String mnemonicKey = 'mnemonic_phrase';

  /// Save the mnemonic phrase to SharedPreferences
  static Future<void> saveMnemonicPhrase(String mnemonic) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(mnemonicKey, mnemonic);
  }

  /// Retrieve the mnemonic phrase from SharedPreferences
  static Future<String?> getMnemonicPhrase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(mnemonicKey);
  }

  /// Clear the mnemonic phrase from SharedPreferences
  static Future<void> clearMnemonicPhrase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(mnemonicKey);
  }
}
