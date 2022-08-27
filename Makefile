package := flutter_app
file := test/coverage_helper_test.dart

check:
	@echo "\033[32m Run fluttergen... \033[0m"
	@fluttergen -c pubspec.yaml
	@echo "\033[32m Formatting code... \033[0m"
	@fvm flutter format --line-length 120 lib test
	@echo "\033[32m Validate localization files... \033[0m"
	@fvm dart tools/arb_files_validator/bin/arb_files_validator.dart lib/localization/
	@echo "\033[32m Flutter analyze... \033[0m"
	@fvm flutter analyze
	@echo "\033[32m Flutter clean architecture lints... \033[0m"
	@fvm flutter pub get ; pushd tools/custom_lints/clean_architecture_lints ; fvm flutter pub get ; popd
	@fvm flutter pub run custom_lint
	@echo "\033[32m Removing all golden files... \033[0m"
	@find ./test -name '*.png' | xargs rm -r
	@echo "\033[32m Flutter test --update-goldens... \033[0m"
	@fvm flutter test --update-goldens
	@echo "\033[32m Code metrics analyze: \033[0m"
	@fvm flutter pub run dart_code_metrics:metrics analyze lib --set-exit-on-violation-level=warning --fatal-style --fatal-performance --fatal-warnings
	@echo "\033[32m Code metrics check-unused-code: \033[0m"
	@fvm flutter pub run dart_code_metrics:metrics check-unused-code . --fatal-unused
	@echo "\033[32m Code metrics check-unused-files: \033[0m"
	@fvm flutter pub run dart_code_metrics:metrics check-unused-files . --fatal-unused --exclude="{templates/**,.dart_tool/**,lib/generated/**}"
	@echo "\033[1;32m \n\nGOOD JOB, THE CODE IS SPOTLESS CLEAN AND READY FOR PULL REQUEST! \n \033[42m Make sure to commit any code changes \033[0m  \n\n"