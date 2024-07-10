import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {

  late PdfControllerPinch pdfControllerPinch;
  int totalPageCount = 0, currentPage = 1;


  void initState(){
    super.initState();
    pdfControllerPinch = PdfControllerPinch(document:PdfDocument.openAsset('assets/animation/pdf.pdf'));
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      // appBar:AppBar(title:Text('Pdf Viewer')),
      body:_buildUi(),
    );
  }

  Widget _buildUi(){
    return SafeArea(
      child: Column(
        children:[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              IconButton(onPressed:(){
                pdfControllerPinch.previousPage(duration:Duration(milliseconds:200), curve:Curves.linear);
              }, icon:Icon(Iconsax.arrow_left_3)),
      
              Text("${currentPage}/${totalPageCount}"),
      
              IconButton(onPressed:(){
                pdfControllerPinch.nextPage(duration:Duration(milliseconds:200), curve:Curves.linear);
              }, icon:Icon(Iconsax.arrow_right4)),
          ],),
          _pdfView(),
        ]
      ),
    );
  }

  Widget _pdfView(){
    return Expanded(
      child:PdfViewPinch(
        onDocumentLoaded:(doc){
          setState(() {
            totalPageCount = doc.pagesCount;
          });
        },
        onPageChanged:(page){
          setState(() {
            currentPage = page;
          });
        },
        scrollDirection:Axis.vertical,
        controller: pdfControllerPinch,
      )
    );
  }

}
