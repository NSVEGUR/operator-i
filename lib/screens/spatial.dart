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
  Uint8List? resEqualize;
  Uint8List? resEnhance;
  Uint8List? resMatch;
  Uint8List? resGamma;
  Uint8List? resLog;
  XFile? image;

  Future<int> retEqualize(
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
      resEqualize = res.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return resStrem.statusCode;
  }

  uploadEqualize() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retEqualize(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<int> retContrast(
      {required File file, required String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}spatial/enhance"),
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
      resEnhance = res.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return resStrem.statusCode;
  }

  uploadContrast() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retContrast(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }
  Future<int> retLog(
      {required File file, required String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}spatial/logtrans"),
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
      resLog = res.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return resStrem.statusCode;
  }

  uploadLog() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retLog(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

    Future<int> retGamma(
      {required File file, required String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}spatial/gamma"),
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
    Map<String, String> gamma = {"gamma": "3","c":"1"};

    request.fields.addAll(gamma);


    request.headers.addAll(headers);
    print("request: $request");
    final resStrem = await request.send();
    final res = await http.Response.fromStream(resStrem);
    setState(() {
      resGamma = res.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return resStrem.statusCode;
  }

  uploadGamma() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retGamma(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<int> retMatch(
      {required List<File> file, required List<String> filename}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}spatial/matching"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    for (int i = 0; i < file.length; i++) {
      request.files.add(
        http.MultipartFile(
          'file$i',
          file[0].readAsBytes().asStream(),
          file[0].lengthSync(),
          filename: filename[0],
        ),
      );
    }

    request.headers.addAll(headers);
    print("request: $request");
    final gresStrem = await request.send();
    print(gresStrem);
    final gres = await http.Response.fromStream(gresStrem);
    setState(() {
      resMatch = gres.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return gres.statusCode;
  }

  uploadMatch() async {
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

      await retMatch(file: pickedImage, filename: filenames);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/logo.png"), scale: 0.25, opacity: 0.25),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const SizedBox(
                //   height: 10.0,
                // ),
                // SizedBox(
                //   height: 40.0,
                //   width: 250.0,
                //   child: FloatingActionButton.extended(
                //       heroTag: "Matching",
                //       icon: const Icon(Icons.upload_file),
                //       onPressed: uploadMatch,
                //       label: const Text("Macthing")),
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // resMatch == null
                //     ? const Text("Upload Image")
                //     : Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.file(
                //             File(image!.path),
                //             height: 150.0,
                //             width: 150.0,
                //           ),
                //           Image.memory(
                //             resMatch!,
                //             height: 150.0,
                //             width: 150.0,
                //           ),
                //         ],
                //       ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 40.0,
                  width: 250.0,
                  child: FloatingActionButton.extended(
                      heroTag: "Equalize",
                      icon: const Icon(Icons.upload_file),
                      onPressed: uploadEqualize,
                      label: const Text("Equalize")),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resEqualize == null
                    ? const Text("Upload Image")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.file(
                            File(image!.path),
                            height: 150.0,
                            width: 150.0,
                          ),
                          Image.memory(
                            resEqualize!,
                            height: 150.0,
                            width: 150.0,
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
                      heroTag: "Contrast",
                      icon: const Icon(Icons.upload_file),
                      onPressed: uploadContrast,
                      label: const Text("Contrast Enhancement")),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resEnhance == null
                    ? const Text("Upload Image")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.file(
                            File(image!.path),
                            height: 150.0,
                            width: 150.0,
                          ),
                          Image.memory(
                            resEnhance!,
                            height: 150.0,
                            width: 150.0,
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
                      heroTag: "Gamma",
                      icon: const Icon(Icons.upload_file),
                      onPressed: uploadGamma,
                      label: const Text("Gamma Transform")),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resGamma == null
                    ? const Text("Upload Image")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.file(
                            File(image!.path),
                            height: 150.0,
                            width: 150.0,
                          ),
                          Image.memory(
                            resGamma!,
                            height: 150.0,
                            width: 150.0,
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
                      heroTag: "Log",
                      icon: const Icon(Icons.upload_file),
                      onPressed: uploadLog,
                      label: const Text("Log Transform")),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resLog == null
                    ? const Text("Upload Image")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.file(
                            File(image!.path),
                            height: 150.0,
                            width: 150.0,
                          ),
                          Image.memory(
                            resLog!,
                            height: 150.0,
                            width: 150.0,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
