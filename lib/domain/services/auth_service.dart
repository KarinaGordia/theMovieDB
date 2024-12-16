import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';

class AuthorizationService {
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuthorized() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    return sessionId != null;
  }
}