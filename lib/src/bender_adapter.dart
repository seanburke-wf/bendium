import 'dart:async';
import 'dart:html';

const endpoint = 'https://workiva.hipchat.com/v2/user/@Bender/message';

class BenderAdapter {
  String token;

  BenderAdapter();

  Map<String, String> get headers => {'Authorization': 'Bearer $token'};

  Future<Null> createTicket(String url) async {
    print('BenderAdapter.createTicket');
    url = validateAndCoerceToPullRequestUrl(url);
    await sendMessage('ticket $url');
  }

  Future<Null> monitorPullRequest(String url) async {
    print('BenderAdapter.monitorPullRequest');
    url = validateAndCoerceToPullRequestUrl(url);
    await sendMessage('monitor pr $url');
  }

  Future<Null> sendMessage(String message) async {
    print('BenderAdapter.sendMessage');
    var request = await HttpRequest.request(endpoint,
        method: 'POST', sendData: message, requestHeaders: headers);
    if (request.status != 204) {
      throw new Exception('Sending message failed: ${request.statusText}');
    }
  }
}

String validateAndCoerceToPullRequestUrl(String url) {
  print('validateAndCoerceToPullRequestUrl $url');
  if (url == null) {
    throw new ArgumentError.notNull('url');
  }
  final re = new RegExp(r'(https://github\.com/.*/pull/\d+).*');
  String prUrl;
  try {
    prUrl = re.allMatches(url)?.first?.group(1);
  } catch (exc, trace) {
    print('$exc $trace');
  }
  if (prUrl == null) {
    throw new ArgumentError.value(
        url, 'url', 'Not a PR url; does not match $re');
  }
  return prUrl;
}
