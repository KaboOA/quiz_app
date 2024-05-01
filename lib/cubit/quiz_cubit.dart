import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz_states.dart';
import 'package:quiz_app/quiz_question_model.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitState());

  static QuizCubit get(context) => BlocProvider.of(context);

  List<QuizQuestionModel> quizQuestions = [];
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
      emit(QuizGetQuizesSuccessState());
    }).catchError((onError) {
      emit(QuizGetQuizesFailState());
    });
  }
}
