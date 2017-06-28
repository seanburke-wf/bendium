#!/bin/sh

pub get
pub build extension
cd build/extension && zip -r ../../extension.zip *

