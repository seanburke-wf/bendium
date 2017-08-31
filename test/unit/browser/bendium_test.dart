// Copyright (c) 2017, George Lesica. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@TestOn('content-shell')
import 'package:bendium/bendium.dart';
import 'package:test/test.dart';

void main() {
  group('validateAndCoerceToPullRequestUrl', () {
    test('extracts just the PR url', () {
      String expected = 'https://github.com/Workiva/w_viewer/pull/197';
      String extraneousPrUrl = '$expected/files?monkey#issuecomment-283103917';
      String actual = validateAndCoerceToPullRequestUrl(extraneousPrUrl);
      expect(actual, equals(expected));
    });
  });

  group('validateAndExtractRepoName', () {
    test('extracts just the repo name', () {
      String url = 'https://github.com/Workiva/w_common';
      expect(validateAndExtractRepoName(url), 'w_common');
    });

    test('ignores subsequent path segments', () {
      String url = 'https://github.com/Workiva/w_common/pull/197';
      expect(validateAndExtractRepoName(url), 'w_common');
    });

    test('ignores query parameters', () {
      String url = 'https://github.com/Workiva/w_common?blah=true';
      expect(validateAndExtractRepoName(url), 'w_common');
    });

    test('does not match non-Workiva forks', () {
      String url = 'https://github.com/georgelesica-wf/w_common';
      expect(() => validateAndExtractRepoName(url), throwsArgumentError);
    });
  });
}
