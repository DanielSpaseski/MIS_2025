

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab1/models/exam.dart';

import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatelessWidget{
  final List<Exam> exams = [
    Exam(
      subject: 'Мобилни информациски системи',
      dateTime: DateTime(2025, 1, 15, 10, 0),
      rooms: ['Амф1', 'Амф2'],
    ),
    Exam(
      subject: 'Веб програмирање',
      dateTime: DateTime(2025, 1, 20, 12, 0),
      rooms: ['Лаб12'],
    ),
    Exam(
      subject: 'Бази на податоци',
      dateTime: DateTime(2025, 1, 25, 9, 0),
      rooms: ['Амф3', 'Лаб13'],
    ),
    Exam(
      subject: 'Оперативни системи',
      dateTime: DateTime(2025, 2, 1, 11, 0),
      rooms: ['Амф1'],
    ),
    Exam(
      subject: 'Компјутерски мрежи',
      dateTime: DateTime(2025, 2, 5, 14, 0),
      rooms: ['Лаб12', 'Лаб13'],
    ),
    Exam(
      subject: 'Софтверско инженерство',
      dateTime: DateTime(2026, 11, 1, 10, 0),
      rooms: ['Амф2'],
    ),
    Exam(
      subject: 'Вештачка интелигенција',
      dateTime: DateTime(2025, 2, 10, 13, 0),
      rooms: ['Лаб3'],
    ),
    Exam(
      subject: 'Алгоритми и податочни структури',
      dateTime: DateTime(2025, 2, 15, 9, 30),
      rooms: ['Амф1', 'Амф3'],
    ),
    Exam(
      subject: 'Дискретна математика',
      dateTime: DateTime(2026, 10, 28, 11, 0),
      rooms: ['Лаб2'],
    ),
    Exam(
      subject: 'Веројатност и статистика',
      dateTime: DateTime(2025, 2, 20, 10, 0),
      rooms: ['Амф2', 'Лаб3'],
    ),
    Exam(
      subject: 'Напредно програмирање',
      dateTime: DateTime(2025, 12, 25, 15, 0),
      rooms: ['Лаб12', 'Лаб2'],
    ),
    Exam(
      subject: 'Калкулус',
      dateTime: DateTime(2026, 3, 1, 12, 0),
      rooms: ['Амф3'],
    ),
  ];

  ExamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    exams.sort((a,b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: Text("Распоред на испити - 223223"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: exams.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            final exam = exams[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamDetailScreen(exam: exam),
                  ),
                );
              },
              child: ExamCard(exam: exam),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue.shade100,
        child: Padding(
            padding: EdgeInsets.all(15.0),
          child: Text(
              "Вкупно испити: ${exams.length}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}