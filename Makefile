.PHONY: format

format:
	./scripts/format.sh

lint:
	dart format --set-exit-if-changed .
	swiftformat --lint --exclude push/example/macos/Flutter/GeneratedPluginRegistrant.swift .