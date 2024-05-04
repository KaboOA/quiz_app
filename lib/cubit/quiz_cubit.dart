import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz_states.dart';
import 'package:quiz_app/quiz_question_model.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitState());

  static QuizCubit get(context) => BlocProvider.of(context);

  List<QuizQuestionModel> quizQuestions = [];
  List<int?>? stdQuizAnsws;
  void getQuestions() {
    emit(QuizGetQuizesLoadingState());

    FirebaseFirestore.instance
        .collection('data')
        .doc('quizes')
        .collection('quiz1')
        .get()
        .then((value) {
      for (var element in value.docs) {
        quizQuestions.add(QuizQuestionModel.fromJson(element.data()));
      }
      stdQuizAnsws = List<int?>.filled(quizQuestions.length, null);
      emit(QuizGetQuizesSuccessState());
    }).catchError((onError) {
      emit(QuizGetQuizesFailState());
    });
  }

  void selectAnswer(int queIdx, int ansIdx) {
    stdQuizAnsws![queIdx] = ansIdx;

    emit(QuizSelectAnswerState());
  }

  bool isLast = false;
  void changeIsState(bool isLastt) {
    isLast = isLastt;
    emit(QuizCheckIsLastState());
  }

  bool isStart = true;
  void changeIsStart(bool isStartt) {
    isStart = isStartt;
    emit(QuizCheckIsStartState());
  }

  String getResult() {
    int score = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (stdQuizAnsws![i] == quizQuestions[i].ansIdx) {
        score++;
      }
    }

    return score.toString();
  }
}
