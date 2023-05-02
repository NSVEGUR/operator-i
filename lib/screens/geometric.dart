import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class Geometricscreen extends StatefulWidget {
  const Geometricscreen({super.key});

  @override
  State<Geometricscreen> createState() => _GeometricscreenState();
}

class _GeometricscreenState extends State<Geometricscreen> {
  Uint8List? resBinImage;
  Uint8List? resGrayImage;
  Uint8List? resReflect;
  int rotateAngle = 90;
  int rotateCenter = 0;
  Uint8List? resRotImage;
  Uint8List? resShearImage;
  XFile? image;

  Future<void> retShape({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}geometric/rotate"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        int rotateAngle = 0;
        int rotateCenter = 0;
        return SimpleDialog(
          title: const Text("Select Rotation and Centre"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter rotation angle"),
                onSubmitted: (value) {
                  rotateAngle = int.parse(value);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, [rotateAngle, rotateCenter]);
              },
              child: Text('Submit'),
            )
          ],
        );
      },
    ).then((values) {
      Map<String, String> rotateData = {
        "angle": values[0].toString(),
      };
      request.fields.addAll(rotateData);

      request.headers.addAll(headers);
      print("request:${request}");
      return request.send();
    }).then((response) async {
      print("response:$response");
      final res = await http.Response.fromStream(response);
      print(res.toString());

      setState(() {
        resRotImage = res.bodyBytes;
      });

      return response.statusCode;
    });
  }

  uploadShape() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);

      await retShape(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<void> retScale({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}geometric/scaling"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        int rotateAngle = 0;
        int rotateCenter = 0;
        return SimpleDialog(
          title: const Text("Select Scale factors"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter X Factor"),
                onSubmitted: (value) {
                  rotateAngle = int.parse(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Y factor"),
                onSubmitted: (value) {
                  rotateCenter = int.parse(value);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, [rotateAngle, rotateCenter]);
              },
              child: Text('Submit'),
            )
          ],
        );
      },
    ).then((values) {
      Map<String, String> rotateData = {
        "scale1": values[0].toString(),
        "scale2": values[1].toString(),
      };
      request.fields.addAll(rotateData);

      request.headers.addAll(headers);
      print("request:${request}");
      return request.send();
    }).then((response) async {
      print("response:$response");
      final res = await http.Response.fromStream(response);
      print(res.toString());

      setState(() {
        resBinImage = res.bodyBytes;
      });

      return response.statusCode;
    });
  }

  uploadScale() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);

      await retScale(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<void> retTranslate(
      {required File file, required String filename}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${baseUrl}geometric/translate"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        int rotateAngle = 0;
        int rotateCenter = 0;
        return SimpleDialog(
          title: const Text("Select Centre"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter X coordinate"),
                onSubmitted: (value) {
                  rotateAngle = int.parse(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Y coordinate"),
                onSubmitted: (value) {
                  rotateCenter = int.parse(value);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, [rotateAngle, rotateCenter]);
              },
              child: Text('Submit'),
            )
          ],
        );
      },
    ).then((values) {
      Map<String, String> rotateData = {
        "x": values[0].toString(),
        "y": values[1].toString(),
      };
      request.fields.addAll(rotateData);

      request.headers.addAll(headers);
      print("request:${request}");
      return request.send();
    }).then((response) async {
      print("response:$response");
      final res = await http.Response.fromStream(response);
      print(res.toString());

      setState(() {
        resGrayImage = res.bodyBytes;
      });

      return response.statusCode;
    });
  }

  uploadTranslate() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);

      await retTranslate(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<void> retShear({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}geometric/shear"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        int rotateAngle = 0;
        int rotateCenter = 0;
        return SimpleDialog(
          title: const Text("Select Centre"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter X coordinate"),
                onSubmitted: (value) {
                  rotateAngle = int.parse(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Y coordinate"),
                onSubmitted: (value) {
                  rotateCenter = int.parse(value);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, [rotateAngle, rotateCenter]);
              },
              child: Text('Submit'),
            )
          ],
        );
      },
    ).then((values) {
      Map<String, String> rotateData = {
        "x": values[0].toString(),
        "y": values[1].toString(),
      };
      request.fields.addAll(rotateData);

      request.headers.addAll(headers);
      print("request:${request}");
      return request.send();
    }).then((response) async {
      print("response:$response");
      final res = await http.Response.fromStream(response);
      print(res.toString());

      setState(() {
        resShearImage = res.bodyBytes;
      });

      return response.statusCode;
    });
  }

  uploadShear() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);

      await retShear(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<int> retReflection(
      {required File file, required String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}geometric/reflect"),
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
      resReflect = res.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return resStrem.statusCode;
  }

  uploadReflection() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retReflection(
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
                    onPressed: uploadTranslate,
                    label: const Text("Translation")),
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
                        ),
                        Image.memory(
                          resGrayImage!,
                          height: 150.0,
                          width: 150.0,
                        ),
                      ],
                    ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              // SizedBox(
              //   height: 40.0,
              //   width: 250.0,
              //   child: FloatingActionButton.extended(
              //       heroTag: "binary",
              //       icon: const Icon(Icons.upload_file),
              //       onPressed: uploadScale,
              //       label: const Text("Scale")),
              // ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              // resBinImage == null
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
              //             resBinImage!,
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
                  heroTag: "shape",
                  icon: const Icon(Icons.upload_file),
                  onPressed: uploadShape,
                  label: const Text("Rotate"),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              resRotImage == null
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
                          resRotImage!,
                          height: 150.0,
                          width: 150.0,
                        ),
                      ],
                    ),
              SizedBox(
                height: 40.0,
                width: 250.0,
                child: FloatingActionButton.extended(
                  heroTag: "shear",
                  icon: const Icon(Icons.upload_file),
                  onPressed: uploadShear,
                  label: const Text("Shear"),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              resShearImage == null
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
                          resShearImage!,
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
                    onPressed: uploadReflection,
                    label: const Text("Reflect")),
              ),
              const SizedBox(
                height: 10.0,
              ),
              resReflect == null
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
                          resReflect!,
                          height: 150.0,
                          width: 150.0,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
