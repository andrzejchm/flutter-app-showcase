import 'package:mason/mason.dart';
import 'package:recase/recase.dart';
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  try {
    final useCaseName = context.vars["use_case_name"] as String;
    final failureName = context.vars["failure_name"] as String;
    final importPath = context.vars["import_path"] as String;
    final useCaseFileName = context.vars["use_case_file_name"] as String;
    final failureFileName = context.vars["failure_file_name"] as String;
    final appPackage = context.vars["app_package"] as String;
    final feature = context.vars["feature"] as String;

    context.logger.info("Modifying mock definitions...");
    await _replaceInMockDefinitions(
      context: context,
      appPackage: appPackage,
      importPath: importPath,
      useCaseName: useCaseName,
      failureName: failureName,
      useCaseFileName: useCaseFileName,
      failureFileName: failureFileName,
      feature: feature,
    );

    context.logger.info("Modifying mocks...");
    await _replaceInMocks(
      context: context,
      useCaseName: useCaseName,
      failureName: failureName,
      feature: feature,
    );

    context.logger.info("Modifying feature component...");
    await _replaceInAppComponent(
      context: context,
      useCaseName: useCaseName,
      importPath: importPath,
      useCaseFileName: useCaseFileName,
      failureFileName: failureFileName,
      appPackage: appPackage,
      feature: feature,
    );
  } catch (ex, stack) {
    context.logger.err("$ex\n$stack");
  }
}

Future<void> _replaceInAppComponent({
  required HookContext context,
  required String useCaseName,
  required String importPath,
  required String useCaseFileName,
  required String failureFileName,
  required String appPackage,
  required String feature,
}) async {
  await ensureFeatureComponentFile(appPackage: appPackage, feature: feature);
  await replaceAllInFile(
    filePath: featureComponentFilePath(feature),
    from: "//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG",
    to: """
      ..registerFactory<$useCaseName>(
          () => const $useCaseName(),
        )
        //DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      """,
  );
  await replaceAllInFile(
    filePath: featureComponentFilePath(feature),
    from: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
    to: """
import 'package:$appPackage/$importPath/domain/use_cases/$useCaseFileName';
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS
      """,
  );
}

Future<void> _replaceInMockDefinitions({
  required HookContext context,
  required String appPackage,
  required String importPath,
  required String useCaseName,
  required String useCaseFileName,
  required String failureName,
  required String failureFileName,
  required String feature,
}) async {
  final mockDefinition = (String name) => "class Mock$name extends Mock implements $name {}";
  await ensureMockDefinitionsFile(feature, context: context);
  await replaceAllInFile(
    filePath: mockDefinitionsFilePath(feature),
    from: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
    to: """
import 'package:$appPackage/$importPath/domain/use_cases/$useCaseFileName';
import 'package:$appPackage/$importPath/domain/model/$failureFileName';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS
      """,
  );

  await replaceAllInFile(
    filePath: mockDefinitionsFilePath(feature),
    from: "//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION",
    to: """
${mockDefinition(failureName)}
${mockDefinition(useCaseName)}
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION
      """,
  );
}

Future<void> _replaceInMocks({
  required HookContext context,
  required String useCaseName,
  required String failureName,
  required String feature,
}) async {
  final mockStaticField = (String name) => "static late Mock$name ${name.camelCase};";
  final mockInit = (String name) => "${name.camelCase} = Mock$name();";
  final registerFallbackValue = (String name) => "registerFallbackValue(Mock$name());";

  await ensureMocksFile(feature);

  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD",
    to: """
        ${mockStaticField(failureName)}
        ${mockStaticField(useCaseName)}
        //DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD
      """,
  );
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE USE_CASE_INIT_MOCKS",
    to: """
        ${mockInit(failureName)}
        ${mockInit(useCaseName)}
        //DO-NOT-REMOVE USE_CASE_INIT_MOCKS
      """,
  );
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE",
    to: """
        ${registerFallbackValue(failureName)}
        ${registerFallbackValue(useCaseName)}
        //DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE
      """,
  );
}
