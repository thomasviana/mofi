#!/bin/sh

echo "\n\nPrepare platform builds\n"
./build-scripts/sync.sh

echo "\n\nBuild Android APK\n"
flutter build apk --flavor uat --target lib/main_uat.dart --no-tree-shake-icons
open build/app/outputs/flutter-apk

echo "\n\nBuild iOS IPA\n"
flutter build ipa --flavor uat --target lib/main_uat.dart --no-tree-shake-icons
open build/ios/archive/Runner.xcarchive
