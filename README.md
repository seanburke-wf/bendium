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

## Credits

Icon courtesy of [Herbert Spencer](https://thenounproject.com/hspencer/)
and licensed CC-BY.

