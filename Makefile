run-app:
	flutter run --no-sound-null-safety


run-web:
	flutter run -d web-server --no-sound-null-safety

gen-icon:
	flutter pub global activate flutter_launcher_icons 0.9.2
	flutter pub global run flutter_launcher_icons:main