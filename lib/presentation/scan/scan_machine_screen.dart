import 'dart:io';

import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanMachineScreen extends ConsumerStatefulWidget {
  const ScanMachineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScanMachineScreenState();
}

class _ScanMachineScreenState extends ConsumerState<ScanMachineScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      ref.read(qrControllerProvider)!.pauseCamera();
    }
    ref.read(qrControllerProvider)!.resumeCamera();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    } else {
      ref.read(qrControllerProvider)?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.sizeOf(context).width < 400 ||
            MediaQuery.sizeOf(context).height < 400)
        ? 350.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        ref.read(qrControllerProvider.notifier).update((state) => controller);
        controller.scannedDataStream.listen((scanData) async {
          AppPrint.debugLog("SCANN DAT: ${scanData.code}");
          controller.pauseCamera();
          Navigator.pop(context, scanData.code);

          if (scanData.code != null) {
            ref
                .read(idQrCodeProvider.notifier)
                .update((state) => scanData.code!);
            AppPrint.debugLog("DATA BARCODE TIDAK NULL ${scanData.code}");
            ref.invalidate(qrControllerProvider);
            ref.invalidate(barcodeProvider);
            await ref.read(routerProvider).push(RouteName.resultScanMachine);
          } else {
            AppDialog.customDialog(context, "Barcode tidak valid!");
          }
        });
      },
      // cameraFacing: CameraFacing.back, // di real device ini gak work
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
}
