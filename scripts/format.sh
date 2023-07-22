#!/bin/bash

set -euxo pipefail

# https://dart.dev/tools/dart-format
dart format .
# https://github.com/nicklockwood/SwiftFormat, not https://github.com/apple/swift-format
swiftformat --exclude push/example/macos/Flutter/GeneratedPluginRegistrant.swift .
# TODO Use ktlint?