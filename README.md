# Bendium

Bendium is a Chrome extension for talking to Bender.

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

