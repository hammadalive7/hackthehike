import 'package:flutter/material.dart';
import 'package:hackthehike/models/question_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import '../common/boxes.dart';
import '../controllers/QRScreen_controller.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);
  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final ansController = TextEditingController();
  final qrController = Get.put(QRcontroller());
  GlobalKey _key = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  String qrText = "";
  int score = 10;
  //form key
  final _formKey = GlobalKey<FormState>();

  var timeSinceEpoch = DateTime.now().millisecondsSinceEpoch;
  var time = DateTime.now();

  final box = Boxes.getBoxes();
  final answerbox = Hive.box('answer');

  List<Question> list = [
    Question(
        question: 'Write "Air University"',
        option1: "Ali",
        option2: "Alii",
        option3: "Aliii",
        option4: "Aliiii"),
    Question(
        question: "My name is?",
        option1: "Ali",
        option2: "Alii",
        option3: "Aliii",
        option4: "Aliiii"),
    Question(
        question: "Window is product of? ",
        option1: "Hammad Ali",
        option2: "Microsoft",
        option3: "Air Uni",
        option4: "Uganda"),
  ];

  @override
  void initState() {
    super.initState();

    if (box.isEmpty) {
      for (int i = 0; i < list.length; i++) {
        box.add(list[i]);
        print(box.length);
      }
    } else {
      print(box.length);
    }
  }

  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        qrController.result = event;
      });
    });
  }

  //dispose the controller
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text("SCAN QR CODE",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff000000),
                      )),
                ),
                // LottieBuilder.asset(
                //   "assets/qr-scanner.json",
                //   height: height * 0.2,
                //   fit: BoxFit.fitHeight,
                // ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                        height: height * 0.3,
                        width: height * 0.3,
                        child: QRView(
                          key: _key,
                          onQRViewCreated: qr,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                qrController.result != null
                    ? qrController.getQuestion()
                    : const Text(
                        "No Question",
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                //////////////////
                // Text(box.length.toString()),
                //calling getOptions() function
                getOptions(),

                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Obx(() {
                    return Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: ansController,
                        enabled: qrController.questionBoxEnabled.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter answer";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          labelText: "Enter Answer",
                          hintText: "Enter Answer",
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(
                  height: height * 0.05,
                  width: width * 0.5,
                  child: ElevatedButton(
                    onPressed: (){

                      //validate the form
                      if (_formKey.currentState!.validate()) {
                        // storing the ans with the question in score box
                        // checking if the question is already answered then dont add it to the score box
                        if (answerbox.containsKey(qrController.result!.code)) {
                          Get.snackbar("Already Answered",
                              "You have already answered this question",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 2));
                        } else {
                          // if the question is not answered then add it to the score box
                          answerbox.put(
                              qrController.result!.code, ansController.text + "_" + time.toString());
                          // print(answerbox.length);
                          Get.snackbar("Answer Submitted",
                              "Your answer is submitted successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 2));
                        }

                        //clear the textfield
                        ansController.clear();

                      }

                    },
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  getOptions() {
    if (qrController.result != null) {
      bool question_matched = false;
      for (int i = 0; i < box.length; i++) {
        // question_matched = false;
        if (qrController.result!.code == box.getAt(i)!.question.toString()) {
          question_matched = true;

          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("- ${box.getAt(i)!.option1}"),
                SizedBox(
                  height: 5,
                ),
                Text("- ${box.getAt(i)!.option2}"),
                SizedBox(
                  height: 5,
                ),
                Text("- ${box.getAt(i)!.option3}"),
                SizedBox(
                  height: 5,
                ),
                Text("- ${box.getAt(i)!.option4}"),
              ],
            ),
          );
        } else {
          continue;
        }
      }
      if (!question_matched) {
        return Text("You have scanned wrong QR code");
      }
    } else
      return Text("No Option yet");
  }
}
