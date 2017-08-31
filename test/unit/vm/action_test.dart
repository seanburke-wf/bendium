import 'package:test/test.dart';

import 'package:bendium/src/action.dart';

void main() {
  group('Action', () {
    var action = new ActionImpl(
      isActive: (url) => url == 'true',
      getMessage: (url, value) {},
      title: 'Test Action',
      parameterName: 'parameter',
    );

    test('commandKey should munge title', () {
      expect(action.commandKey, 'testaction');
    });

    test('parameterValue should set', () {
      expect(action.parameterValue, isNull);
      action.parameterValue = 'value';
      expect(action.parameterValue, 'value');
    });
  });
}
