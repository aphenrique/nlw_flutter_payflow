import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final barcodeScannerController = BarcodeScannerController();

  @override
  void initState() {
    barcodeScannerController.getAvaiableCameras();
    barcodeScannerController.statusNotifier.addListener(() {
      if (barcodeScannerController.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto",
            arguments: barcodeScannerController.status.barcode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    barcodeScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      top: true,
      bottom: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  color: Colors.blue,
                  child:
                      barcodeScannerController.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  leading: BackButton(
                    color: AppColors.background,
                  ),
                  title: Text(
                    "Escaneie o código de barras",
                    style: AppTextStyles.buttonBackground,
                  ),
                  backgroundColor: Colors.black,
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.black.withOpacity(0.3),
                    )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                        )),
                    Expanded(
                        child: Container(
                      color: Colors.black.withOpacity(0.3),
                    )),
                  ],
                ),
                bottomNavigationBar: SetLabelButtons(
                  primaryLabel: "Inserir código do boleto",
                  primaryOnPressed: () {
                    Navigator.pushReplacementNamed(context, "/insert_boleto");
                  },
                  secondaryLabel: "Adicionar da galeria",
                  secondaryOnPressed: () {},
                )),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return BottomSheetWidget(
                    title: "Não foi possível escanear o código de barras",
                    subTitle:
                        "Tente escanear novamente ou digite o código do boleto",
                    primaryLabel: "Escanear novamente",
                    primaryOnPressed: () {
                      barcodeScannerController.scanWithCamera();
                    },
                    secondaryLabel: "Digitar o código do boleto",
                    secondaryOnPressed: () {
                      Navigator.pushReplacementNamed(context, "/insert_boleto");
                    });
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
