import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import 'DropdownButtonLang.dart';
import 'InitApp.dart';

// available languages
List<String> totalLangs = [
  "Arabic",
  "Bengali",
  "Bulgarian",
  "Czech",
  "Dutch",
  "English",
  "Esperanto",
  "French",
  "German",
  "Greek",
  "Gujarati",
  "Hawaiian",
  "Hindi",
  "Hungarian",
  "Irish",
  "Italian",
  "Japanese",
  "Kannada",
  "Korean",
  "Latin",
  "Malayalam",
  "Marathi",
  "Myanmar",
  "Nepali",
  "Persian",
  "Polish",
  "Punjabi",
  "Russian",
  "Sindhi",
  "Spanish",
  "Swedish",
  "Tamil",
  "Telugu",
  "Ukrainian",
  "Urdu",
  "Vietnamese",
  "Welsh",
  "Xhosa",
  "Yiddish",
  "Zulu"
];

var langMap = {
  'Arabic': 'ar',
  'Bengali': 'bn',
  'Bulgarian': 'bg',
  "Czech": "cs",
  "Dutch": "nl",
  "English": "en",
  "Esperanto": "eo",
  "French": "fr",
  "German": "ka",
  "Greek": "el",
  "Gujarati": "gu",
  "Hawaiian": "haw",
  "Hindi": "hi",
  "Hungarian": "hu",
  "Irish": "ga",
  "Italian": "it",
  "Japanese": "ja",
  "Kannada": "kn",
  "Korean": "ko",
  "Latin": "la",
  "Malayalam": "ml",
  "Marathi": "mr",
  "Myanmar": "my",
  "Nepali": "ne",
  "Persian": "fa",
  "Polish": "pl",
  "Punjabi": "pa",
  "Russian": "ru",
  "Sindhi": "sd",
  "Spanish": "es",
  "Swedish": "sv",
  "Tamil": "ta",
  "Telugu": "te",
  "Ukrainian": "uk",
  "Urdu": "ur",
  "Vietnamese": "vi",
  "Welsh": "cy",
  "Xhosa": "xh",
  "Yiddish": "yi",
  "Zulu": "zu"
};

final translator = GoogleTranslator();
var chosenLang = "en";
String translatedText = "";

class TranslatePage extends StatefulWidget {
  String scannedText;

  TranslatePage({super.key, required this.scannedText});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'ReadAloud',
          style: TextStyle(
            fontFamily: 'Hubballi-Regular',
            fontSize: 28.0,
            color: Color.fromRGBO(255, 189, 66, 1),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Text('Captured Text',
                  style: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(255, 190, 70, 1))),
              // const SizedBox(height: 20.0),
              if (widget.scannedText != "")
                Container(
                  height: 250,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      SelectableText(
                        widget.scannedText,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white.withOpacity(0.6)),
                        showCursor: true,
                        cursorColor: Colors.grey[200],
                        cursorRadius: const Radius.circular(6),
                        scrollPhysics: const ClampingScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              if (widget.scannedText == "")
                Text('No text detected..\n',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 18, color: Colors.white.withOpacity(0.4))),

              DropdownButtonLang(widget.scannedText),
              const SizedBox(height: 20),
              TransText(scannedText: widget.scannedText),
            ],
          ),
        ),
      ),
    );
  }

}



class TransText extends StatefulWidget {
  String scannedText;
  TransText({super.key, required this.scannedText});

  @override
  State<TransText> createState() => _TransTextState();
}

class _TransTextState extends State<TransText> {

  String translated_text = "";

  TextEditingController scannedTextController = TextEditingController();
  String scnTxt = "";

  void translate(String text) async
  {
    Translation translation = await translator.translate(widget.scannedText);
    String lanCode = translation.sourceLanguage.code;
    print("Detected language" + lanCode);
  
    await translator.translate(widget.scannedText, from: lanCode, to: chosenLang).then((output) {
      setState(() {
        translated_text = output.toString();
        print(translated_text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(15),
              side: const BorderSide(width: 1, color: Color.fromRGBO(255, 189, 66, 1)),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              shadowColor: const Color.fromRGBO(255, 189, 66, 1),
            ),
            onPressed: () {
              translate(widget.scannedText);
            },
            child: const Text("Translate",
                style: TextStyle(
                    color: Color.fromRGBO(255, 189, 66, 1),
                    fontSize: 18.0)),
          ),
        ),
        const SizedBox(height: 50),

        Container(
          height: 250,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              SelectableText(
                translated_text,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(0.6)),
                showCursor: true,
                cursorColor: Colors.grey[200],
                cursorRadius: const Radius.circular(6),
                scrollPhysics: const ClampingScrollPhysics(),
              ),
            ],
          ),
        ),
      ],
    );
  }

}