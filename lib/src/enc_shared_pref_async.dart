import 'dart:async';
import 'package:encrypt_shared_preferences/src/batch.dart';
import 'package:encrypt_shared_preferences/src/crypto/aes.dart';
import 'package:encrypt_shared_preferences/src/crypto/encryptor.dart';
import 'package:encrypt_shared_preferences/src/decorators/shared_preferences_decorator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedSharedPreferencesAsync {
  EncryptedSharedPreferencesAsync._();

  static String? _key;

  static late SharedPreferencesDecorator _decorator;

  static final EncryptedSharedPreferencesAsync _instance =
  EncryptedSharedPreferencesAsync._();

  static EncryptedSharedPreferencesAsync getInstance() {
    assert(_key != null);
    return _instance;
  }

  /// Stream that emits a new value whenever the SharedPreferences data changes.
  Stream<String> get stream => _decorator.listenable.stream;

  /// Initialize the EncryptedSharedPreferences with the provided encryption key.
  static Future<void> initialize(String key, {IEncryptor? encryptor}) async {
    _key = key;
    _decorator = SharedPreferencesDecorator(
        preferences: await SharedPreferences.getInstance(),
        encryptor: encryptor ?? AESEncryptor(),
        key: _key!);
  }

  /// Clear all key-valure pairs from SharedPreferences.
  Future<bool> clear({bool notify = true}) async {
    assert(_key != null);
    return _decorator.clear(notify: notify);
  }

  /// Remove by checking condition.
  Future<bool> removeWhere(
      {bool notify = true,
        bool notifyEach = false,
        required Function(String key, String value) condition}) async {
    assert(_key != null);
    return _decorator.removeWhere(
        condition: condition, notify: notify, notifyEach: notifyEach);
  }

  /// Remove the value associated with the specified key from SharedPreferences.
  Future<bool> remove(String key, {bool notify = true}) async {
    assert(_key != null);
    _decorator.remove(key, notify: notify);
    return true;
  }

  /// Get the set of all keys stored in SharedPreferences.
  Set<String> getKeys() {
    assert(_key != null);
    return _decorator.getKeys();
  }

  /// Get the string value associated with the specified key.
  String? get(String key, {String? defaultValue}) {
    assert(_key != null);
    return _decorator.get(key, defaultValue: defaultValue);
  }

  /// Set the string value for the specified key in SharedPreferences.
  Future<bool> setString(String dataKey, String? dataValue,
      {bool notify = true}) async {
    assert(_key != null);
    return _decorator.setString(dataKey, dataValue, notify: notify);
  }

  /// Set the integer value for the specified key in SharedPreferences.
  Future<bool> setInt(String dataKey, int? dataValue,
      {bool notify = true}) async {
    assert(_key != null);
    return _decorator.setInt(dataKey, dataValue, notify: notify);
  }

  /// Set the double value for the specified key in SharedPreferences.
  Future<bool> setDouble(String dataKey, double? dataValue,
      {bool notify = true}) async {
    assert(_key != null);
    return _decorator.setDouble(dataKey, dataValue, notify: notify);
  }

  /// Set the boolean value for the specified key in SharedPreferences.
  Future<bool> setBoolean(String dataKey, bool? dataValue,
      {bool notify = true}) async {
    assert(_key != null);
    return _decorator.setBool(dataKey, dataValue, notify: notify);
  }

  /// Get the string value associated with the specified key.
  String? getString(String key, {String? defaultValue}) {
    assert(_key != null);
    return _decorator.getString(key, defaultValue: defaultValue);
  }

  /// Get the integer value associated with the specified key.
  int? getInt(String key, {int? defaultValue}) {
    assert(_key != null);
    return _decorator.getInt(key, defaultValue: defaultValue);
  }

  /// Get the double value associated with the specified key.
  double? getDouble(String key, {double? defaultValue}) {
    assert(_key != null);
    return _decorator.getDouble(key, defaultValue: defaultValue);
  }

  /// Get the boolean value associated with the specified key.
  bool? getBoolean(String key, {bool? defaultValue}) {
    assert(_key != null);
    return _decorator.getBool(key, defaultValue: defaultValue);
  }

  /// Reload SharedPreferences data from disk.
  Future<void> reload() {
    assert(_key != null);
    return _decorator.reload();
  }

  /// Observe changes to the value associated with the specified key in SharedPreferences.
  Stream<String> observe({String? key}) {
    assert(_key != null);
    return _decorator.listen(key: key);
  }

  /// Observe changes to the values associated with the specified set of keys in SharedPreferences.
  Stream<String> observeSet({required Set<String> keys}) {
    assert(_key != null);
    return _decorator.listenSet(keys: keys);
  }

  /// @deprecated Use the observe() instead.
  @Deprecated('Use the observe() instead.')
  Stream<String> listen({String? key}) {
    assert(_key != null);
    return _decorator.listen(key: key);
  }

  /// @deprecated Use the observeSet() instead.
  @Deprecated('Use the observeSet() instead.')
  Stream<String> listenSet({required Set<String> keys}) {
    assert(_key != null);
    return _decorator.listenSet(keys: keys);
  }

  /// Notify listeners
  Stream<String> notifyObservers() {
    assert(_key != null);
    return _decorator.notifyObservers();
  }

  ///Save map
  Future<void> setMap(Map<String, dynamic> map, {bool notify = true}) =>
      _decorator.setMap(map);

  ///Save with batch
  Future<void> batch(Future<bool> Function(BatchSharedPreferences batch) invoke,
      {bool notify = true}) =>
      _decorator.batch(invoke, notify: notify);
}
