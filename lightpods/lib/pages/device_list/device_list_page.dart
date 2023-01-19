import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/pages/device_list/pod_state.dart';
import 'package:lightpods/logic/pod/pod.dart';
import 'package:lightpods/partials/pod_count.dart';
import 'package:lightpods/services/bluetooth_device_service.dart';

import '../../services/pod_service.dart';
import '../../test/fake_pod.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  State createState() => _DeviceList();
}

class _DeviceList extends State<DeviceList> {
  final _podService = GetIt.I.get<PodService>();
  final _bluetoothDeviceService = BluetoothDeviceService();
  late List<BluetoothDevice> _devices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device List'),
        actions: [PodCount(count: _podService.numberOfConnectedPods)],
      ),
      body: _getDeviceList(_devices),
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

    _bluetoothDeviceService.addListener(_updateDevices);
    _devices = _bluetoothDeviceService.devices;
    //scanForDevices();
  }

  ListView _getDeviceList(List<BluetoothDevice> devices) {
    List<Widget> containers = <Widget>[];

    var podList = _podService.getPods();
    for (var pod in podList) {
      containers.add(PodState(pod: pod));
    }
    //containers.add(PodState(pod: FakePod('aa:bb')));

    return ListView(
      children: containers,
    );
  }

  void _updateDevices() {
    print("_updateDevices: ${_devices.length}");
    for (BluetoothDevice device in _devices) {
      print("device: ${device.name}");
      _podService.addPod(Pod(device));
    }

    setState(() {});
  }
}
