# Variables

PRODUCT_NAME := DevToys
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace
SCHEME_NAME := ${PRODUCT_NAME}
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

OPEN_API_SPEC_PATH := API/reference/whitemap-API.v1.yaml

TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 12 Pro Max
TEST_OS ?= 15.2
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'
COVERAGE_OUTPUT := html_report

XCODEBUILD_BUILD_LOG_NAME := xcodebuild_build.log
XCODEBUILD_TEST_LOG_NAME := xcodebuild_test.log

MODULE_TEMPLATE_NAME ?= 0x0c_viper

.DEFAULT_GOAL := help

# Targets

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	brew bundle --no-upgrade --no-lock
	git submodule init
	git submodule update
	$(MAKE) install-ruby
	$(MAKE) install-bundler
	$(MAKE) install-templates
	$(MAKE) install-mint
	$(MAKE) generate-xcodeproj

.PHONY: install-ruby
install-ruby: # Install Ruby
	rbenv install -s
	gem install bundler

.PHONY: install-bundler
install-bundler: # Install Bundler dependencies
	bundle config path vendor/bundle
	bundle install --jobs 4 --retry 3

.PHONY: update-bundler
update-bundler: # Update Bundler dependencies
	bundle config path vendor/bundle
	bundle update --jobs 4 --retry 3

.PHONY: update-pods
update-pods: # Update Podfile.lock
	bundle exec pod update
	$(MAKE) generate-xcodeproj

.PHONY: update-dependencies
update-dependencies: # Update all dependencies
	$(MAKE) update-bundler
	$(MAKE) update-pods
	bundle exec fastlane update_plugins

.PHONY: install-mint
install-mint: # Install Mint dependencies
	mint bootstrap --overwrite y

.PHONY: install-templates
install-templates: # Install Generamba templates
	bundle exec generamba template install

# .PHONY: generate-licenses
# generate-licenses: # Generate licenses with LicensePlist and regenerate project
# 	mint run LicensePlist license-plist --output-path ${PRODUCT_NAME}/Settings.bundle --add-version-numbers
# 	$(MAKE) generate-xcodeproj

.PHONY: generate-module
generate-module: # Generate module with Generamba and regenerate project # MODULE_NAME=[module name]
	bundle exec generamba gen ${MODULE_NAME} ${MODULE_TEMPLATE_NAME}
	$(MAKE) format
	$(MAKE) generate-xcodeproj

.PHONY: generate-compositional-module
generate-compositional-module: # Generate module with Generamba and regenerate project
	bundle exec generamba gen ${MODULE_NAME} 0x0c_viper_compositional_layout
	$(MAKE) format
	$(MAKE) generate-xcodeproj

.PHONY: generate-xcodeproj
generate-xcodeproj: # Generate project with XcodeGen
	mint run xcodegen
	bundle exec pod install

.PHONY: beta
beta: # Upload to Firebase App Distribution
	bundle exec fastlane beta

.PHONY: deploy
deploy: # Upload to App Store
	bundle exec fastlane deploy

.PHONY: open
open: # Open project in Xcode
	open ./${WORKSPACE_NAME}

.PHONY: format
format: # Format code
	./Pods/SwiftFormat/CommandLineTool/swiftformat .

.PHONY: clean
clean: # Delete cache
	-xcrun --kill-cache
	-xcodebuild clean -alltargets
	rm -rf ./vendor/bundle
	rm -rf ./Templates
	rm -rf ./API
	rm -rf ./Pods
	rm -rf ./${PROJECT_NAME}
	rm -rf ./${WORKSPACE_NAME}
	rm -rf ./swagger_generated

# .PHONY: analyze
# analyze: # Analyze with SwiftLint
# 	$(MAKE) build-debug
# 	mint run swiftlint swiftlint analyze --autocorrect --compiler-log-path ./${XCODEBUILD_BUILD_LOG_NAME}

# .PHONY: build-debug
# build-debug: # Xcode build for debug
# 	set -o pipefail \
# && xcodebuild \
# -sdk ${TEST_SDK} \
# -configuration ${TEST_CONFIGURATION} \
# -project ${PROJECT_NAME} \
# -scheme ${SCHEME_NAME} \
# -destination ${TEST_DESTINATION} \
# build \
# | tee ./${XCODEBUILD_BUILD_LOG_NAME} \
# | bundle exec xcpretty --color

# .PHONY: test
# test: # Xcode test # TEST_DEVICE=[device] TEST_OS=[OS]
# 	set -o pipefail \
# && xcodebuild \
# -sdk ${TEST_SDK} \
# -configuration ${TEST_CONFIGURATION} \
# -project ${PROJECT_NAME} \
# -scheme ${SCHEME_NAME} \
# -destination ${TEST_DESTINATION} \
# -skip-testing:${UI_TESTS_TARGET_NAME} \
# clean test \
# | tee ./${XCODEBUILD_TEST_LOG_NAME} \
# | bundle exec xcpretty --color --report html

# .PHONY: get-coverage
# get-coverage: # Get code coverage
# 	bundle exec slather coverage --html --output-directory ${COVERAGE_OUTPUT}

# .PHONY: show-devices
# show-devices: # Show devices
# 	xcrun xctrace list devices