import 'dart:async';
import 'dart:html';

import 'package:bendium/bendium.dart';
import 'package:chrome/chrome_ext.dart' as chrome;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'utils.dart';

Future<Null> updateToken(BenderAdapter adapter, String token) async {
  await chrome.storage.local.set({'hipchat-token': token});
  adapter.token = token;
}

Future<Null> main() async {
  react_client.setClientConfiguration();
  String url = await currentUrl();
  Map<String, dynamic> data = await chrome.storage.local.get({'hipchat-token': ''});
  BenderAdapter adapter = new BenderAdapter();
  adapter.token = data['hipchat-token'] as String;
  final container = querySelector('#container');
  final popup = (Popup()
    ..bender = adapter
    ..currentUrl = url
    ..updateTokenCallback = (String token) => updateToken(adapter, token))();
  react_dom.render(popup,
      container);
}
