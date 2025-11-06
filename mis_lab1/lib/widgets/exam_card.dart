import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/exam.dart';

class ExamCard extends StatelessWidget{
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    bool isPast = exam.dateTime.isBefore(DateTime.now());

    return Card(
      color: isPast ? Colors.grey : Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.subject,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 18),
                  SizedBox(width: 5),
                  Text(DateFormat('dd.MM.yyyy - HH:mm').format(exam.dateTime)),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on, size: 18),
                  SizedBox(width: 5),
                  Text(exam.rooms.join(',')),
                ],
              )
            ],
          ),
      ),
    );
  }
}