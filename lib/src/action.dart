import 'package:meta/meta.dart';

final RegExp _prRegex = new RegExp(r'https://github.com/.+/.+/pull/[0-9]+');

/// Callback to indicate whether or not the action is active for the
/// given URL.
typedef bool IsActiveCallback(String url);

/// Callback to produce a message to Bender based on a given URL.
typedef String MessageFactory(String url);

class Action {
  /// A default [IsActive] callback that determines whether the
  /// given URL is a GitHub pull request.
  static bool isPullRequestUrl(String url) => url.startsWith(_prRegex);

  /// Callback to produce a Bender message based on a URL.
  final MessageFactory getMessage;

  /// Calback to determine whether or not this action is active.
  final IsActiveCallback isActive;

  /// Help text to be displayed along with the action's interface.
  final String helpText;

  /// Name of the action to be displayed on its button in the interface.
  final String title;

  Action(
      {@required this.getMessage,
      @required this.isActive,
      this.helpText: '',
      @required this.title});
}
