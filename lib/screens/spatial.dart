import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class SpatialScreen extends StatefulWidget {
  const SpatialScreen({super.key});

  @override
  State<SpatialScreen> createState() => _SpatialScreenState();
}

class _SpatialScreenState extends State<SpatialScreen> {
  Uint8List? resBinImage;
  Uint8List? resGrayImage;
  Uint8List? resAddImage;
  var resShape;
  XFile? image;

  Future<int> retbinaryImage(
      {required File file, required String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}spatial/equalize"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
      ),
    );
    request.headers.addAll(headers);
    print("request: $request");
    final resStrem = await request.send();
    final res = await http.Response.fromStream(resStrem);
    setState(() {
      resBinImage = res.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return resStrem.statusCode;
  }

  uploadBinaryImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retbinaryImage(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<int> retgrayImage(
      {required List<File> file, required List<String> filename}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}spatial/matching"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    for (int i = 0; i < file.length; i++){request.files.add(
      http.MultipartFile(
        'file$i',
        file[0].readAsBytes().asStream(),
        file[0].lengthSync(),
        filename: filename[0],
      ),
    );}

    request.headers.addAll(headers);
    print("request: $request");
    final gresStrem = await request.send();
    print(gresStrem);
    final gres = await http.Response.fromStream(gresStrem);
    setState(() {
      resGrayImage = gres.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return gres.statusCode;
  }

  uploadGrayImage() async {
    List<File> pickedImage = [];
    List<XFile> image = [];
    image.add((await ImagePicker().pickImage(source: ImageSource.gallery))!);
    image.add((await ImagePicker().pickImage(source: ImageSource.gallery))!);

    if (image != null) {
      for (int i = 0; i < image.length; i++) {
        print(image.length);
        pickedImage.add(File(image[i].path));
      }

      List<String> filenames =
          pickedImage.map((image) => image.path.split("/").last).toList();

      await retgrayImage(file: pickedImage, filename: filenames);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/logo.png"), scale: 0.25, opacity: 0.25),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 40.0,
                width: 250.0,
                child: FloatingActionButton.extended(
                    heroTag: "gray",
                    icon: const Icon(Icons.upload_file),
                    onPressed: uploadGrayImage,
                    label: const Text("Gray")),
              ),
              const SizedBox(
                height: 10.0,
              ),
              resGrayImage == null
                  ? const Text("Upload Image")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.file(
                          File(image!.path),
                          height: 150.0,
                          width: 150.0,
                          semanticLabel: "Original",
                        ),
                        Image.memory(
                          resGrayImage!,
                          height: 150.0,
                          width: 150.0,
                          semanticLabel: "Gray",
                        ),
                      ],
                    ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 40.0,
                width: 250.0,
                child: FloatingActionButton.extended(
                    heroTag: "binary",
                    icon: const Icon(Icons.upload_file),
                    onPressed: uploadBinaryImage,
                    label: const Text("Binary")),
              ),
              const SizedBox(
                height: 10.0,
              ),
              resBinImage == null
                  ? const Text("Upload Image")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.file(
                          File(image!.path),
                          height: 150.0,
                          width: 150.0,
                          semanticLabel: "Original",
                        ),
                        Image.memory(
                          resBinImage!,
                          height: 150.0,
                          width: 150.0,
                          semanticLabel: "Binary",
                        ),
                      ],
                    ),
              const SizedBox(
                height: 10.0,
              ),
              // SizedBox(
              //   height: 40.0,
              //   width: 250.0,
              //   child: FloatingActionButton.extended(
              //     heroTag: "addition",
              //     icon: const Icon(Icons.upload_file),
              //     onPressed: uploadAdd,
              //     label: const Text("Add images"),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              // resAddImage == null
              //     ? const Text("Upload 2 Images")
              //     : Image.memory(
              //         resAddImage!,
              //         height: 150.0,
              //         width: 150.0,
              //         semanticLabel: "Addition",
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
