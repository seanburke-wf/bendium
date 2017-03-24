import 'dart:async';
import 'package:chrome/chrome_ext.dart' as chrome;

/// Just for debugging this confusing API
Future dumpTabsQueryResults(chrome.TabsQueryParams queryInfo, [String msg]) async {
  print('Results of ${msg ?? queryInfo.toString()}:');
  List<chrome.Tab> tabs = await chrome.tabs.query(queryInfo);
  print(tabs.map((t) => '${t.title} ${t.url}').toList().join('\n'));
}

Future<String> currentUrl() async {
  print('currentUrl');
  chrome.Tab tab = await chrome.tabs.getSelected();
  return tab.url;
}