#!/bin/sh

flutter packages pub upgrade
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter clean
flutter analyze

cd ios
pod update
cd ..
