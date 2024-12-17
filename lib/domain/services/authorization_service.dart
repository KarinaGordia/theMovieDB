import 'package:the_movie_db/domain/domain.dart';

class AuthorizationService {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuthorized() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    return sessionId != null;
  }

  Future<void> logIn(String login, String password) async {
    final sessionId = await _authApiClient.auth(userName: login, password: password);
    final accountId = await _accountApiClient.getAccountId(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
}
}