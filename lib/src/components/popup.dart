import 'dart:async';
import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:bendium/src/bender_adapter.dart';
import 'package:bendium/src/components/action_block.dart';

final RegExp _prRegex = new RegExp(r'https://github.com/.+/.+/pull/[0-9]+');

typedef void UpdateTokenCallback(String token);

@Factory()
UiFactory<PopupProps> Popup;

@Props()
class PopupProps extends UiProps {
  String currentUrl;
  BenderAdapter bender;
  UpdateTokenCallback updateTokenCallback;
}

@Component()
class PopupComponent extends UiComponent<PopupProps> {
  InputElement tokenInput;

  bool get _isPullRequest => props.currentUrl.startsWith(_prRegex);

  @override
  dynamic render() {
    return (Dom.div()..className = 'actions-list')(
        (ActionBlock()
          ..actionCallback = _monitor
          ..isActive = _isPullRequest
          ..title = 'Monitor PR')(),
        (ActionBlock()
          ..actionCallback = _createTicket
          ..isActive = _isPullRequest
          ..title = 'Create Jira Ticket')(),
        (ActionBlock()
          ..actionCallback = _testConsumers
          ..isActive = _isPullRequest
          ..title = 'Test Consumers')(),
        (Dom.div()..className = 'config')(
            (Dom.input()
              ..type = 'text'
              ..ref = ((input) => tokenInput = input)
              ..defaultValue = 'Update Hipchat token...')(),
            (Dom.button()
              ..className = 'action-button'
              ..onClick = _saveHipchatToken)('Save')));
  }

  void _saveHipchatToken(_) {
    props.updateTokenCallback(tokenInput.value);
  }

  Future _createTicket(_, __) async {
    await props.bender.createTicket(props.currentUrl);
  }

  Future _monitor(_, __) async {
    await props.bender.monitorPullRequest(props.currentUrl);
  }

  Future _testConsumers(_, __) async {
    await props.bender.testConsumersRequest(props.currentUrl);
  }
}
