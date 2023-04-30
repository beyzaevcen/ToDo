iosfix:
	flutter clean
	rm -rf pubspec.lock ios/Pods ios/Podfile.lock
	flutter pub get
	arch -x86_64 pod install --repo-update --project-directory=ios