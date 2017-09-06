# Bendium

Bendium is a Chrome extension for talking to Bender.

## Install

Bendium is available in the Workiva section of the Chrome Web Store.

You'll need to get a HipChat API token. Log into the HipChat web interface (you
can just click "Profile" within the desktop client). Then select "API Access"
on the left and create a new token. It only requires the "Send Message" scope.

You can set keyboard shortcuts for Bendium commands using the standard chrome://extensions page mechanism:
![creating keyboard shortcuts](/documentation/bendium_keyboard_shorcuts.png)

## Build

```
pub get
pub build extension
# or, if you want sourcemaps to know where your code fails,
pub build extension --mode=debug
```

Install the `build/extension/` directory.

## Test

```
alias ddev='pub run dart_dev'
ddev gen-test-runner
ddev test -p content-shell
```

## Add an action

It is fairly simple to add a new Bender action. Take a look at
`lib/src/actions.dart` for some examples. Here's a prototypical one:

```dart
final Action createJiraTicket = new ActionImpl(
  // A function that takes the current URL and the action's parameter
  // value, which will be sent to Bender after the command name.
  getMessage: (String url, String value) {
    var validUrl = validateAndCoerceToPullRequestUrl(url);
    return 'rogue ticket $validUrl $value';
  },
  
  // A function to determine whether this action should be allowed
  // for a given page. It accepts the URL.
  isActive: Action.isPullRequestUrl,
  
  // The name of the parameter that will be passed to bender after
  // the command name. Leave it `null` if you don't want to use a
  // parameter.
  parameterName: 'Project',
  
  // The action's title that will be shown to users.
  title: 'Create JIRA Ticket',
);
```

Aside from the above, you just have to make sure to add your action
to the `actions` list in the same file.

## Credits

Icon courtesy of [Herbert Spencer](https://thenounproject.com/hspencer/)
and licensed CC-BY.

