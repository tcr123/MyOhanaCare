import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:ohana_care/screen/chatbot/custom_text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.msg,
    required this.index,
  }) : super(key: key);
  final String msg;
  final int index;

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     // asymmetric padding
  //     padding: EdgeInsets.fromLTRB(
  //       index == 0 ? 64.0 : 16.0,
  //       4,
  //       index == 0 ? 16.0 : 64.0,
  //       4,
  //     ),
  //     child: Align(
  //       // align the child within the container
  //       alignment: index == 0 ? Alignment.centerRight : Alignment.centerLeft,
  //       child: DecoratedBox(
  //         // chat bubble decoration
  //         decoration: BoxDecoration(
  //           color: index == 0 ? Colors.blue : Colors.grey[300],
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(12),
  //           child: Text(
  //             msg,
  //             //   style: Theme.of(context)
  //             //       .textTheme
  //             //       .bodyText1!
  //             //       .copyWith(color: index == 0 ? Colors.white : Colors.black87),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    margin:
    return Padding(
      padding: EdgeInsets.fromLTRB(
        index == 0 ? 64.0 : 20.0,
        4,
        index == 0 ? 20.0 : 64.0,
        4,
      ),
      child: Column(
        children: [
          Align(
            alignment:
                index == 0 ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: index == 0
                    ? Color.fromARGB(255, 237, 191, 182)
                    : Color.fromARGB(255, 255, 241, 191),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: index == 0
                          ? CustomTextWidget(
                              label: msg,
                            )
                          : AnimatedTextKit(
                              repeatForever: false,
                              isRepeatingAnimation: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                  TyperAnimatedText(
                                    msg.trim(),
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16,
                                    ),
                                  )
                                ])),
                  index == 0
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
