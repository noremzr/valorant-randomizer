import 'package:flutter/material.dart';
import 'dart:ui' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

String viewID = "teste";

class BannerAdUnit extends StatelessWidget {
  const BannerAdUnit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        viewID,
        (int id) => html.IFrameElement()
          ..style.width = '100%'
          ..style.height = '100%'
          ..srcdoc = '''  
        <!DOCTYPE html>  
 <html>
  <head><script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-2292755833088389"
     crossorigin="anonymous"></script> </head>
  <body>      
             


       

  </body>  
 </html>           '''
          ..style.border = 'none');

    return Padding(
      padding: const EdgeInsets.only(top:12.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 10,
        width: MediaQuery.of(context).size.width,
        child: HtmlElementView(
          viewType: viewID,
        ),
      ),
    );
  }
}
