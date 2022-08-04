import 'package:mason/mason.dart';
import 'package:recase/recase.dart';
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  final appPackage = context.vars["app_package"] as String;
  final importPath = context.vars["import_path"] as String;
  final pageName = context.vars["page_name"] as String;
  final presenterName = context.vars["presenter_name"] as String;
  final presentationModelName = context.vars["presentation_model_name"] as String;
  final viewModelName = context.vars["view_model_name"] as String;
  final initialParamsName = context.vars["initial_params_name"] as String;
  final navigatorName = context.vars["navigator_name"] as String;
  final navigatorFileName = context.vars["navigator_file_name"] as String;
  final presentationModelFileName = context.vars["presentation_model_file_name"] as String;
  final initialParamsFileName = context.vars["initial_params_file_name"] as String;
  final presenterFileName = context.vars["presenter_file_name"] as String;
  final pageFileName = context.vars["page_file_name"] as String;
  final feature = context.vars["feature"] as String;

  await _replaceInMockDefinitions(
    context: context,
    appPackage: appPackage,
    importPath: importPath,
    navigatorName: navigatorName,
    viewModelName: viewModelName,
    presentationModelName: presentationModelName,
    initialParamsName: initialParamsName,
    presenterName: presenterName,
    pageName: pageName,
    navigatorFileName: navigatorFileName,
    presentationModelFileName: presentationModelFileName,
    initialParamsFileName: initialParamsFileName,
    presenterFileName: presenterFileName,
    pageFileName: pageFileName,
    feature: feature,
  );

  await _replaceInMocks(
    context: context,
    navigatorName: navigatorName,
    presentationModelName: presentationModelName,
    initialParamsName: initialParamsName,
    presenterName: presenterName,
    pageName: pageName,
    feature: feature,
  );

  await _replaceInAppComponent(
    context: context,
    appPackage: appPackage,
    importPath: importPath,
    navigatorName: navigatorName,
    presentationModelName: presentationModelName,
    initialParamsName: initialParamsName,
    presenterName: presenterName,
    pageName: pageName,
    navigatorFileName: navigatorFileName,
    presentationModelFileName: presentationModelFileName,
    initialParamsFileName: initialParamsFileName,
    presenterFileName: presenterFileName,
    pageFileName: pageFileName,
    feature: feature,
  );
}

Future<void> _replaceInMockDefinitions({
  required HookContext context,
  required String appPackage,
  required String importPath,
  required String navigatorName,
  required String navigatorFileName,
  required String presentationModelName,
  required String viewModelName,
  required String presentationModelFileName,
  required String initialParamsName,
  required String initialParamsFileName,
  required String presenterName,
  required String presenterFileName,
  required String pageName,
  required String pageFileName,
  required String feature,
}) async {
  await ensureMockDefinitionsFile(feature);
  await replaceAllInFile(
    filePath: mockDefinitionsFilePath(feature),
    from: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
    to: """
import 'package:$appPackage/$importPath/$initialParamsFileName';
import 'package:$appPackage/$importPath/$navigatorFileName';
import 'package:$appPackage/$importPath/$presentationModelFileName';
import 'package:$appPackage/$importPath/$presenterFileName';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS
      """,
  );

  await replaceAllInFile(
    filePath: mockDefinitionsFilePath(feature),
    from: "//DO-NOT-REMOVE MVP_MOCK_DEFINITION",
    to: """
class Mock$presenterName extends MockCubit<$viewModelName> implements $presenterName {}
class Mock$presentationModelName extends Mock implements $presentationModelName {}
class Mock$initialParamsName extends Mock implements $initialParamsName {}
class Mock$navigatorName extends Mock implements $navigatorName {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION
      """,
  );
}

Future<void> _replaceInMocks({
  required HookContext context,
  required String navigatorName,
  required String presentationModelName,
  required String initialParamsName,
  required String presenterName,
  required String pageName,
  required String feature,
}) async {
  final mockStaticField = (String name) => "static late Mock$name ${name.camelCase};";
  final mockInit = (String name) => "${name.camelCase} = Mock$name();";
  final registerFallbackValue = (String name) => "registerFallbackValue(Mock$name());";

  await ensureMocksFile(feature);
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD",
    to: """
        ${mockStaticField(presenterName)}
        ${mockStaticField(presentationModelName)}
        ${mockStaticField(initialParamsName)}
        ${mockStaticField(navigatorName)}
        //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD
      """,
  );
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE MVP_INIT_MOCKS",
    to: """
        ${mockInit(presenterName)}
        ${mockInit(presentationModelName)}
        ${mockInit(initialParamsName)}
        ${mockInit(navigatorName)}
        //DO-NOT-REMOVE MVP_INIT_MOCKS
      """,
  );
  await replaceAllInFile(
    filePath: mocksFilePath(feature),
    from: "//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE",
    to: """
        ${registerFallbackValue(presenterName)}
        ${registerFallbackValue(presentationModelName)}
        ${registerFallbackValue(initialParamsName)}
        ${registerFallbackValue(navigatorName)}
        //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE
      """,
  );
}

Future<void> _replaceInAppComponent({
  required HookContext context,
  required String appPackage,
  required String importPath,
  required String navigatorName,
  required String navigatorFileName,
  required String presentationModelName,
  required String presentationModelFileName,
  required String initialParamsName,
  required String initialParamsFileName,
  required String presenterName,
  required String presenterFileName,
  required String pageName,
  required String pageFileName,
  required String feature,
}) async {
  await ensureFeatureComponentFile(appPackage: appPackage, feature: feature);
  await replaceAllInFile(
    filePath: featureComponentFilePath(feature),
    from: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
    to: """
import 'package:$appPackage/$importPath/$initialParamsFileName';
import 'package:$appPackage/$importPath/$navigatorFileName';
import 'package:$appPackage/$importPath/$pageFileName';
import 'package:$appPackage/$importPath/$presentationModelFileName';
import 'package:$appPackage/$importPath/$presenterFileName';
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS
      """,
  );
  await replaceAllInFile(
    filePath: featureComponentFilePath(feature),
    from: "//DO-NOT-REMOVE MVP_GET_IT_CONFIG",
    to: """
      ..registerFactory<$navigatorName>(
      () => $navigatorName(getIt()),
    )
    ..registerFactoryParam<$presentationModelName, $initialParamsName, dynamic>(
      (params, _) => $presentationModelName.initial(params),
    )
    ..registerFactoryParam<$presenterName, $initialParamsName, dynamic>(
      (initialParams, _) => $presenterName(
        getIt(param1: initialParams),
        getIt(),
      ),
    )
    ..registerFactoryParam<$pageName, $initialParamsName, dynamic>(
      (initialParams, _) => $pageName(
        presenter: getIt(param1: initialParams),
      ),
    )
        //DO-NOT-REMOVE MVP_GET_IT_CONFIG
      """,
  );
}
