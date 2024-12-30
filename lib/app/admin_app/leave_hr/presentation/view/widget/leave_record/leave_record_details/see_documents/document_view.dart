import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imgix_core_dart/url_builder.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../../../../../../utils/api_endpoints.dart';
import '../../../../../../../../../utils/app_string.dart';

class DocumentView extends StatelessWidget {
  final String url;
  const DocumentView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // Check file extension
    if (url.endsWith(".pdf")) {
      print(_urlBuilder(imgKey: url));

      // Handle PDF
      return Scaffold(
        appBar: AppBar(),
        body: PDFView(
          filePath: _urlBuilder(imgKey: url),
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: true,
          pageFling: true,
        ),
      );
    } else if (_isImage(url)) {
      // Handle Image files
      return Scaffold(
        appBar: AppBar(),
        body: PhotoView(
          imageProvider: NetworkImage(_urlBuilder(imgKey: url)),
        ),
      );
    } else {
      // Handle unsupported file types
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("Unsupported file type"),
        ),
      );
    }
  }

  // Check if the file is an image based on extension
  bool _isImage(String url) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
    return imageExtensions.any((ext) => url.toLowerCase().endsWith(ext));
  }
}

String _urlBuilder({required String imgKey}) {
  final client = URLBuilder(
    domain: Api.CDN_DOMAIN,
    shouldUseHttpsByDefault: true,
    defaultSignKey: Api.CDN_KEY,
  );
  final urlPath =
      '${"files"}/${GetStorage().read(AppString.ORGANIZATION_ID)}/$imgKey';
  print("url:: $urlPath");
  return client.createURLString(urlPath);
}
