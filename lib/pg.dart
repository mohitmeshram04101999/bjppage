import 'package:bjppage/NotiFcationPageBjp/notification%20page.dart';
import 'package:bjppage/chat%20page/chatPage.dart';
import 'package:bjppage/exp.dart';
import 'package:bjppage/test.dart';
import 'package:bjppage/testPag.dart';
import 'package:flutter/material.dart';


class PgH extends StatefulWidget {
  const PgH({super.key});

  @override
  State<PgH> createState() => _PgHState();
}

class _PgHState extends State<PgH> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        TestPage(),
        NotificationPage(),
        Exp(),
        ChatPage(),
        TstPage(),

      ],
    );
  }
}
