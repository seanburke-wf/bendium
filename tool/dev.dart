import 'dart:async';

import 'package:dart_dev/dart_dev.dart';

Future main(List<String> args) async {
  // https://github.com/Workiva/dart_dev

  config.analyze.entryPoints = [
    'extension/',
    'lib/',
    'lib/src',
    'test/',
    'tool/',
  ];

  config.format.paths = [
    'extension/',
    'lib/',
    'test/',
    'tool/',
  ];

  config.genTestRunner.configs = <TestRunnerConfig>[
    new TestRunnerConfig(
        directory: 'test/unit/vm',
        env: Environment.vm,
        filename: 'generated_runner_test'),
    new TestRunnerConfig(
        genHtml: true,
        directory: 'test/unit/browser',
        env: Environment.browser,
        filename: 'generated_runner_test',
        dartHeaders: const <String>[
          "import 'package:react/react_client.dart';",
          "import 'package:over_react/over_react.dart';"
        ],
        preTestCommands: const <String>[
          'setClientConfiguration();',
          'enableTestMode();',
        ],
        htmlHeaders: const <String>[
          '<script src="packages/react/react_with_addons.js"></script>',
          '<script src="packages/react/react_dom.js"></script>',
        ])
  ];

  config.test
    ..pubServe = true
    ..platforms = ['content-shell', 'vm']
    ..unitTests = [
      'test/unit/browser/generated_runner_test.dart',
      'test/unit/vm/generated_runner_test.dart',
    ];

  await dev(args);
}
