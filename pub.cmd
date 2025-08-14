@echo off
cd /d %~dp0

REM run flutter commands
call fvm flutter clean
call fvm flutter pub get
call fvm dart run build_runner build --delete-conflicting-outputs
@REM call fvm dart run easy_localization:generate -f keys -O lib/gen -o locale_keys.g.dart --source-dir ./assets/langs
