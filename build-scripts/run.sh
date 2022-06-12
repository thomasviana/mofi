#!/bin/sh

flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

cd ios
rm -f ios/Podfile.lock
pod install --repo-update
cd ..
