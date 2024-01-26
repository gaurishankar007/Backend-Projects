import 'package:auto_route/auto_route.dart';
import '../../../../core/constants/routes_data.dart';
import 'package:flutter/material.dart';

@RoutePage(name: chatsR)
class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
