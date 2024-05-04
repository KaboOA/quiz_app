abstract class QuizState {}

class QuizInitState extends QuizState {}

class QuizGetQuizesLoadingState extends QuizState {}

class QuizGetQuizesSuccessState extends QuizState {}

class QuizGetQuizesFailState extends QuizState {}

class QuizSelectAnswerState extends QuizState {}

class QuizCheckIsLastState extends QuizState {}

class QuizCheckIsStartState extends QuizState {}
