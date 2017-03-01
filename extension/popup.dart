import 'dart:async';
import 'dart:html';

import 'package:bendium/bendium.dart';
import 'package:chrome/chrome_ext.dart' as chrome;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;

BenderAdapter adapter = new BenderAdapter();

Future<String> currentUrl() async {
  var tab = await chrome.tabs.getSelected();
  return tab.url;
}

Future<Null> updateToken(String token) async {
  await chrome.storage.local.set({'hipchat-token': token});
  adapter.token = token;
}

Future<Null> main() async {
  react_client.setClientConfiguration();
  String url = await currentUrl();
  Map<String, String> data = await chrome.storage.local.get({'hipchat-token': ''});
  adapter.token = data['hipchat-token'];
  final container = querySelector('#container');
  final popup = (Popup()..bender = adapter..currentUrl = url..updateTokenCallback = updateToken)();
  react_dom.render(popup,
      container);
}
