import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quiz/src/bloc.dart';
import 'package:quiz/src/models.dart';
import 'package:quiz/src/screens.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameMode = Provider.of<GameModeCubit>(context).state;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '${gameMode.quizCategory} / ${gameMode.quizDifficulty}',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
        child: BlocBuilder<QuizListBloc, QuizListState>(
          builder: (BuildContext context, QuizListState state) {
            final answersAlphabet = ['a', 'b', 'c', 'd', 'e', 'f'];
            if (state is QuizListStateSuccess) {
              final QuizItem selectedItem =
                  state.quizItems[state.selectedIndex];
              final answers = selectedItem.answers.values.toList()
                ..removeWhere((quizAnswer) => quizAnswer == null);
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 24.0,
                children: [
                  Text(
                    '${state.quizItems.indexOf(selectedItem) + 1}. ${selectedItem.question}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Wrap(
                    runSpacing: 12.0,
                    children: answers
                        .map<ElevatedButton>(
                          (answer) => ElevatedButton(
                            onPressed: () {
                              Provider.of<QuizListBloc>(context, listen: false)
                                  .add(
                                QuizListQuestionAnswered(
                                  answerIndex: answers.indexOf(
                                    answer,
                                  ),
                                ),
                              );
                              if ((state.quizItems.indexOf(selectedItem) + 1) >=
                                  state.quizItems.length) {

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return MultiProvider(providers: [
                                        Provider.value(
                                          value: Provider.of<GameModeCubit>(context),
                                        ),
                                        Provider.value(
                                          value: Provider.of<QuizListBloc>(context),
                                        ),
                                        Provider.value(
                                          value: Provider.of<QuizTimeCubit>(context),
                                        )
                                      ], child: const QuizResultsPage());
                                    },
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '${answersAlphabet[answers.indexOf(answer)]}. $answer',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
