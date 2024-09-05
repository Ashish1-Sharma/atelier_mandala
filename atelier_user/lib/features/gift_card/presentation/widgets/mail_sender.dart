import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailSender extends StatefulWidget {
  const MailSender({super.key});

  @override
  State<MailSender> createState() => _MailSenderState();
}

class _MailSenderState extends State<MailSender> {
  final outlookSmtp = hotmail(dotenv.env["OUTLOOK_EMAIL"]!, dotenv.env["OUTLOOK_PASSWORD"]!);

  sendMail() async {
    final message = Message()
      ..from = Address(dotenv.env["OUTLOOK_EMAIL"]!, 'Ashish sharma')
      ..recipients.add('wwwviveksharma45@gmail.com')
      ..subject = 'Test Dart Mailer library :: 😀 '
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, outlookSmtp);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print(e);
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              sendMail();
            }, child: Text("Send email"))
          ],
        ),
      )),
    );
  }
}
