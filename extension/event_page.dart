import 'dart:async';

import 'package:bendium/bendium.dart';
import 'package:chrome/chrome_ext.dart' as chrome;
import 'utils.dart';


Future<Null> main() async {
  // NOTE: Use the "Inspect views: background page" feature of chrome://extensions/ to see logs and errors
  Map<String, dynamic> data = await chrome.storage.local.get({'hipchat-token': ''});
  BenderAdapter adapter = new BenderAdapter();
  adapter.token = data['hipchat-token'] as String;

  // Listen to keyboard shortcuts
  chrome.commands.onCommand.listen((String eventName) async {
    print('event_page.dart received chrome command $eventName');

    // BEWARE: Do not try to get the url outside of this event listener
    // or it will be wrong, likely the chrome://extensions url
    String url = await currentUrl();

    // Names come from manifest.json
    switch (eventName) {
      case 'createTicket':
        await adapter.createTicket(url);
        break;
      case 'monitorPullRequest':
        await adapter.monitorPullRequest(url);
        break;
      default:
        print('Didn\'t understand command name $eventName; ignoring');
    }
  });
}