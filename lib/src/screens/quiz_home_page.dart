import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quiz/src/bloc.dart';
import 'package:quiz/src/enums.dart';
import 'package:quiz/src/screens.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QuizState();
  }
}

class QuizState extends State<QuizHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
        child: BlocBuilder<GameModeCubit, GameModeCubitState>(
          builder: (BuildContext context, GameModeCubitState? state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  runSpacing: 12.0,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Text('Quiz category:',
                        style: Theme.of(context).textTheme.bodyText1),
                    DropdownButton<String>(
                      style: Theme.of(context).textTheme.bodyText2,
                      isExpanded: true,
                      value: state?.quizCategory?.value,
                      items: QuizCategory.values
                          .toList()
                          .map((QuizCategory category) {
                        return DropdownMenuItem<String>(
                          value: category.value,
                          child: Text(category.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          context.read<GameModeCubit>().updateGameMode(
                                quizCategory: QuizCategory.fromString(value),
                              );
                        });
                      },
                    ),
                    Text(
                      'Quiz difficulty:',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    DropdownButton<String>(
                      style: Theme.of(context).textTheme.bodyText2,
                      isExpanded: true,
                      value: state?.quizDifficulty?.value,
                      items: QuizDifficulty.values
                          .toList()
                          .map((QuizDifficulty difficulty) {
                        return DropdownMenuItem<String>(
                          value: difficulty.value,
                          child: Text(difficulty.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          context.read<GameModeCubit>().updateGameMode(
                                quizDifficulty:
                                    QuizDifficulty.fromString(value),
                              );
                        });
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      final quizListBloc =
                          Provider.of<QuizListBloc>(context, listen: false);
                      quizListBloc.add(
                        QuizListStarted(
                            quizCategory: state?.quizCategory,
                            quizDifficulty: state?.quizDifficulty),
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return MultiProvider(providers: [
                            Provider.value(
                              value: Provider.of<GameModeCubit>(context),
                            ),
                            Provider.value(
                              value: Provider.of<QuizListBloc>(context),
                            ),
                            Provider.value(
                              value: QuizTimeCubit(),
                            ),
                          ], child: const QuizListPage());
                        }),
                      );
                    },
                    child: const Text('Start Quiz'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
