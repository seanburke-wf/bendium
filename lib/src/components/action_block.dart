import 'package:bendium/src/action.dart';
import 'package:bendium/src/bender_adapter.dart';
import 'package:over_react/over_react.dart';

typedef void ActionCallback(
    Map<String, String> parameters, Map<String, bool> flags);

@Factory()
UiFactory<ActionBlockProps> ActionBlock;

@Props()
class ActionBlockProps extends UiProps {
  @requiredProp
  Action action;

  @requiredProp
  BenderAdapter bender;

  @requiredProp
  String url;
}

@Component()
class ActionBlockComponent extends UiComponent<ActionBlockProps> {
  @override
  dynamic render() {
    var isActive = props.action.isActive(props.url);
    var actionTitle =
        (Dom.div()..className = 'action-title')(props.action.title);
    var actionTrigger = isActive
        ? (Dom.div()
          ..className = 'action-trigger action-button'
          ..onClick = _handleActionTriggerClick)()
        : null;
    return (Dom.div()
      ..className = 'action ${isActive ? 'active' : 'inactive'}')(
        actionTitle, actionTrigger);
  }

  void _handleActionTriggerClick(_) {
    props.bender.sendMessage(props.action.getMessage(props.url));
  }
}
