import 'package:meta/meta.dart';

final RegExp _prRegex = new RegExp(r'https://github.com/.+/.+/pull/[0-9]+');

/// Callback to indicate whether or not the action is active for the
/// given URL.
typedef bool IsActiveCallback(String url);

/// Callback to produce a message to Bender based on a given URL.
typedef String MessageFactory(String url, String parameterValue);

/// The parameter type affects how an action's parameter input field
/// is rendered in the popup.
enum ParameterType {
  text,
  boolean,
}

abstract class Action {
  /// A default [IsActive] callback that determines whether the
  /// given URL is a GitHub pull request.
  static bool isPullRequestUrl(String url) => url.startsWith(_prRegex);

  String _parameterValue;

  String get commandKey => title.toLowerCase().replaceAll(' ', '');

  /// Callback to produce a Bender message based on a URL.
  MessageFactory get getMessage;

  /// Calback to determine whether or not this action is active.
  IsActiveCallback get isActive;

  /// Help text to be displayed along with the action's interface.
  String get helpText;

  /// Name of the parameter accepted by this action.
  ///
  /// If this is null then no parameter will be accepted.
  String get parameterName;

  /// Parameter type affects how the parameter input field is rendered
  /// in the popup.
  ///
  ///   * Boolean will become a checkbox
  ///   * Text will become a text input
  ///
  /// For boolean parameter types, the value supplied by [parameterValue]
  /// will be "true" or "false".
  ParameterType get parameterType;

  /// The current value of the action parameter.
  String get parameterValue => _parameterValue;

  /// Update the current value of the action parameter.
  void set parameterValue(String value) {
    _parameterValue = value;
  }

  /// Name of the action to be displayed on its button in the interface.
  String get title;
}

class ActionImpl extends Action {
  @override
  final MessageFactory getMessage;

  @override
  final IsActiveCallback isActive;

  @override
  final String helpText;

  @override
  final String parameterName;

  @override
  final ParameterType parameterType;

  @override
  final String title;

  ActionImpl(
      {@required this.getMessage,
      @required this.isActive,
      this.helpText: '',
      this.parameterName,
      this.parameterType: ParameterType.text,
      @required this.title});
}
