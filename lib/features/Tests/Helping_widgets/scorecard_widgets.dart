import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';

Widget scoreTable(String Weeknumber, int correctAnswer, int totalquestion,int skippedquestions,int wrongAnswers) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: TColors.primaryBackground,),
      child: Table(
        
        columnWidths: {
          0: FlexColumnWidth(1.0),
          1: FlexColumnWidth(1.0),
        },
        children: [
          
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Batch')),
              ),
              TableCell(
                child: Center(child: Text('JEE-11th')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('correct questions')),
              ),
              TableCell(
                child: Center(child: Text('$correctAnswer')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('skipped questions')),
              ),
              TableCell(
                child: Center(child: Text('$skippedquestions')),
              ),
            ],
          ),
           TableRow(
            children: [
              TableCell(
                child: Center(child: Text('wrong answers')),
              ),
              TableCell(
                child: Center(child: Text('$wrongAnswers')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Total questions')),
              ),
              TableCell(
                child: Center(child: Text('$totalquestion')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Marks Scored')),
              ),
              TableCell(
                child: Center(child: Text('$correctAnswer')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Percentage')),
              ),
              TableCell(
                child: Center(
                    child: Text('${(correctAnswer / totalquestion) * 100}%')),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
