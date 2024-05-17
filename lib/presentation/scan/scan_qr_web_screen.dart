import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrWebScreen extends ConsumerWidget {
  const ScanQrWebScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraController = ref.watch(mobileScannerControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (_, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: MobileScannerController(
          torchEnabled: !kIsWeb,
          // facing: CameraFacing.back,
          // torchEnabled: false,
          // returnImage: true,
        ),
        onDetect: (capture) {
          final BarcodeCapture barcodes = capture;
          Navigator.pop(context, barcodes.raw['rawValue'].toString());
          // final Uint8List? image = capture.image;
          // for (final barcode in barcodes) {
          //   debugPrint('Barcode found! ${barcode.rawValue}');
          // }
          // barcodes.rawValue
          // if (image != null) {
          //   showDialog(
          //     context: context,
          //     builder: (context) =>
          //         Image(image: MemoryImage(image)),
          //   );
          //   Future.delayed(const Duration(seconds: 5), () {
          //     Navigator.pop(context);
          //   });
          // }
        },
      ),
    );
  }
}
