import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rees46_plugin/rees46_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _rees46Plugin = Rees46Controller.instance();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _rees46Plugin.initialize('d538197df225c66e7413647e553289', '');
      _rees46Plugin.initialize('c58471e2acfbc83c9f02d1083a6b07a5', '');
      _rees46Plugin.initialize('7e6c2ef77fcc6bc80fedf64a7103b705', '');
      _rees46Plugin.initialize('da2668fe479fa866e9d888d976db914a', '');

    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: InkWell(
              onTap: () {
                initPlatformState();
              },
              child: const Text('Plugin example app')),
        ),
        body: Center(
          child: InkWell(onTap: () {
            _rees46Plugin.track("VIEW", '12333');
            _rees46Plugin.recommend("b92d1c9dcd16ecfb83fb1335bc5e2464", false, "", "");
          },child: Text('Running on: $_platformVersion\n')),
        ),
      ),
    );
  }
}
