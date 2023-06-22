#!/usr/bin/env bash

ament_clang_format --reformat

for d in */ ; do
    black --line-length=88 "$d"
done
