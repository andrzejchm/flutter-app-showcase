// ignore_for_file: unused-code
import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'golden_test_device_scenario.dart';

final testDevices = [
  Device.phone.copyWith(name: "small phone"),
  Device.iphone11.copyWith(name: "iPhone 11"),
];

@isTest
Future<void> screenshotTest(
  String description, {
  String variantName = '',
  bool skip = false,
  FutureOr<void> Function()? setUp,
  required Widget Function() pageBuilder,
  List<String> tags = const ['golden'],
  List<Device>? devices,
  Duration timeout = const Duration(seconds: 5),
}) async {
  return goldenTest(
    description,
    fileName: "$description${variantName.trim().isEmpty ? '' : '_$variantName'}",
    builder: () {
      setUp?.call();

      return GoldenTestGroup(
        children: (devices ?? testDevices) //
            .map(
              (it) => DefaultAssetBundle(
                bundle: TestAssetBundle(),
                child: GoldenTestDeviceScenario(device: it, builder: pageBuilder),
              ),
            )
            .toList(),
      );
    },
    tags: tags,
    skip: skip,
    pumpBeforeTest: (tester) => mockNetworkImages(() => precacheImages(tester)).timeout(timeout),
    pumpWidget: (tester, widget) => mockNetworkImages(() => tester.pumpWidget(widget)).timeout(timeout),
  ).timeout(timeout);
}

@isTest
Future<void> widgetScreenshotTest(
  String description, {
  String variantName = '',
  bool skip = false,
  required WidgetBuilder widgetBuilder,
  List<String> tags = const ['golden'],
  Duration timeout = const Duration(seconds: 5),
}) async {
  return goldenTest(
    description,
    fileName: "$description${variantName.trim().isEmpty ? '' : '_$variantName'}",
    builder: () {
      return DefaultAssetBundle(
        bundle: TestAssetBundle(),
        child: Builder(builder: widgetBuilder),
      );
    },
    tags: tags,
    skip: skip,
    pumpBeforeTest: (tester) => mockNetworkImages(() => precacheImages(tester)).timeout(timeout),
    pumpWidget: (tester, widget) => mockNetworkImages(() => tester.pumpWidget(widget)).timeout(timeout),
  ).timeout(timeout);
}

/// small helper to add container around widget with some background in order to better understand widget's bounds
class TestWidgetContainer extends StatelessWidget {
  const TestWidgetContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.red),
      ),
      child: child,
    );
  }
}
