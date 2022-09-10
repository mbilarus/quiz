import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/src/bloc.dart';
import 'package:quiz/src/models.dart';

import '../../quiz_app.dart';
import '../clients.dart';

class QuizResultsPage extends StatelessWidget {
  const QuizResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameMode = Provider.of<GameModeCubit>(context).state;
    final passageTime = Provider.of<QuizTimeCubit>(context).getQuizPassageTime(DateTime.now());
    List<QuizItem> quizItems =
        Provider.of<QuizListBloc>(context).state.quizItems;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Quiz Results',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
        child: Column(children: [
          Expanded(
            child: ListView(
              children: quizItems
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              6.0,
                            ),
                          ),
                          color:
                              item.isAnsweredTrue ? Colors.green : Colors.red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 24.0,
                                child: Text(
                                  (quizItems.indexOf(item) + 1).toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Column(
                                children: [
                                  Text(
                                    item.isAnsweredTrue ? 'Right' : 'Incorrect',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
            child: Column(children: [
              ElevatedButton(
                onPressed: () {
                  QuizStatisticsClient().create(
                      quizItems: quizItems,
                      category: gameMode.quizCategory,
                      difficulty: gameMode.quizDifficulty,
                  passageTime: passageTime);
                  makeRoutePage(context: context, pageRef: const QuizApp());
                },
                child: const Text('Save Results'),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  void makeRoutePage({required BuildContext context, required Widget pageRef}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef),
            (Route<dynamic> route) => false);
  }
}
