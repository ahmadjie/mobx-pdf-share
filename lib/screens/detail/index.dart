import 'dart:io';
import 'dart:typed_data';
import 'package:creditest/stores/photo_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
// import 'package:share_plus/share_plus.dart';

GetIt getIt = GetIt.instance;

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  final store = getIt<PhotoStore>();

  void shareImg() async {
    // screenshoot the widget
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        // create file name and get path
        String fileName = DateTime.now().toString();
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/$fileName.jpg').create();

        // save image to path
        await imagePath.writeAsBytes(image);

        // await Share.shareFiles([imagePath.path]);
        // print(imagePath.path);

        // share image to whhatsapp
        await flutterShareMe.shareToWhatsApp(
          imagePath: imagePath.path,
          fileType: FileType.image,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Screenshot(
              child: Container(
                color: Colors.grey[50],
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: size.width,
                        minHeight: 200,
                        maxWidth: size.width,
                        maxHeight: 250,
                      ),
                      child: Image.network(
                        store.detailData!.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      store.detailData!.toJson().toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              controller: screenshotController),
          ElevatedButton.icon(
            onPressed: shareImg,
            icon: const Icon(Icons.whatsapp),
            label: const Text('Share to Whatsapp'),
          ),
        ],
      ),
    );
  }
}
