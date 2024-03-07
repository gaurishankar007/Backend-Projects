import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/routes_data.dart';
import '../../../../widgets/preferred_size_app_bar.dart';
import '../../../dashboard/presentation/widgets/dashboard_app_bar.dart';

@RoutePage(name: kChatRoute)
class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSizeAppBar(appBar: DashboardAppBar(title: "Chats")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.maxFinite,
            ),
            Text("Chats"),
          ],
        ),
      ),
    );
  }
}
