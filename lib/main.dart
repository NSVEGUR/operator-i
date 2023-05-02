import 'dart:async';
import 'screens/filter.dart';
import 'screens/spatial.dart';
import 'package:flutter/material.dart';
import 'screens/geometric.dart';
import 'screens/intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds before navigating to the home page
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Operator I')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your splash screen content here, such as logo or animation
            Image.asset(
              'assets/logo.png',
              height: 50.0,
              width: 50.0,
            ), // Replace with your image asset
            const SizedBox(height: 16),
            const Text(
              'Operator I',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/logo.png', // Replace with your actual image path
              height: 30, // Adjust the height as needed
            ),
            const SizedBox(width: 8), // Add spacing between the image and title
            Text(widget.title),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            const Text('Image', style: TextStyle(fontSize: 24.0)),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Digital Image Processing (DIP) is a mathematical approach to analyze, '
                'transform, and enhance digital images using mathematical algorithms '
                'and techniques. It involves manipulating images to extract relevant '
                'information or enhance certain features by performing operations '
                'like filtering, segmentation, and compression, ultimately resulting '
                'in improved visual quality and more accurate interpretation of the '
                'image content.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              width: 250.0,
              child: FloatingActionButton.extended(
                  heroTag: "interpolation",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Introscreen())));
                  },
                  label: const Text("Change image")),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height:50.0,
              width:250.0,
              child: FloatingActionButton.extended(
                  heroTag: "geometric",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Geometricscreen())));
                  },
                  label: const Text("Geometric")),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              width: 250.0,
              child: FloatingActionButton.extended(
                  heroTag: "Spatial",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SpatialScreen())));
                  },
                  label: const Text("Spatial")),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              width: 250.0,
              child: FloatingActionButton.extended(
                  heroTag: "Filter",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Filterscreen())));
                  },
                  label: const Text("Filters")),
            ),
          ],
        ),
      ),
    );
  }
}
