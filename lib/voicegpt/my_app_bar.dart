import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as prov;
import 'package:ohana_care/provider/auth_provider.dart';
import 'package:ohana_care/provider/chat_provider.dart';
import 'package:ohana_care/provider/models_provider.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final provider = Provider.of<ModelProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return AppBar(
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
        backgroundColor: Colors.white);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
