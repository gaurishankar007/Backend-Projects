import 'package:auto_route/auto_route.dart';
import 'package:chat/core/extensions/int_extension.dart';
import '../../../../core/constants/routes_data.dart';
import 'package:flutter/material.dart';

@RoutePage(name: kChatRoute)
class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => SizedBox(height: 10.pHeight),
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
