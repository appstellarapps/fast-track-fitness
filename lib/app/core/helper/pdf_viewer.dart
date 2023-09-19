import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer(this.url, this.title) : super();

  final String url;
  final String title;

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, name) async {
    var fileName = '';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  void requestPersmission() async {
    // await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  @override
  void initState() {
    requestPersmission();
    getFileFromUrl(widget.url, widget.title).then(
      (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return SafeArea(
        child: Scaffold(
          body: PDFView(
            filePath: urlPDFPath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              //Show some error message or UI
            },
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                _pdfViewController = vc;
              });
            },
            onPageError: (page, e) {},
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage > 0) {
                      _currentPage--;
                      _pdfViewController.setPage(_currentPage);
                    }
                  });
                },
              ),
              Text(
                "${_currentPage + 1}/$_totalPages",
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage < _totalPages - 1) {
                      _currentPage++;
                      _pdfViewController.setPage(_currentPage);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      if (exists) {
        return SafeArea(
          child: Scaffold(
            appBar: ScaffoldAppBar.appBar(title: widget.title),
            body: const Center(
              child: Text(
                "Loading..",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      } else {
        return SafeArea(
          child: Scaffold(
            appBar: ScaffoldAppBar.appBar(title: widget.title),
            body: const Center(
              child: Text(
                "PDF Not Available.",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      }
    }
  }
}
