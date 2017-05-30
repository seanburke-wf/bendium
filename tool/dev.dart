import 'dart:async';

import 'package:dart_dev/dart_dev.dart' show dev, config;

Future main(List<String> args) async {
  // https://github.com/Workiva/dart_dev

  config.analyze.entryPoints = [
    'extension/',
    'lib/',
    'lib/src',
    'test/',
    'tool/',
  ];

  config.format.directories = [
    'extension/',
    'lib/',
    'test/',
    'tool/',
  ];

  config.test.platforms = ['vm', 'content-shell'];

  config.test.unitTests = ['test/'];

  await dev(args);
}
