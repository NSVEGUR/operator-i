import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class ArithmeticScreen extends StatefulWidget {
  const ArithmeticScreen({super.key});

  @override
  State<ArithmeticScreen> createState() => _ArithmeticScreenState();
}

class _ArithmeticScreenState extends State<ArithmeticScreen> {
  Uint8List? resBinImage;
  Uint8List? resGrayImage;
  Uint8List? resAddImage;
  var resShape;
  XFile? image;

  Future<int> retShape(
      {required List<File> file, required List<String> filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}arithmetic/add"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    List<MultipartFile> newList = <MultipartFile>[];

    for (int i = 0; i < file.length; i++) {
      var stream = http.ByteStream(file[i].openRead());
      var length = await file[i].length();

      var multipartFile =
          http.MultipartFile("",stream, length, filename: filename[i]);

      newList.add(multipartFile);
    }

    request.files.addAll(newList);

    request.headers.addAll(headers);
    print("request:${request}");
    final response = await request.send();
    print("response:$response");
    final res = await http.Response.fromStream(response);
    print(res.toString());

    setState(() {
      resAddImage = res.bodyBytes;
      print(resAddImage);
    });

    return response.statusCode;
  }

  uploadAdd() async {
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

      await retShape(file: pickedImage, filename: filenames);
    }
  }

  Future<int> retbinaryImage(
      {required File file, required String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}intro/binary"),
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
      {required File file, required String filename}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}intro/gray"),
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
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retgrayImage(
          file: pickedImage, filename: pickedImage.path.split("/").last);
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
              SizedBox(
                height: 40.0,
                width: 250.0,
                child: FloatingActionButton.extended(
                  heroTag: "addition",
                  icon: const Icon(Icons.upload_file),
                  onPressed: uploadAdd,
                  label: const Text("Add images"),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              resAddImage == null
                  ? const Text("Upload 2 Images")
                  : Image.memory(
                      resAddImage!,
                      height: 150.0,
                      width: 150.0,
                      semanticLabel: "Addition",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
