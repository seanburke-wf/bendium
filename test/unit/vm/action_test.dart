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

    group('isPullRequestUrl', () {
      void testIsPullRequestUrl(String url, bool expected) {
        var matcher = expected ? isTrue : isFalse;
        expect(Action.isPullRequestUrl(url), matcher);
      }

      test('should return true for a PR URL', () {
        testIsPullRequestUrl('https://github.com/Foo/bar/pull/1', true);
        testIsPullRequestUrl('https://github.com/foo/bar/pull/1', true);
        testIsPullRequestUrl('https://github.com/Foo/bar/pull/10', true);
      });

      test('should return false for a non-PR URL', () {
        testIsPullRequestUrl('https://github.com/Foo/bar', false);
        testIsPullRequestUrl('https://github.com/Foo', false);
        testIsPullRequestUrl('https://fakehub.com/Foo/bar/pull/1', false);
      });
    });

    group('isShipyardUrl', () {
      void testIsShipyardUrl(String url, bool expected) {
        var matcher = expected ? isTrue : isFalse;
        expect(Action.isShipyardUrl(url), matcher);
      }

      test('should return true for a Shipyard URL', () {
        testIsShipyardUrl('https://shipyard.workiva.org/foo/1', true);
        testIsShipyardUrl('https://shipyard.workiva.org/foo/10', true);
      });

      test('should return false for a non-Shipyard URL', () {
        testIsShipyardUrl('https://fakeyard.workiva.org/foo/1', false);
      });
    });
  });
}
