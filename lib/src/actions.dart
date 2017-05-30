import 'package:bendium/src/action.dart';

String validateAndCoerceToPullRequestUrl(String url) {
  print('validateAndCoerceToPullRequestUrl $url');
  if (url == null) {
    throw new ArgumentError.notNull('url');
  }
  final re = new RegExp(r'(https://github\.com/.*/pull/\d+).*');
  String prUrl;
  try {
    prUrl = re.allMatches(url)?.first?.group(1);
  } catch (exc, trace) {
    print('$exc $trace');
  }
  if (prUrl == null) {
    throw new ArgumentError.value(
        url, 'url', 'Not a PR url; does not match $re');
  }
  return prUrl;
}

final Action createJiraTicket = new Action(
  getMessage: (String url) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'ticket $validUrl';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Create JIRA Ticket',
);

final Action monitorPr = new Action(
  getMessage: (String url) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'monitor pr $validUrl';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Monitor PR',
);

final Action testConsumers = new Action(
  getMessage: (String url) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'test consumers $validUrl';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Test Consumers',
);

final Action mergeMaster = new Action(
  getMessage: (String url) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'update branch $validUrl merge';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Merge Master',
);

final Action updateGolds = new Action(
  getMessage: (String url) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'update golds $validUrl';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Update Gold Files',
);

/// List of actions registered with the extension.
///
/// To add new actions, simply add them to this list.
final Iterable<Action> actions = <Action>[
  createJiraTicket,
  monitorPr,
  testConsumers,
  mergeMaster,
  updateGolds,
];
