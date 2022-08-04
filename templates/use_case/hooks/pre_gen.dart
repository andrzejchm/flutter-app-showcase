import "package:mason/mason.dart";
import "package:recase/recase.dart";

Future<void> run(HookContext context) async {
  var useCaseName = (context.vars["use_case_name"] as String? ?? "").trim().pascalCase;
  final featureName = (context.vars["feature_name"] as String? ?? "").trim().snakeCase;

  if (useCaseName.isEmpty) {
    throw "Cannot use empty name for usecase";
  }

  final stem = useCaseName.replaceAll("UseCase", "");
  useCaseName = "${stem}UseCase";

  final failureName = "${stem}Failure";
  final useCaseFileName = "${stem.snakeCase}_use_case.dart";
  final failureFileName = "${stem.snakeCase}_failure.dart";
  final featurePath = featureName.isEmpty ? "core" : "features/${featureName}";

  context.vars = {
    ...context.vars,
    "app_package": "flutter_demo",
    "import_path": "${featurePath}",
    "stem": "${stem}",
    "failure_name": failureName,
    "use_case_name": useCaseName,
    "use_case_file_name": useCaseFileName,
    "failure_file_name": failureFileName,
    "use_case_absolute_path": "../lib/${featurePath}/domain/use_cases/$useCaseFileName",
    "failure_absolute_path": "../lib/${featurePath}/domain/model/$failureFileName",
    "use_case_test_absolute_path": "../test/${featurePath}/domain/${stem.snakeCase}_use_case_test.dart",
    'feature': featureName,
  };
  context.logger.info("Generating useCase, variables: ${context.vars}");
}
