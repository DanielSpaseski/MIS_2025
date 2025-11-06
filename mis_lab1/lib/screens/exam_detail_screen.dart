import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamDetailScreen extends StatelessWidget{
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  String getTimeDiff(){
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    final days = diff.inDays;
    final hours = diff.inHours % 24;

    if(diff.isNegative){
      return "Испитот поминал";
    }

    return "$days дена, $hours часа";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(exam.subject)),
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Предмет: ${exam.subject}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Датум: ${DateFormat('dd.MM.yyyy - HH:mm').format(exam.dateTime)}"),
                SizedBox(height: 10),
                Text("Простории: ${exam.rooms.join(',')}"),
                SizedBox(height: 10),
                Text("Време до испитот: ${getTimeDiff()}",
                      style: TextStyle(fontSize: 15, color: Colors.blueAccent))
              ],
            ),),
    );
  }
}