#!/bin/zsh
set -eu

pushd push
dart run pigeon --input pigeons/push_api.dart
dart run pigeon --input pigeons/push_api.dart --swift_out ../push_macos/macos/Classes/serialization/PushApi.swift
popd
./scripts/format.sh
