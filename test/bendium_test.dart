// Copyright (c) 2017, George Lesica. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@TestOn('browser')
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
}
