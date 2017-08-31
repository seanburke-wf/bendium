import 'package:test/test.dart';

import 'package:bendium/src/actions.dart';

void main() {
  group('actions', () {
    var prUrl = 'https://github.com/repo/pull/1';

    test('createJiraTicket', () {
      expect(createJiraTicket.getMessage(prUrl, 'VALUE'),
          'rogue ticket $prUrl VALUE');
      expect(createJiraTicket.getMessage(prUrl, null), 'ticket $prUrl');
      expect(createJiraTicket.getMessage(prUrl, ''), 'ticket $prUrl');
    });
  });
}
