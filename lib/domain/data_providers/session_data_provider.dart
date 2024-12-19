import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const sessionId = 'session_id';
  static const accountId = 'account_id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() => _secureStorage.read(key: _Keys.sessionId);

  Future<int?> getAccountId() async {
    final idString = await _secureStorage.read(key: _Keys.accountId);
    return idString != null ? int.tryParse(idString) : null;
  }

  Future<void> setSessionId(String value) {
    return _secureStorage.write(key: _Keys.sessionId, value: value);
  }

  Future<void> setAccountId(int value) {
    return _secureStorage.write(key: _Keys.accountId, value: value.toString());
  }

  Future<void> deleteSessionId() => _secureStorage.delete(key: _Keys.sessionId);

  Future<void> deleteAccountId() => _secureStorage.delete(key: _Keys.accountId);
}
