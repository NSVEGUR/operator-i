import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class Filterscreen extends StatefulWidget {
  const Filterscreen({super.key});

  @override
  State<Filterscreen> createState() => _FilterscreenState();
}

class _FilterscreenState extends State<Filterscreen> {
  Uint8List? resLaplacian;
  Uint8List? resGaussain;
  Uint8List? resCannyImage;
  Uint8List? resmeanImage;
  Uint8List? resmedianImage;
  Uint8List? resprewittImage;
  Uint8List? resSobelImage;
  XFile? image;

  Future<int> retCanny({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}filter/canny"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));

    Map<String, String> cannydata = {"threshold1": "50", "threshold2": "100"};

    request.fields.addAll(cannydata);
    request.headers.addAll(headers);
    print("request:${request}");
    final response = await request.send();
    print("response:$response");
    final res = await http.Response.fromStream(response);
    setState(() {
      resCannyImage = res.bodyBytes;
    });
    return response.statusCode;
  }

  uploadCanny() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retCanny(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

    Future<int> retPrewitt({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}filter/prewitt"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));

    Map<String, String> cannydata = {"axis": "X"};

    request.fields.addAll(cannydata);
    request.headers.addAll(headers);
    print("request:${request}");
    final response = await request.send();
    print("response:$response");
    final res = await http.Response.fromStream(response);
    setState(() {
      resprewittImage = res.bodyBytes;
    });
    return response.statusCode;
  }

  uploadPrewitt() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retPrewitt(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

    Future<int> retMean({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}filter/mean"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));

    request.headers.addAll(headers);
    print("request:${request}");
    final response = await request.send();
    print("response:$response");
    final res = await http.Response.fromStream(response);
    setState(() {
      resmeanImage = res.bodyBytes;
    });
    return response.statusCode;
  }

  uploadMean() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retMean(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

    Future<int> retMedian({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}filter/median"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));
    Map<String, String> data = {"a": "3","b":"3"};

    request.fields.addAll(data);
    request.headers.addAll(headers);
    print("request:${request}");
    final response = await request.send();
    print("response:$response");
    final res = await http.Response.fromStream(response);
    setState(() {
      resmedianImage = res.bodyBytes;
    });
    return response.statusCode;
  }

  uploadMedian() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retMedian(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

    Future<int> retSobel({required File file, required String filename}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}filter/sobel"));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: filename));

    Map<String, String> Sobel = {"axis": "X","kernelsize":"3"};

    request.fields.addAll(Sobel);
    request.headers.addAll(headers);
    print("request:${request}");
    final response = await request.send();
    print("response:$response");
    final res = await http.Response.fromStream(response);
    setState(() {
      resSobelImage = res.bodyBytes;
    });
    return response.statusCode;
  }

  uploadSobel() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retSobel(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<int> retLaplacian(
      {required File file, required String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}filter/laplacian"),
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
    Map<String, String> Laplaciandata = {"sign": "P"};

    request.fields.addAll(Laplaciandata);

    request.headers.addAll(headers);
    print("request: $request");
    final resStrem = await request.send();
    final res = await http.Response.fromStream(resStrem);
    setState(() {
      resLaplacian = res.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return resStrem.statusCode;
  }

  uploadLaplacian() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retLaplacian(
          file: pickedImage, filename: pickedImage.path.split("/").last);
    }
  }

  Future<int> retGaussian(
      {required File file, required String filename}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}filter/gaussian"),
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
      resGaussain = gres.bodyBytes;
    });
    //print("This is response:" + resStrem.toString());
    return gres.statusCode;
  }

  uploadGaussian() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File pickedImage = File(image!.path);
      await retGaussian(
          file: pickedImage, filename: pickedImage.path.split("/").last);
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
                image: AssetImage("assets/logo.png"),
                scale: 0.25,
                opacity: 0.25),
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
                      onPressed: uploadGaussian,
                      label: const Text("Gaussian")),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resGaussain == null
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
                            resGaussain!,
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
                      onPressed: uploadLaplacian,
                      label: const Text("Laplacian")),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resLaplacian == null
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
                            resLaplacian!,
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
                    heroTag: "shape",
                    icon: const Icon(Icons.upload_file),
                    onPressed: uploadCanny,
                    label: const Text("Canny"),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resCannyImage == null
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
                            resCannyImage!,
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
                    heroTag: "mean",
                    icon: const Icon(Icons.upload_file),
                    onPressed: uploadMean,
                    label: const Text("Mean"),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resmeanImage == null
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
                            resmeanImage!,
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
                    heroTag: "median",
                    icon: const Icon(Icons.upload_file),
                    onPressed: uploadMedian,
                    label: const Text("Median"),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resmedianImage == null
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
                            resmedianImage!,
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
                    heroTag: "Prewitt",
                    icon: const Icon(Icons.upload_file),
                    onPressed: uploadPrewitt,
                    label: const Text("Prewitt"),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resprewittImage == null
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
                            resprewittImage!,
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
                    heroTag: "Sobel",
                    icon: const Icon(Icons.upload_file),
                    onPressed: uploadSobel,
                    label: const Text("Sobel"),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                resSobelImage == null
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
                            resSobelImage!,
                            height: 150.0,
                            width: 150.0,
                            semanticLabel: "Binary",
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
