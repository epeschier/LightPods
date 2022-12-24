import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/partials/podstate.dart';
import 'package:lightpods/models/pod.dart';
import 'package:lightpods/services/pod_service.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({Key? key}) : super(key: key);

  @override
  State createState() => _DeviceList();
}

class _DeviceList extends State<DeviceList> {
  final PodService _podService = GetIt.I.get<PodService>();

  @override
  Widget build(BuildContext context) {
    final List<BluetoothDevice> devices = _podService.devices;
    _podService.addListener(() => setState(() {}));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device List'),
      ),
      body: getDeviceList(devices),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.bluetooth_searching),
          onPressed: () {
            _podService.scanForDevices();
            //_podService.test();
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    //scanForDevices();
  }

  ListView getDeviceList(List<BluetoothDevice> devices) {
    List<Widget> containers = <Widget>[];

    for (BluetoothDevice device in devices) {
      containers.add(PodState(pod: Pod(device: device)));
    }

    return ListView(
      children: <Widget>[
        ...containers,
      ],
    );
  }
}
