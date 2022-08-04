import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:recase/recase.dart';
import 'package:template_utils/feature_templates.dart';

String featureComponentFilePath(String? feature) => ((feature?.isEmpty ?? true) || feature == 'core') //
    ? '../lib/dependency_injection/app_component.dart'
    : '../lib/features/$feature/dependency_injection/feature_component.dart';

String mockDefinitionsFilePath(String? feature) => ((feature?.isEmpty ?? true) || feature == 'core') //
    ? '../test/mocks/mock_definitions.dart'
    : '../test/features/$feature/mocks/${feature}_mock_definitions.dart';

String mocksFilePath(String? feature) => ((feature?.isEmpty ?? true) || feature == 'core') //
    ? '../test/mocks/mocks.dart'
    : '../test/features/$feature/mocks/${feature}_mocks.dart';

String pagesTestConfigPath(String feature) => '../test/features/$feature/pages/flutter_test_config.dart';

/// makes sure the feature-specific getIt registration index file is created,
/// if its not, creates one and registers in master `app_component.dart` file
Future<void> ensureFeatureComponentFile({
  required String appPackage,
  required String? feature,
}) async {
  var featurePath = featureComponentFilePath(feature);
  var filePackage = featurePath.replaceAll("../lib/features/", "");
  final featureFile = File(featurePath);
  final coreFile = File(featureComponentFilePath(null));
  if (!await featureFile.exists()) {
    await featureFile.create(recursive: true);
    await writeToFile(filePath: featureFile.path, text: featureComponentTemplate(appPackage));
    await replaceAllInFile(
      filePath: coreFile.path,
      from: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
      to: """
import 'package:$appPackage/features/$filePackage' as $feature;
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS
      """,
    );
    await replaceAllInFile(
      filePath: coreFile.path,
      from: "//DO-NOT-REMOVE FEATURE_COMPONENT_INIT",
      to: """
$feature.configureDependencies();
//DO-NOT-REMOVE FEATURE_COMPONENT_INIT
      """,
    );
  }
}

/// makes sure the feature-specific mock definitions file is created, if its not, creates one
Future<void> ensureMockDefinitionsFile(
  String? feature, {
  HookContext? context,
}) async {
  var featurePath = mockDefinitionsFilePath(feature);
  final featureFile = File(featurePath).absolute;
  final coreFile = File(mockDefinitionsFilePath(null)).absolute;
  context?.logger.write("feature mocks file: ${featureFile.path}");
  context?.logger.write("core file: ${coreFile.path}");
  if (!await featureFile.exists()) {
    await featureFile.create(recursive: true);
    await writeToFile(filePath: featureFile.path, text: featureMockDefinitionsTemplate);
  }
}

/// makes sure the feature-specific mocks file is created,
/// if its not, creates one and registers in master `mocks.dart` file
Future<void> ensureMocksFile(
  String? feature, {
  HookContext? context,
}) async {
  var featurePath = mocksFilePath(feature);
  var filePackage = featurePath.replaceAll("../test/", "../");
  final featureFile = File(featurePath);
  final coreFile = File(mocksFilePath(null));
  await _ensurePageTestConfigFile(feature);
  if (!await featureFile.exists()) {
    await featureFile.create(recursive: true);
    await writeToFile(filePath: featureFile.path, text: featureMocksTemplate(feature!));
    await replaceAllInFile(
      filePath: coreFile.path,
      from: "//DO-NOT-REMOVE IMPORTS_MOCKS",
      to: """
import '$filePackage';
//DO-NOT-REMOVE IMPORTS_MOCKS
      """,
    );
    await replaceAllInFile(
      filePath: coreFile.path,
      from: "//DO-NOT-REMOVE FEATURE_MOCKS_INIT",
      to: """
${feature.pascalCase}Mocks.init();
//DO-NOT-REMOVE FEATURE_MOCKS_INIT
      """,
    );
  }
}

Future<void> _ensurePageTestConfigFile(String? feature) async {
  if (feature == null || feature.isEmpty) {
    return;
  }
  final testConfigFile = File(pagesTestConfigPath(feature)).absolute;

  if (!await testConfigFile.exists()) {
    await testConfigFile.create(recursive: true);
    await writeToFile(filePath: testConfigFile.path, text: featurePageTestConfigTemplate);
  }
}

Future<void> replaceAllInFile({
  required String filePath,
  required String from,
  required String to,
}) async {
  final tmpFilePath = "${filePath}_write_.tmp";
  final tmpFile = File(tmpFilePath);
  bool contains = false;
  try {
    final readStream = readFileLines(filePath);
    final writeSink = tmpFile.openWrite();

    await for (var line in readStream) {
      if (line.contains(from)) {
        contains = true;
      }
      writeSink.writeln(line.replaceAll(from, to));
    }
    if (!contains) {
      throw "Target file ($filePath) does not contain '$from' text inside";
    }
    await writeSink.close();
  } catch (ex) {
    tmpFile.deleteSync();
    rethrow;
  }

  await tmpFile.rename(filePath);
}

Future<void> writeToFile({
  required String filePath,
  required String text,
}) async {
  final tmpFilePath = "${filePath}_write_.tmp";
  final tmpFile = File(tmpFilePath);

  try {
    await tmpFile.writeAsString(text);
  } catch (ex) {
    tmpFile.deleteSync();
    rethrow;
  }

  await tmpFile.rename(filePath);
}

Stream<String> readFileLines(String path) =>
    File(path).openRead().transform(utf8.decoder).transform(const LineSplitter());

void main() {
  ensureMockDefinitionsFile("sample_feature");
}
