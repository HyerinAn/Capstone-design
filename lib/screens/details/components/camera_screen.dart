
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/screens/details/components/camera_screen_information.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}


class _CameraScreenState extends State<CameraScreen> {

  bool _scanning = false;
  String _extractText = '';
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  Information information = Information();

  getImage(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        _scanning = true;
        _pickedImage = pickedImage;
        setState(() {});
        getRecognisedText(_pickedImage!);
      }
    } catch (e) {
      _scanning = false;
      _pickedImage = null;
      setState(() {});
      _extractText = "Error occured while scannning";
    }
  }

  getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    //String text = recognizedText.text;
    textRecognizer.close();

    _extractText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        _extractText = _extractText + line.text+ " ";
        //_extractText = _extractText + line.text+ "\n";
      }
    }
    _scanning = false;

    //=========================================
    getBlock(recognizedText);
    getLine(recognizedText);
    getElement(recognizedText);

    matchPhoneNumber();
    matchAddress();
    matchDate();
    //matchMoney();
    matchProductName();
    //=========================================
    setState(() {});
  }


  //===========================================================
  String _text = '';
  List<String> _blocks = []; List<String> _lines = []; List<String> _elements = [];

  printText(List<String> text){ //String List 출력용
    _text = '';
    for (int i = 0; i < text.length; i++){
      _text = _text + '${i+1} : ${text[i]} \n';
    }
    print(_text);
  }

  getBlock(RecognizedText recognizedText){
    _blocks = [];
    for (TextBlock block in recognizedText.blocks) {
      _blocks.add(block.text);
    }
    //printText(_blocks);  // <- 실행창에 출력
    setState(() {});
  }

  getLine(RecognizedText recognizedText){
    _lines = [];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        _lines.add(line.text);
      }
    }
    printText(_lines); // <- 실행창에 출력
    setState(() {});
  }

  getElement(RecognizedText recognizedText){
    _elements = [];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements){
          _elements.add(element.text);
        }
      }
    }
    //printText(_elements); // <- 실행창에 출력
    setState(() {});
  }

  matchPhoneNumber() {
    _text = '';
    final regExp = RegExp(r'전?화?번?호?\s{0,}:?\s{0,}0(2|51|53|32|62|42|52|44|31|33|43|41|63|61|54|55|64)\D{0,}(\d{3})\D{0,}(\d{4})');
    //final regExp = RegExp(r'전?화?\s{0,}:?\s{0,}0[2-6][1-5](\s|-){0,}(\d{3})(\s|-){0,}(\d{4})');
    //final regExp1 = RegExp(r'0(\d{1,2})\D?(\d{3})\D?(\d{4})');
    for( String t in _lines) {
      Iterable<RegExpMatch> matches = regExp.allMatches(t);
      for (final Match m in matches) {
        String match = m[0]!;
        _text = match;
      }
      if(_text != '') break;
    }
    information.phonenumber = _text;
    print(information.phonenumber);
    setState(() {});
  }

  matchAddress() {
    _text = '';
    final regExp = RegExp(r'주소\s?:?');
    final regExp1 = RegExp(r'(주|수)?소?\s?:?[ㄱ-ㅎ가-힣]{1,}시');
    //final regExp = RegExp(r'[지-짛][시-싷](:| :)', unicode: true);
    for( String t in _lines) {
      bool matches = regExp.hasMatch(t);
      bool matches1 = regExp1.hasMatch(t);
      if(matches||matches1){
        _text += t;
        break;
      }
    }
    information.address = _text;
    print(information.address);
    setState(() {});
  }

  matchDate() {
    _text = '';
    //final regExp = RegExp(r'(\d{4}-\d{2}-\d{2})');
    final regExp = RegExp(r'(20\d{2}\D{0,}\d{2}\D{0,}\d{2})');
    final regExp1 = RegExp(r'(판매일:\d{2}-\d{2}-\d{2})');
    for( String t in _lines) {
      Iterable<RegExpMatch> matches = regExp.allMatches(t);
      if (matches.length==0) matches = regExp1.allMatches(t);
      for (final Match m in matches) {
        String match = m[0]!;
        _text = match;
      }
      if(_text != '') break;
    }
    information.date = _text;
    print(information.date);
    setState(() {});
  }

  // matchDate() {
  //   _text = '';
  //   final regExp = RegExp(r'(\d{4})');
  //   for( String t in _lines) {
  //     bool matches = regExp.hasMatch(t);
  //     if(matches){
  //       _text = t;
  //       break;
  //     }
  //   }
  //   print("날짜 : "+ _text);
  //   setState(() {});
  // }

  // matchMoney(){
  //   _text = _blocks.last;
  //   print("합계 : "+ _text);
  //   setState(() {});
  // }

  matchProductName(){
    List<String> ProductName = [];
    //final regExp_start = RegExp('상품명');
    //final regExp_start = RegExp('[사-싷][파-핗][마-밓]');
    final regExp_start = RegExp(r'[사-싷]?[가-힣][마-밓]$');
    //final regExp_start1 = RegExp(r'(20\d{2}\D{0,}\d{2}\D{0,}\d{2})');
    final regExp_start1 = RegExp(r'주소\s?:?');
    final regExp_start2 = RegExp(r'(주|수)?소\s?:?[ㄱ-ㅎ가-힣]{1,}시');
    final regExp_start3 = RegExp(r'(Pos|계산원)');
    final regExp = RegExp(r'[0-9|\s]{5,}[0-9]$');
    final regExp1 = RegExp(r'[ㄱ-ㅎ가-힣]');
    final regExp2 = RegExp(r'0(\d{2}) ');
    final regExp3 = RegExp(r'001 ');

    final regExp_end1 = RegExp('단가');
    final regExp_end2 = RegExp('수량');

    for (int i = 0; i<_lines.length; i++){
      bool match = regExp3.hasMatch(_lines[i]);
      if(match){
        while(i<_lines.length) {
          if (regExp1.hasMatch(_lines[i])&&regExp2.hasMatch(_lines[i])){ ProductName.add(_lines[i]);}
          i++;
        }
      }
    }

    if(ProductName.length==0) {
      for (int i = 0; i<_lines.length; i++){
        bool matches_start = regExp_start.hasMatch(_lines[i]);
        bool matches_start1 = regExp_start1.hasMatch(_lines[i]);
        bool matches_start2 = regExp_start2.hasMatch(_lines[i]);
        bool matches_start3 = regExp_start3.hasMatch(_lines[i]);

        if(matches_start||matches_start1||matches_start2||matches_start3){
          while(true){
            i++;
            bool matches = regExp.hasMatch(_lines[i]);
            bool matches_end1 = regExp_end1.hasMatch(_lines[i]);
            bool matches_end2 = regExp_end2.hasMatch(_lines[i]);
            if(matches){
              bool matches1 = regExp1.hasMatch(_lines[i-1]);
              if(matches1) ProductName.add(_lines[i-1]);
            }
            if(matches_end1||matches_end2||(i==_lines.length-1)){
              break;
            }
          }
        }
      }
    }
    information.products = ProductName;
    print("=============================");
    if(information.products.length>0) printText(information.products);
    setState(() {});
  }
  //===========================================================


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text('Google Text Recognition'),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_scanning) const CircularProgressIndicator(),
                if (!_scanning && _pickedImage == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (_pickedImage != null) Image.file(File(_pickedImage!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            shadowColor: kPrimaryColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            shadowColor: kPrimaryColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    _extractText,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: kPrimaryColor,
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CameraScreenInformation(information)
              ));
        },
      ),

    );
  }


}

class Information{
  String address = '';
  String date = '';
  String phonenumber = '';
  List<String> products = [];
}
