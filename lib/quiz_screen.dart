// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz_cubit.dart';
import 'package:quiz_app/cubit/quiz_states.dart';
import 'package:quiz_app/quiz_question_model.dart';
import 'package:slide_countdown/slide_countdown.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool isLast = false;
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
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              index % 2 == 0 ? color : Colors.grey[200]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: index % 2 == 0 ? Colors.white : Colors.black,
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
                const Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 16.0),
                      child: SlideCountdown(
                        duration: Duration(hours: 1),
                        icon: Padding(
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
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      if (value == cubit.quizQuestions.length - 1) {
                        isLast = true;
                        setState(() {});
                      } else {
                        isLast = false;
                        setState(() {});
                      }
                    },
                    controller: pageController,
                    itemBuilder: (context, index) => BuildQuizItem(
                      questionModel: cubit.quizQuestions[index],
                      index: index,
                      length: cubit.quizQuestions.length,
                    ),
                    itemCount: cubit.quizQuestions.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 750),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            );
                          },
                          color: Colors.grey[200],
                          child: const Text(
                            'Back',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            if (!isLast) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastEaseInToSlowEaseOut,
                              );
                            }
                          },
                          color: color,
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
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

class BuildQuizItem extends StatefulWidget {
  BuildQuizItem({
    super.key,
    required this.questionModel,
    required this.index,
    required this.length,
  });
  QuizQuestionModel questionModel;
  int length;
  int index;

  @override
  State<BuildQuizItem> createState() => _BuildQuizItemState();
}

class _BuildQuizItemState extends State<BuildQuizItem> {
  Color color = const Color(0xff335ef7);
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        '${widget.index + 1} of ${widget.length} Questions',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        widget.questionModel.title,
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
            widget.questionModel.imgUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.questionModel.imgUrl!,
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
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          selectedOption = index + 1;
                        });
                      },
                      contentPadding: const EdgeInsets.all(8.0),
                      title: Text(
                        widget.questionModel.options[index],
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      trailing: Radio<int>(
                        value: index + 1,
                        activeColor: color,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = index + 1;
                          });
                        },
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12.0),
                  itemCount: widget.questionModel.options.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
