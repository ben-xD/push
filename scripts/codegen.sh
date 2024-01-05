#!/bin/zsh
set -eu

pushd push_platform_interface
# We run codegen for all platforms (except for iOS and macOS) twice, but it's idempotent so it's okay. Ideally, Pigeon supports multiple paths for the same language (a swiftOut [array])
dart run pigeon --input pigeons/push_api.dart
dart run pigeon --input pigeons/push_api.dart --swift_out ../push_macos/macos/Classes/serialization/PushApi.swift
popd
./scripts/format.sh