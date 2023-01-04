import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/partials/pod_state.dart';
import 'package:lightpods/logic/pod/pod.dart';
import 'package:lightpods/services/bluetooth_device_service.dart';

import '../test/fake_pod.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  State createState() => _DeviceList();
}

class _DeviceList extends State<DeviceList> {
  final _bluetoothDeviceService = GetIt.I.get<BluetoothDeviceService>();

  @override
  Widget build(BuildContext context) {
    final List<BluetoothDevice> devices = _bluetoothDeviceService.devices;
    _bluetoothDeviceService.addListener(() => setState(() {}));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device List'),
      ),
      body: _getDeviceList(devices),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.bluetooth_searching),
          onPressed: () {
            _bluetoothDeviceService.scanForDevices();
            //_podService.test();
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    //scanForDevices();
  }

  ListView _getDeviceList(List<BluetoothDevice> devices) {
    List<Widget> containers = <Widget>[];

    for (BluetoothDevice device in devices) {
      containers.add(PodState(pod: Pod(device: device)));
    }
    //containers.add(PodState(pod: FakePod('aa:bb')));

    return ListView(
      children: containers,
    );
  }
}
