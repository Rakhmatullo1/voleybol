import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class PDFViewerScreen extends StatelessWidget {
  static String route = "/pdf";
  final String filePath;

  const PDFViewerScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDF Viewer",
          style: TextStyle(color: accentColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: backGroungColor,
        iconTheme: const IconThemeData(color: accentColor),
      ),
      body: PDFView (
        filePath: filePath,
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String localFilePath = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final fileName = ModalRoute.of(context)!.settings.arguments as String;
    if (!fileName.startsWith("pdf")) {
      _preparePDF2(fileName);
    } else {
      _preparePDF(fileName);
    }
  }

  Future<void> _preparePDF(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/Valeybol.pdf");
    final byteData =
        await DefaultAssetBundle.of(context).load("assets/pdf/$fileName.pdf");
    await file.writeAsBytes(byteData.buffer.asUint8List());
    setState(() {
      localFilePath = file.path;
    });
  }

  Future<void> _preparePDF2(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/Valeybol1.pdf");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localFilePath = file.path;
        });
      } else {
        throw Exception("Failed to download PDF");
      }
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return localFilePath.isEmpty
        ? Scaffold(
            backgroundColor: backGroungColor,
            body: Center(
              child: Card(
                color: accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Ma\'lumot topilmadi.\n Orqaga qaytish',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      )),
                ),
              ),
            ),
          )
        : PDFViewerScreen(filePath: localFilePath);
  }
}
