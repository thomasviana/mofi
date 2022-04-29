#!/bin/sh

flutter pub upgrade

cd ios
rm -f ios/Podfile.lock
pod install
cd ..
