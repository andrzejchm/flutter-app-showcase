import 'package:mason/mason.dart';
import 'package:recase/recase.dart';
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  final appPackage = context.vars["app_package"] as String;
  final feature = context.vars["feature"] as String;
  final interfaceName = context.vars["interface_name"] as String;
  final implementationName = context.vars["implementation_name"] as String;
  final interfaceFileName = context.vars["interface_file_name"] as String;
  final implementationFileName = context.vars["implementation_file_name"] as String;
  final implementationImport = context.vars["implementation_import"] as String;
  final interfaceImport = context.vars["interface_import"] as String;

  await _replaceInMockDefinitions(
    context: context,
    interfaceName: interfaceName,
    interfaceFileName: interfaceFileName,
    interfaceImport: interfaceImport,
    feature: feature,
  );

  await _replaceInMocks(
    context: context,
    interfaceName: interfaceName,
    feature: feature,
  );

  await _replaceInAppComponent(
    appPackage: appPackage,
    context: context,
    interfaceName: interfaceName,
    implementationName: implementationName,
    interfaceFileName: interfaceFileName,
    implementationFileName: implementationFileName,
    implementationImport: implementationImport,
    interfaceImport: interfaceImport,
    feature: feature,
  );
}

Future<void> _replaceInAppComponent({
  required HookContext context,
  required String appPackage,
  required String interfaceName,
  required String implementationName,
  required String interfaceFileName,
  required String implementationFileName,
  required String implementationImport,
  required String interfaceImport,
  required String feature,
}) async {
  await ensureFeatureComponentFile(appPackage: appPackage, feature: feature);
  await replaceAllInFile(
    filePath: featureComponentFilePath(feature),
    from: "//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG",
    to: """
      ..registerFactory<$interfaceName>(
          () => const $implementationName(),
        )
        //DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      """,
  );
  await replaceAllInFile(
    filePath: featureComponentFilePath(feature),
    from: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
    to: """
    $implementationImport
    $interfaceImport
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS
      """,
  );
}

Future<void> _replaceInMockDefinitions({
  required HookContext context,
  required String interfaceName,
  required String interfaceFileName,
  required String interfaceImport,
  required String feature,
}) async {
  final mockDefinition = (String name) => "class Mock$name extends Mock implements $name {}";
  await ensureMockDefinitionsFile(feature);
  await replaceAllInFile(
    filePath: mockDefinitionsFilePath(feature),
    from: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
    to: """
    $interfaceImport
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS
      """,
  );

  await replaceAllInFile(
    filePath: mockDefinitionsFilePath(feature),
    from: "//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION",
    to: """
${mockDefinition(interfaceName)}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION
      """,
  );
}

Future<void> _replaceInMocks({
  required HookContext context,
  required String interfaceName,
  required String feature,
}) async {
  final mockStaticField = (String name) => "static late Mock$name ${name.camelCase};";
  final mockInit = (String name) => "${name.camelCase} = Mock$name();";
  final registerFallbackValue = (String name) => "registerFallbackValue(Mock$name());";

  await ensureMocksFile(feature);
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD",
    to: """
        ${mockStaticField(interfaceName)}
        //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD
      """,
  );
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS",
    to: """
        ${mockInit(interfaceName)}
        //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS
      """,
  );
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE",
    to: """
        ${registerFallbackValue(interfaceName)}
        //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE
      """,
  );
}
