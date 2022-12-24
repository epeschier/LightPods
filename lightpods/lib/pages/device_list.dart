import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lightpods/components/podstate.dart';
import 'package:lightpods/models/pod.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({Key? key}) : super(key: key);

  @override
  State createState() => _DeviceList();
}

class _DeviceList extends State<DeviceList> {
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device List'),
      ),
      body: getDeviceList(devicesList),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.bluetooth_searching),
          onPressed: () {
            scanForDevices();
            // setState(() {
            //   devicesList.add(BluetoothDevice.fromId('someid'));
            // });
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
      containers.add(PodState(
        pod: Pod(id: device.id.toString(), name: device.name),
      ));
    }

    return ListView(
      children: <Widget>[
        ...containers,
      ],
    );
  }

// TODO: move to separate class
  void scanForDevices() {
    print('Start device scan');

    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan();
    /*
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.name} found! ${r.device.id} rssi: ${r.rssi}');
      }
    });
    flutterBlue.stopScan();
    */
  }

/* Nordic Led-Button Service (LBS)
 * LBS Service: 00001523-1212-EFDE-1523-785FEABCD123
 * LBS Button : 00001524-1212-EFDE-1523-785FEABCD123
 * LBS LED    : 00001525-1212-EFDE-1523-785FEABCD123
 */
  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      print('Add device: ${device.toString()}');
      setState(() {
        devicesList.add(device);
      });
    }
  }
}
