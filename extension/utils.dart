import 'dart:async';
import 'package:chrome/chrome_ext.dart' as chrome;

/// Just for debugging this confusing API
Future dumpTabsQueryResults(chrome.TabsQueryParams queryInfo,
    [String msg]) async {
  print('Results of ${msg ?? queryInfo.toString()}:');
  List<chrome.Tab> tabs = await chrome.tabs.query(queryInfo);
  print(tabs.map((t) => '${t.title} ${t.url}').toList().join('\n'));
}

/// Get the url of the active tab.
Future<String> currentUrl() async {
  List<chrome.Tab> tabs =
      await chrome.tabs.query(new chrome.TabsQueryParams()..active = true);
  return tabs.first.url;
}

/// Temporarily set the text of the icon.
///
/// Chrome guidelines are to not exceed 4 chars of text.
/// You can await this, but typically you won't want to.
Future flashBadge(String text,
    {Duration duration: const Duration(seconds: 3)}) {
  chrome.browserAction
      .setBadgeText(new chrome.BrowserActionSetBadgeTextParams()..text = text);
  return new Future.delayed(duration, clearBadge);
}

/// Set the text of the icon back to blank.
void clearBadge() {
  chrome.browserAction
      .setBadgeText(new chrome.BrowserActionSetBadgeTextParams()..text = '');
}
