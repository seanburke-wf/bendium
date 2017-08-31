import 'dart:async';
import 'dart:html';

const endpoint = 'https://workiva.hipchat.com/v2/user/@Bender/message';

class BenderAdapter {
  String token;

  BenderAdapter();

  Map<String, String> get headers => {'Authorization': 'Bearer $token'};

  Future<Null> sendMessage(String message) async {
    print('BenderAdapter.sendMessage: $message');
    var request = await HttpRequest.request(endpoint,
        method: 'POST', sendData: message, requestHeaders: headers);
    if (request.status != 204) {
      throw new Exception('Sending message failed: ${request.statusText}');
    }
  }
}
