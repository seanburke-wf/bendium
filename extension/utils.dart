import 'dart:async';
import 'package:chrome/chrome_ext.dart' as chrome;

Future dumpTabsQueryResults(chrome.TabsQueryParams queryInfo, [String msg]) async {
  print('Results of ${msg ?? queryInfo.toString()}:');
  List<chrome.Tab> tabs = await chrome.tabs.query(queryInfo);
  print(tabs.map((t) => '${t.title} ${t.url}').toList().join('\n'));
}

Future<String> currentUrl() async {
  print('currentUrl');
  // Not sure why, but `chrome.tabs.getSelected()` gives
  // "chrome://extensions/" when called from the keyboard shortcut
  chrome.Tab tab = await chrome.tabs.getSelected();

//  chrome.Tab tab = (await chrome.tabs.query(new chrome.TabsQueryParams()
//    ..currentWindow = true
//    ..active = true
//  )).first;
  return tab.url;
}