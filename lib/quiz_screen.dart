import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedOption;
  static const img =
      'https://imgs.search.brave.com/6Lmmx8qGyWoxiwF6fIB9rWUGA7RA-W8O3XPdKOSzM4U/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9keWwz/NDdoaXd2M2N0LmNs/b3VkZnJvbnQubmV0/L2FwcC91cGxvYWRz/LzIwMjMvMDkvU3Rh/ZGl1bV9WMl8xOTgw/JUUyJTgwJThBJUMz/JTk3JUUyJTgwJThB/MTEyOF9UZXh0LXNj/YWxlZC5qcGc';

  bool hasImg = true;
  Color color = const Color(0xff335ef7);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.92),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    itemCount: 10,
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 3.5,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '5 of 10 Questions',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              'Who is Publisher of Flutter?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    hasImg
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: img,
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
                                'Option ${index + 1}',
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
                          itemCount: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
      ),
    );
  }
}
