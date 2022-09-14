import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:screenshot/screenshot.dart';
import 'package:virtual_sketch_app/components/arcore_image_view.dart';
import 'package:virtual_sketch_app/components/custom_close_button.dart';

class ArCameraView extends StatefulWidget {
  const ArCameraView({Key? key}) : super(key: key);

  @override
  State<ArCameraView> createState() => _ArCameraViewState();
}

class _ArCameraViewState extends State<ArCameraView> {
  Uint8List? imageFileBytes;

  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    // return Screenshot(
    //   controller: controller,
    //   child: Scaffold(
    //       appBar: AppBar(title: const Text('App bar')),
    //       backgroundColor: Colors.blueAccent,
    //       body: Indexer(
    //         children: [
    //           Indexed(
    //               index: 999,
    //               child: Container(
    //                 child: CustomCloseButton(onClose: () => {}),
    //               )),
    //           Column(
    //             mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: [
    //               const Expanded(
    //                 child: ArcoreImageView(),
    //               ),
    //               Padding(
    //                   padding: const EdgeInsets.all(15),
    //                   child: CustomCloseButton(onClose: _takeScreenShoot)),
    //               // if (imageFile != null) Image.memory(imageFile!)
    //               SizedBox(
    //                   height: 200,
    //                   //   child: Image.network(
    //                   //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHBlcnNvbnxlbnwwfHwwfHw%3D&w=1000&q=80'
    //                   // )
    //                   child: imageFileBytes != null
    //                       ? Image.memory(imageFileBytes!)
    //                       : Image.network(
    //                           'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHBlcnNvbnxlbnwwfHwwfHw%3D&w=1000&q=80')),
    //             ],
    //           )
    //         ],
    //       )),
    // );

    return const ArcoreImageView();
  }

  void _takeScreenShoot() async {
    final imageFile = await controller.capture();
    if (imageFile != null) {
      // final File file = File.fromRawPath(imageFile);
      // print(file);

      setState(() {
        imageFileBytes = imageFile;
      });
    }
  }
}
