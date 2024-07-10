import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatefulWidget {
  final String pdfUrl;

  PdfViewScreen({required this.pdfUrl});

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String _filePath = '';
  bool _isReady = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Stack(
        children: [
          _filePath.isEmpty
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SfPdfViewer.file(
            File(_filePath),
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _isReady = true;
              });
            },
          ),
          _errorMessage.isEmpty
              ? Container()
              : Center(
            child: Text(_errorMessage),
          ),
        ],
      ),
    );
  }

  _loadPdf() async {
    try {
      setState(() {
        _isReady = false;
      });
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/my_file.pdf');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _filePath = file.path;
          _isReady = true;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load PDF';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Error loading PDF: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }
}