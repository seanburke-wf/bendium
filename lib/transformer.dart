import 'dart:async';
import 'dart:convert';

import 'package:barback/barback.dart';

import 'src/actions.dart' show actions;

// TODO: This could update the manifest version from the pubspec as well.

class ManifestCommands extends Transformer {
  ManifestCommands.asPlugin();

  Future apply(Transform transform) async {
    var stringContent = await transform.primaryInput.readAsString();
    var jsonContent = JSON.decode(stringContent);

    if (jsonContent is Map) {
      Map commands;
      if (jsonContent['commands'] is Map) {
        commands = jsonContent['commands'];
      } else {
        commands = {};
      }

      for (var action in actions) {
        commands[action.commandKey] = {
          'description': action.title,
        };
      }

      jsonContent['commands'] = commands;
    }

    var id = transform.primaryInput.id;

    var newContent = JSON.encode(jsonContent);
    transform.addOutput(new Asset.fromString(id, newContent));
  }

  @override
  Future<bool> isPrimary(AssetId id) async => id.path.endsWith('manifest.json');
}
