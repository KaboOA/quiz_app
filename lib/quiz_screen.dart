// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz_cubit.dart';
import 'package:quiz_app/cubit/quiz_states.dart';
import 'package:quiz_app/quiz_question_model.dart';
import 'package:slide_countdown/slide_countdown.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  var pageController = PageController();
  Color color = const Color(0xff335ef7);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        var cubit = QuizCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.92),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8.5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => OutlinedButton(
                        onPressed: () {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastEaseInToSlowEaseOut,
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              cubit.stdQuizAnsws!.elementAtOrNull(index) != null
                                  ? color
                                  : Colors.grey[200]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: cubit.stdQuizAnsws!.elementAtOrNull(index) !=
                                    null
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 6.0),
                      itemCount: cubit.quizQuestions.length,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16.0),
                      child: SlideCountdown(
                        duration: const Duration(seconds: 5),
                        onDone: () {
                          print(cubit.getResult());
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: PageView.builder(
                    itemCount: cubit.quizQuestions.length,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      cubit.changeIsState(
                          value == cubit.quizQuestions.length - 1);
                      cubit.changeIsStart(value == 0);
                    },
                    controller: pageController,
                    itemBuilder: (context, index) => BuildQuizItem(
                      cubit: cubit,
                      questionModel: cubit.quizQuestions[index],
                      queIdx: index,
                      length: cubit.quizQuestions.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 16.0,
                    end: 16.0,
                    bottom: 8.0,
                    top: 8.0,
                  ),
                  child: Row(
                    children: [
                      if (!cubit.isStart)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastEaseInToSlowEaseOut,
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(color),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      if (!cubit.isStart) const SizedBox(width: 6.0),
                      Expanded(
                        flex: 4,
                        child: OutlinedButton(
                          onPressed: () {
                            if (cubit.isLast) {
                              // if want to get result and ignore unsolved questions.   => print(cubit.getResult());

                              if (cubit.stdQuizAnsws!.contains(null)) {
                                print(
                                    'question ${cubit.stdQuizAnsws!.indexOf(null) + 1} not answered');
                              } else {
                                print('complete!');
                                print(cubit.getResult());
                              }
                            } else {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastEaseInToSlowEaseOut,
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text(
                            cubit.isLast ? 'Complete' : 'Next',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildQuizItem extends StatelessWidget {
  BuildQuizItem({
    super.key,
    required this.questionModel,
    required this.queIdx,
    required this.length,
    required this.cubit,
  });
  QuizQuestionModel questionModel;
  int length;
  int queIdx;
  Color color = const Color(0xff335ef7);
  QuizCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 3.5,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${queIdx + 1} of ${cubit.quizQuestions.length} Questions',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          questionModel.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              questionModel.imgUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: questionModel.imgUrl!,
                        height: MediaQuery.of(context).size.height / 4,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 12.0,
              ),
              Card(
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, ansIdx) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                      ),
                      child: ListTile(
                        onTap: () {
                          cubit.selectAnswer(queIdx, ansIdx + 1);
                        },
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Text(
                          questionModel.options[ansIdx],
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        trailing: Radio<int>(
                          value: ansIdx + 1,
                          activeColor: color,
                          groupValue:
                              cubit.stdQuizAnsws!.elementAtOrNull(queIdx),
                          onChanged: (value) {
                            cubit.selectAnswer(queIdx, value!);
                          },
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12.0),
                    itemCount: questionModel.options.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
