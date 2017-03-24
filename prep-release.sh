#!/bin/sh

pub build extension
cd build/extension && zip -r ../../extension.zip *

