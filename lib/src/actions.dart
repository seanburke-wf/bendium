import 'package:bendium/src/action.dart';

final RegExp _repoRegex = new RegExp(r'https://github\.com/Workiva/([^/?]+)');

/// Validate a GitHub PR URL and attempt strip any trailing path segments
/// if they exist.
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

/// Extract the repo name from a GitHub URL after verifying that it is
/// well-formed.
String validateAndExtractRepoName(String url) {
  if (url == null) {
    throw new ArgumentError.notNull('url');
  }
  String prUrl;
  try {
    prUrl = _repoRegex.allMatches(url)?.first?.group(1);
  } catch (_) {}
  if (prUrl == null) {
    throw new ArgumentError.value(
        url, 'url', 'Not a repository url; does not match $_repoRegex');
  }
  return prUrl;
}

final Action createJiraTicket = new ActionImpl(
  getMessage: (String url, String value) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    if (value == null || value == '') {
      return 'ticket $validUrl';
    }

    return 'rogue ticket $validUrl $value';
  },
  isActive: Action.isPullRequestUrl,
  parameterName: 'JIRA Project',
  title: 'Create JIRA Ticket',
);

final Action testConsumers = new ActionImpl(
  getMessage: (String url, String value) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    if (value == 'true') {
      return 'test consumers $validUrl close';
    } else {
      return 'test consumers $validUrl';
    }
  },
  isActive: Action.isPullRequestUrl,
  parameterName: 'Close test PR?',
  parameterType: ParameterType.boolean,
  title: 'Test Consumers',
);

final Action deployPR = new ActionImpl(
  getMessage: (String url, String value) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    if (value == null || value == '') {
      return 'commands Bender deploy';
    }
    return 'deploy $validUrl to $value';
  },
  isActive: Action.isPullRequestUrl,
  parameterName: 'Required Service Name',
  title: 'Deploy to Wk-dev',
);

final Action monitorPr = new ActionImpl(
  getMessage: (String url, String value) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    if (value == null || value == '') {
      return 'monitor pr $validUrl';
    }
    return 'monitor pr $validUrl $value';
  },
  isActive: Action.isPullRequestUrl,
  parameterName: 'Deploy Service Name',
  title: 'Monitor PR',
);

final Action mergeMaster = new ActionImpl(
  getMessage: (String url, _) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'update branch $validUrl merge';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Merge Master',
);

final Action updateGolds = new ActionImpl(
  getMessage: (String url, _) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'update golds $validUrl';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Update Gold Files',
);

final Action dartFormat = new ActionImpl(
  getMessage: (String url, _) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'update branch $validUrl format';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Run Dart Format',
);

final Action pubGet = new ActionImpl(
  getMessage: (String url, _) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'update branch $validUrl get';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Run Pub Get',
);

final Action runBootstrap = new ActionImpl(
  getMessage: (String url, _) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'update branch $validUrl bootstrap';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Run SDK Bootstrap',
);

final Action rerunSmithy = new ActionImpl(
  getMessage: (String url, _) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'rerun smithy for $validUrl';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Re-run Smithy',
);

final Action rerunSkynet = new ActionImpl(
  getMessage: (String url, _) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'rerun skynet for $validUrl';
  },
  isActive: Action.isPullRequestUrl,
  title: 'Re-run Skynet',
);

final Action cutRelease = new ActionImpl(
  getMessage: (String url, _) {
    var repoName = validateAndExtractRepoName(url);
    return 'release $repoName';
  },
  isActive: (String url) => url.startsWith(_repoRegex),
  title: 'Cut Release',
);

final Action updateDartDeps = new ActionImpl(
  getMessage: (String url, _) {
    var repoName = validateAndExtractRepoName(url);
    return 'pub update $repoName';
  },
  isActive: (String url) => url.startsWith(_repoRegex),
  title: 'Update Dart Dependencies',
);

/// List of actions registered with the extension.
///
/// To add new actions, simply add them to this list.
final Iterable<Action> actions = <Action>[
  createJiraTicket,
  testConsumers,
  deployPR,
  monitorPr,
  mergeMaster,
  updateGolds,
  dartFormat,
  pubGet,
  runBootstrap,
  rerunSmithy,
  rerunSkynet,
  cutRelease,
  updateDartDeps
];
