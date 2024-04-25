import 'package:flutter_test/flutter_test.dart';
import 'package:rees46_plugin/rees46_plugin.dart';
import 'package:rees46_plugin/rees46_plugin_platform_interface.dart';
import 'package:rees46_plugin/rees46_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRees46PluginPlatform
    with MockPlatformInterfaceMixin
    implements Rees46PluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Rees46PluginPlatform initialPlatform = Rees46PluginPlatform.instance;

  test('$MethodChannelRees46Plugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRees46Plugin>());
  });

  test('getPlatformVersion', () async {
    Rees46Plugin rees46Plugin = Rees46Plugin();
    MockRees46PluginPlatform fakePlatform = MockRees46PluginPlatform();
    Rees46PluginPlatform.instance = fakePlatform;

    expect(await rees46Plugin.getPlatformVersion(), '42');
  });
}
