@TestOn('browser')
library test.unit.browser.generated_runner_test;

// Generated by `pub run dart_dev gen-test-runner -d test/unit/browser -e Environment.browser --genHtml`

import './bendium_test.dart' as bendium_test;
import 'package:test/test.dart';
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

void main() {
  setClientConfiguration();
  enableTestMode();
  bendium_test.main();
}