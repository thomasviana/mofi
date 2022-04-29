#!/bin/sh

echo "\n\nPrepare platform builds\n"
./build-scripts/sync.sh

echo "\n\nBuild Android APK\n"
flutter build apk --flavor prod --target lib/main_prod.dart
open build/app/outputs/flutter-apk

echo "\n\nBuild iOS IPA\n"
flutter build ipa --flavor prod --target lib/main_prod.dart
open build/ios/archive/Runner.xcarchive
