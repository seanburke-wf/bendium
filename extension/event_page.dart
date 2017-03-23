import 'dart:async';

import 'package:bendium/bendium.dart';
import 'package:chrome/chrome_ext.dart' as chrome;

BenderAdapter adapter = new BenderAdapter();

Future<String> currentUrl() async {
  var tab = await chrome.tabs.getSelected();
  return tab.url;
}

Future<Null> main() async {
  String url = await currentUrl();
  Map<String, dynamic> data = await chrome.storage.local.get({'hipchat-token': ''});
  adapter.token = data['hipchat-token'] as String;

  // Listen to keyboard shortcuts
  chrome.commands.onCommand.listen((String eventName) async {
    // Names come from manifest.json
    switch (eventName) {
      case 'createTicket':
        adapter.createTicket(url);
        break;
      case 'monitorPullRequest':
      default:
        adapter.monitorPullRequest(url);
    }
  });
}