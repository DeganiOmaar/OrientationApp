
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/robot/modelmessage.dart';

class Robot extends StatefulWidget {
  const Robot({super.key});

  @override
  State<Robot> createState() => _RobotState();
}

class _RobotState extends State<Robot> {
  TextEditingController prompController = TextEditingController();
  static const apiKey = "AIzaSyBMALhUq8MUnSGOTvFyGjQluiXlKKWdr3s";
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);

  final List<ModelMessage> prompt = [];
  bool isTyping = false;

  Future<void> sendMessag() async {
    final message = prompController.text;

    setState(() {
      prompController.clear();
      prompt.add(
        ModelMessage(
          isPrompt: true,
          message: message,
          time: DateTime.now(),
        ),
      );
      isTyping = true; // Show typing indicator
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      prompt.add(
        ModelMessage(
          isPrompt: false,
          message: response.text ?? "",
          time: DateTime.now(),
        ),
      );
      isTyping = false; // Hide typing indicator after receiving response
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: const Text(
          "Notre Robot",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: prompt.length,
                  itemBuilder: (context, index) {
                    final message = prompt[index];
                    return userPrompt(
                        isPrompt: message.isPrompt,
                        message: message.message,
                        date: DateFormat('hh:mm a').format(message.time));
                  })),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: TextField(
                    controller: prompController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Entrer votre question",
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    sendMessag();

                  },
                  child:  CircleAvatar(
                    radius: 29,
                    backgroundColor: Color.fromARGB(255, 136, 172, 244),
                    child: isTyping
                        ?  LoadingAnimationWidget.beat(
       
          size: 40, color: Colors.white,
        )
                        : const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container userPrompt({
    required final bool isPrompt,
    required String message,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10)
          .copyWith(left: isPrompt ? 80 : 15, right: isPrompt ? 15 : 80),
      decoration: BoxDecoration(
        color: isPrompt ? const Color.fromARGB(255, 189, 208, 246) : const Color.fromARGB(255, 235, 238, 244),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isPrompt ? const Radius.circular(20) : Radius.zero,
          bottomRight: isPrompt ?  Radius.zero : const Radius.circular(20) ,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
                fontWeight: isPrompt ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16,
                color: isPrompt ? Colors.black87 : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(
                fontSize: 14, color: isPrompt ? Colors.grey : Colors.grey),
          ),
        ],
      ),
    );
  }
}
