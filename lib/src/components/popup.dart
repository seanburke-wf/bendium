import 'dart:html';

import 'package:bendium/src/action.dart';
import 'package:over_react/over_react.dart';

import 'package:bendium/src/bender_adapter.dart';
import 'package:bendium/src/components/action_block.dart';

typedef void UpdateTokenCallback(String token);

@Factory()
UiFactory<PopupProps> Popup;

@Props()
class PopupProps extends UiProps {
  @requiredProp
  Iterable<Action> actions;

  @requiredProp
  String currentUrl;

  @requiredProp
  BenderAdapter bender;

  @requiredProp
  UpdateTokenCallback updateTokenCallback;
}

@Component()
class PopupComponent extends UiComponent<PopupProps> {
  InputElement tokenInput;

  @override
  dynamic render() {
    var actionBlocks = [];
    for (var action in props.actions) {
      actionBlocks.add((ActionBlock()
        ..action = action
        ..bender = props.bender
        ..url = props.currentUrl)());
    }

    actionBlocks.add((Dom.div()..className = 'config')(
        (Dom.input()
          ..type = 'text'
          ..ref = ((input) => tokenInput = input)
          ..defaultValue = 'Update Hipchat token...')(),
        (Dom.button()
          ..className = 'action-button'
          ..onClick = _saveHipchatToken)('Save')));

    return (Dom.div()..className = 'actions-list')(actionBlocks);
  }

  void _saveHipchatToken(_) {
    props.updateTokenCallback(tokenInput.value);
  }
}
