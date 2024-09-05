import 'dart:async';
import 'dart:typed_data';
import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page_screen.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_models/workshop_model.dart';

class WorkshopQrPage extends StatefulWidget {
  final WorkshopModel model;
  final Map attendeeData;

  const WorkshopQrPage({
    super.key,
    required this.model,
    required this.attendeeData,
  });

  @override
  State<WorkshopQrPage> createState() => _WorkshopQrPageState();
}

class _WorkshopQrPageState extends State<WorkshopQrPage> {
  @override
  void initState() {
    super.initState();
    print(widget.attendeeData.length);
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserUid = GlobalFirebase.uId;

    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        // backgroundColor: AppColors.black6,
        title: const Text('Scan QR'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          }
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: widget.attendeeData.length,
          itemBuilder: (context, index) {
            final email = widget.attendeeData.values.toList()[index]['Email'];

            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TicketWidget(
                model: widget.model,
                modelWid: widget.model.wId,
                userUid: currentUserUid,
                attendeeEmail: email,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TicketWidget extends StatefulWidget {
  final String modelWid;
  final String userUid;
  final String attendeeEmail;
  final WorkshopModel model;

  const TicketWidget({
    super.key,
    required this.modelWid,
    required this.userUid,
    required this.attendeeEmail,
    required this.model,
  });

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final String qrContent =
        '${widget.modelWid}_${widget.userUid}_${widget.attendeeEmail}';
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.black6,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.black4, width: 1)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.black2, width: 1)),
                    child: QrImageView(
                      data: qrContent,
                      size: 200,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.model.title.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  buildDetailRow('Date:', widget.model.startDate ?? 'N/A'),
                  buildDetailRow('Time:', widget.model.startTime ?? 'N/A'),
                  buildDetailRow('Venue:', widget.model.location ?? 'N/A'),
                  const Divider(),
                  buildDetailRow('ID:', widget.modelWid),
                  buildDetailRow('Email:', widget.attendeeEmail),
                  buildDetailRow('Payment Status:', 'Success',
                      statusColor: Colors.green),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Space.spacer(0.01),
          Row(
            children: [
              Expanded(
                child: buildButton(context, 'Download', onPressed: () async {
                  await downloadScanner().then(
                    (value) {
                      Warnings.onSuccess("Successfully downloaded");
                    },
                  );
                }, isPrimary: false),
              ),
              Space.width(0.01),
              Expanded(
                child: buildButton(context, 'Share', onPressed: () async {
                    print("sharing start");
                    final image =
                        await screenshotController.capture();
                    Share.shareXFiles([XFile.fromData(image!, mimeType: "jpg")],
                        text: "This is my Qr code");
                  }, isPrimary: false),
                // })
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value, {Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(
              color: statusColor ?? Colors.black,
              fontWeight:
                  statusColor != null ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String text,
      {required VoidCallback onPressed, bool isPrimary = true}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        backgroundColor: isPrimary ? Colors.black87 : Colors.white,
        side: isPrimary ? null : const BorderSide(color: Colors.black87),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(
        text,
        style: TextStyle(color: isPrimary ? Colors.white : Colors.black87),
      ),
    );
  }

  Future<void> downloadScanner() async {
    screenshotController.capture().then((Uint8List? newImage) async {
      try {
        await Permission.storage.request();
        if (newImage != null) {
          await SaverGallery.saveImage(newImage,
              name: "hello", androidExistNotSave: false);
          // print("RESULT "+result);
        } else {
          print('Failed to capture screenshot');
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
