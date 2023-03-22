import 'dart:developer';
import 'package:ohana_care/model/chat_model.dart';
import 'package:ohana_care/provider/auth_provider.dart';
import 'package:ohana_care/provider/chat_provider.dart';
import 'package:ohana_care/provider/models_provider.dart';
import 'package:ohana_care/screen/chatbot/chat_widget.dart';
import 'package:ohana_care/screen/chatbot/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController _textEditingController;
  late ScrollController scrollController;

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  Future<void> initSpeechState() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (error) => print('onError: $error'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) => setState(() {
          _text = result.recognizedWords;
          _textEditingController.text = _text;
        }),
      );
    }
  }

  late FocusNode focusNode;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    focusNode = FocusNode();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  AuthProvider authProvider = new AuthProvider();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final provider = Provider.of<ModelProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image(
              image: authProvider.getUserData.role == "Husband"
                  ? const AssetImage('assets/male_stitch.png')
                  : const AssetImage('assets/female_stitch.png'),
            ),
          ),
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Stitch-E",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\nAsk Anthing',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                    ),
                  ),
                ]),
          ),
          backgroundColor: Colors.white),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: chatProvider.getchatList.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatProvider.getchatList[index].msg,
                    index: chatProvider.getchatList[index].chatIndex,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Color.fromARGB(255, 41, 41, 41),
                size: 18,
              ),
            ],
            const SizedBox(height: 15),
            Container(
              color: Color.fromARGB(255, 199, 199, 199),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      controller: _textEditingController,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 63, 63, 63)),
                      onSubmitted: (value) async {
                        await sendMessages(
                            provider: provider, chatProvider: chatProvider);
                      },
                      decoration: const InputDecoration.collapsed(
                          hintText: "How can i help you",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        sendMessages(
                            provider: provider, chatProvider: chatProvider);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                  IconButton(
                    onPressed: () {
                      if (_isListening) {
                        _speech.stop();
                        setState(() => _isListening = false);
                      } else {
                        initSpeechState();
                      }
                    },
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void scrollToEnd() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessages({
    required ModelProvider provider,
    required ChatProvider chatProvider,
  }) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomTextWidget(
            label: "You can't send multiple messages.",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomTextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String sendMsg = _textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: sendMsg);
        _textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.botMessage(
        msg: sendMsg,
        modelID: provider.currentModel,
      );
      setState(() {});
    } catch (e) {
      log("error is: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomTextWidget(
          label: e.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollToEnd();
        _isTyping = false;
      });
    }
  }
}
