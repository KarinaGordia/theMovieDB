import 'package:the_movie_db/domain/domain.dart';

class AuthorizationService {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuthorized() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    return sessionId != null;
  }

  Future<void> logIn(String login, String password) async {
    final sessionId = await _apiClient.auth(userName: login, password: password);
    final accountId = await _apiClient.getAccountId(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
}
}