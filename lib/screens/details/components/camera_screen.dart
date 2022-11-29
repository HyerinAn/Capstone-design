
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/constants.dart';

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
    matchMoney();
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
    final regExp = RegExp(r'전화:(\d{3})\)\D(\d{3})\D(\d{4})');
    for( String t in _blocks) {
      Iterable<RegExpMatch> matches = regExp.allMatches(t);
      for (final Match m in matches) {
        String match = m[0]!;
        _text = match;
      }
    }
    print("전화번호 : "+ _text);
    setState(() {});
  }

  matchAddress() {
    _text = '';
    final regExp = RegExp(r'주소:', unicode: true);
    for( String t in _lines) {
      bool matches = regExp.hasMatch(t);
      if(matches){
        _text = t;
      }
    }
    print("주소 : "+ _text);
    setState(() {});
  }
  matchDate() {
    _text = '';
    final regExp = RegExp(r'(\d{4}-\d{2}-\d{2})');
    for( String t in _blocks) {
      Iterable<RegExpMatch> matches = regExp.allMatches(t);
      for (final Match m in matches) {
        String match = m[0]!;
        _text = match;
      }
    }
    print("날짜 : "+ _text);
    setState(() {});
  }

  matchMoney(){
    _text = _blocks.last;
    print("합계 : "+ _text);
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
    );
  }


}
