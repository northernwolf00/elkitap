// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:permission_handler/permission_handler.dart';

// // Real Bluetooth Controller
// class BluetoothController extends GetxController {
//   final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  
//   final RxBool isSearching = false.obs;
//   final RxBool isBluetoothEnabled = false.obs;
//   final RxList<BluetoothDevice> pairedDevices = <BluetoothDevice>[].obs;
//   final RxList<BluetoothDiscoveryResult> discoveredDevices = <BluetoothDiscoveryResult>[].obs;
//   final Rxn<BluetoothDevice> connectedDevice = Rxn<BluetoothDevice>();

//   @override
//   void onInit() {
//     super.onInit();
//     _checkBluetoothState();
//     _getConnectedDevice();
//   }

//   Future<void> _checkBluetoothState() async {
//     try {
//       final state = await _bluetooth.state;
//       isBluetoothEnabled.value = state.isEnabled;
      
//       if (state.isEnabled) {
//         await _loadPairedDevices();
//       }
//     } catch (e) {
//       print('Error checking bluetooth state: $e');
//     }
//   }

//   Future<void> _getConnectedDevice() async {
//     try {
//       final device = await _bluetooth.name;
//       connectedDevice.value = device as BluetoothDevice?;
//     } catch (e) {
//       print('Error getting connected device: $e');
//     }
//   }

//   Future<bool> requestPermissions() async {
//     if (GetPlatform.isAndroid) {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.bluetooth,
//         Permission.bluetoothScan,
//         Permission.bluetoothConnect,
//         Permission.location,
//       ].request();

//       return statuses.values.every((status) => status.isGranted);
//     }
//     return true;
//   }

//   Future<void> enableBluetooth() async {
//     try {
//       await _bluetooth.requestEnable();
//       isBluetoothEnabled.value = true;
//       await _loadPairedDevices();
//     } catch (e) {
//       print('Error enabling bluetooth: $e');
//     }
//   }

//   Future<void> _loadPairedDevices() async {
//     try {
//       final devices = await _bluetooth.getBondedDevices();
//       pairedDevices.value = devices;
//     } catch (e) {
//       print('Error loading paired devices: $e');
//     }
//   }

//   Future<void> startDiscovery() async {
//     if (!isBluetoothEnabled.value) {
//       await enableBluetooth();
//       return;
//     }

//     final hasPermission = await requestPermissions();
//     if (!hasPermission) {
//       Get.snackbar(
//         'Permission Required',
//         'Bluetooth permissions are required to scan for devices',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     try {
//       isSearching.value = true;
//       discoveredDevices.clear();

//       _bluetooth.startDiscovery().listen((result) {
//         // Add only if not already in the list
//         if (!discoveredDevices.any((d) => d.device.address == result.device.address)) {
//           discoveredDevices.add(result);
//         }
//       }).onDone(() {
//         isSearching.value = false;
//       });
//     } catch (e) {
//       isSearching.value = false;
//       print('Error starting discovery: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to start device discovery',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   Future<void> cancelDiscovery() async {
//     try {
//       await _bluetooth.cancelDiscovery();
//       isSearching.value = false;
//     } catch (e) {
//       print('Error canceling discovery: $e');
//     }
//   }

//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await cancelDiscovery();
      
//       // Try to connect using BluetoothConnection
//       Get.snackbar(
//         'Connecting',
//         'Connecting to ${device.name ?? device.address}...',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 2),
//       );

//       // For audio devices, you typically need to pair first
//       if (!device.isBonded) {
//         final bonded = await _bluetooth.bondDeviceAtAddress(device.address);
//         if (!bonded!) {
//           Get.snackbar(
//             'Failed',
//             'Could not pair with device',
//             snackPosition: SnackPosition.BOTTOM,
//           );
//           return;
//         }
//       }

//       connectedDevice.value = device;
//       await _loadPairedDevices();
      
//       Get.snackbar(
//         'Connected',
//         'Connected to ${device.name ?? device.address}',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 2),
//       );
//     } catch (e) {
//       print('Error connecting to device: $e');
//       Get.snackbar(
//         'Connection Failed',
//         'Failed to connect to ${device.name ?? device.address}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   IconData getDeviceIcon(BluetoothDevice device) {
//     final deviceType = device.type;
//     final deviceName = device.name?.toLowerCase() ?? '';

//     if (deviceName.contains('airpods') || deviceName.contains('headphone') || 
//         deviceName.contains('buds') || deviceType == BluetoothDeviceType.classic) {
//       return Icons.headphones;
//     } else if (deviceName.contains('speaker') || deviceType == BluetoothDeviceType.unknown) {
//       return Icons.speaker;
//     } else if (deviceName.contains('phone') || deviceName.contains('iphone') || 
//                deviceName.contains('android')) {
//       return Icons.phone_iphone;
//     } else if (deviceName.contains('mac') || deviceName.contains('laptop') || 
//                deviceName.contains('computer')) {
//       return Icons.laptop_mac;
//     } else if (deviceName.contains('tablet') || deviceName.contains('ipad')) {
//       return Icons.tablet_mac;
//     } else if (deviceName.contains('watch')) {
//       return Icons.watch;
//     } else if (deviceName.contains('car')) {
//       return Icons.directions_car;
//     } else {
//       return Icons.bluetooth;
//     }
//   }

//   @override
//   void onClose() {
//     cancelDiscovery();
//     super.onClose();
//   }
// }