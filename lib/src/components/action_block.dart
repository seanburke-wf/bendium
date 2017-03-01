import 'package:over_react/over_react.dart';

typedef void ActionCallback(
    Map<String, String> parameters, Map<String, bool> flags);

@Factory()
UiFactory<ActionBlockProps> ActionBlock;

@Props()
class ActionBlockProps extends UiProps {
  ActionCallback actionCallback;
  Map<String, bool> flags;
  bool isActive;
  Map<String, String> parameters;
}

@Component()
class ActionBlockComponent extends UiComponent<ActionBlockProps> {
  Map getDefaultProps() {
    return newProps()
      ..actionCallback = (_, __) {}
      ..flags = {}
      ..isActive = true
      ..parameters = {};
  }

  @override
  dynamic render() {
    var hasSettings = props.parameters.isNotEmpty || props.flags.isNotEmpty;
    var actionTitle = (Dom.div()..className = 'action-title')(props.title);
    var actionConfigure = hasSettings
        ? (Dom.div()..className = 'action-configure action-button')()
        : null;
    var actionTrigger = props.isActive
        ? (Dom.div()
          ..className = 'action-trigger action-button'
          ..onClick = _handleActionTriggerClick)()
        : null;
    return (Dom.div()
      ..className = 'action ${props.isActive ? 'active' : 'inactive'}')(
        actionTitle, actionConfigure, actionTrigger);
  }

  void _handleActionTriggerClick(_) {
    // TODO: Harvest parameter and flag values.
    props.actionCallback({}, {});
  }
}
