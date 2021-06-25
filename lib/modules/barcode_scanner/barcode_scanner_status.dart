import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final bool isAvailable;
  final String error;
  final String barcode;
  final bool stopScanner;

  BarcodeScannerStatus(
      {this.isAvailable = false,
      this.error = "",
      this.stopScanner = false,
      this.barcode = ""});

  factory BarcodeScannerStatus.available() =>
      BarcodeScannerStatus(isAvailable: true, stopScanner: false);

  factory BarcodeScannerStatus.error(String message) =>
      BarcodeScannerStatus(error: message);

  factory BarcodeScannerStatus.barcode(String barcode) =>
      BarcodeScannerStatus(barcode: barcode);

  bool get showCamera => isAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
