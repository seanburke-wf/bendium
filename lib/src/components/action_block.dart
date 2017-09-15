import 'dart:html';

import 'package:bendium/src/action.dart';
import 'package:bendium/src/bender_adapter.dart';
import 'package:over_react/over_react.dart';

typedef void ActionCallback(
    Map<String, String> parameters, Map<String, bool> flags);

typedef void UpdateParameterValueCallback(String value);

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

  @requiredProp
  UpdateParameterValueCallback updateParameterValueCallback;
}

@State()
class ActionBlockState extends UiState {
  String parameterValue;
}

@Component()
class ActionBlockComponent
    extends UiStatefulComponent<ActionBlockProps, ActionBlockState> {
  @override
  Map getInitialState() {
    return newState()..parameterValue = props.action.parameterValue;
  }

  @override
  dynamic render() {
    var isActive = props.action.isActive(props.url);
    var actionTitle =
        (Dom.div()..className = 'action-title')(props.action.title);

    ReactElement parameter;
    if (props.action.parameterName != null) {
      ReactElement parameterInput;
      switch (props.action.parameterType) {
        case ParameterType.boolean:
          parameterInput = Dom.label()(
              props.action.parameterName,
              (Dom.input()
                ..type = 'checkbox'
                ..onChange = _onParameterChange
                ..checked = state.parameterValue == 'true'
                ..value = state.parameterValue)());
          break;
        case ParameterType.text:
          parameterInput = (Dom.input()
            ..placeholder = props.action.parameterName
            ..onChange = _onParameterChange
            ..value = state.parameterValue)();
          break;
      }
      parameter = (Dom.div()..className = 'action-parameter')(parameterInput);
    }

    var actionTrigger = isActive
        ? (Dom.div()
          ..value = props.action.parameterValue
          ..className = 'action-trigger action-button'
          ..onClick = _handleActionTriggerClick)()
        : null;

    return (Dom.div()
          ..className = 'action ${isActive ? 'active' : 'inactive'}')(
        actionTitle, parameter, actionTrigger);
  }

  void _handleActionTriggerClick(_) {
    props.bender
        .sendMessage(props.action.getMessage(props.url, state.parameterValue));
  }

  void _onParameterChange(SyntheticFormEvent event) {
    InputElement target = event.target;

    String value;
    if (target is CheckboxInputElement) {
      value = target.checked ? 'true' : 'false';
    } else {
      value = target.value;
    }

    if (value == '') {
      value = null;
    }

    setState(newState()..parameterValue = value);
    props.updateParameterValueCallback(value);
  }
}
