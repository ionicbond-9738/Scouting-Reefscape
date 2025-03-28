// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

// Project imports:
import 'package:scouting_site/services/cast.dart';
import 'package:scouting_site/services/scouting/form_data.dart';
import 'package:scouting_site/services/scouting/form_page_data.dart';
import 'package:scouting_site/services/scouting/helper_methods.dart';
import 'package:scouting_site/services/scouting/question.dart';
import 'package:scouting_site/theme.dart';
import 'package:scouting_site/widgets/avgs_graph.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_image_corousel.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_toggle_switch.dart';

// Package imports:

class TeamOverviewPage extends StatefulWidget {
  final int team;
  final List<FormData> forms;
  final List<FormData> avgs;
  final List<FormData> pitScoutingData;
  final String teamName;

  const TeamOverviewPage(
      {super.key,
      required this.team,
      required this.forms,
      required this.avgs,
      required this.teamName,
      required this.pitScoutingData});

  @override
  State<TeamOverviewPage> createState() => _TeamOverviewPageState();
}

class _TeamOverviewPageState extends State<TeamOverviewPage> {
  Map<String, double> questionAverages = {};
  Map<String, double> selectedTeamQuestionAverages = {};
  Map<String, double> selectedTeamQuestionAnswerAverages = {};
  Map<String, Map<String, bool>> questionSwitchesMap = {};
  Map<String, Map<String, double>> topValues = {};

  double screenWidth = 0;
  Map<String, bool> pagesActive = {};

  List<Uint8List> images = [];
  double maxImageHeight = 0;
  double maxImageWidth = 0;

  @override
  void initState() {
    super.initState();

    calculateQuestionAverages();
    calculateQuestionTopValues();

    for (var page in widget.forms.last.pages) {
      questionSwitchesMap[page.pageName] = {};

      for (var question in page.questions) {
        questionSwitchesMap[page.pageName]?[question.questionText] = true;
      }
    }

    _loadImages();
  }

  void calculateQuestionTopValues() {
    for (FormData form in widget.forms) {
      for (FormPageData page in form.pages) {
        topValues.putIfAbsent(page.pageName, () => {});
        for (Question question in page.questions
            .where((q) => [double, int].contains(q.answer.runtimeType))) {
          double val = question.answer;
          if (!topValues[page.pageName]!.containsKey(question.questionText)) {
            topValues[page.pageName]![question.questionText] = val;
          } else if (topValues[page.pageName]![question.questionText]! < val) {
            topValues[page.pageName]![question.questionText] = val;
          }
        }
      }
    }
  }

  Future<void> _loadImages() async {
    // Fetch images and determine maximum dimensions
    List<Uint8List> loadedImages = [];
    double maxWidth = 0;
    double maxHeight = 0;

    for (var form in widget.pitScoutingData) {
      for (var page in form.pages) {
        for (var question in page.questions) {
          if (question.type == AnswerType.photo && question.answer != "") {
            Uint8List imageBytes = base64Decode(question.answer as String);
            loadedImages.add(imageBytes);

            // Decode image to get dimensions
            final decodedImage = await decodeImageFromList(imageBytes);
            if (decodedImage.width > maxWidth) {
              maxWidth = decodedImage.width.toDouble();
            }
            if (decodedImage.height > maxHeight) {
              maxHeight = decodedImage.height.toDouble();
            }
          }
        }
      }
    }

    // Update state with images and max dimensions
    setState(() {
      images = loadedImages;
      maxImageWidth = 640;
      maxImageHeight = 360;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _handleBackButton,
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back",
          color: GlobalColors.backButtonColor,
        ),
        backgroundColor: GlobalColors.appBarColor,
        title: Text(
          "${widget.teamName} #${widget.team} Overview",
          style: const TextStyle(
            color: GlobalColors.teamColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: GlobalColors.backgroundColor,
          child: Column(
            children: [
              if (widget.pitScoutingData.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getPitScoutingDatatable(widget.pitScoutingData),
                    SizedBox(
                      width: maxImageWidth,
                      height: maxImageHeight,
                      child: ImageCarousel(
                        imageBytesList: images,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 600,
                    width: screenWidth / 3 * 2,
                    child: getTotalScoreGraph(questionSwitchesMap),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 20,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 2),
                  Text("${widget.team}# Score"),
                  const SizedBox(width: 20),
                  Container(
                    height: 10,
                    width: 20,
                    color: Colors.blue.shade200,
                  ),
                  const SizedBox(width: 2),
                  const Text("Avg Global Score"),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getRadialGauges(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Edit Graph Settings"),
              scrollable: true,
              content: SizedBox(
                width: 700,
                height: 700,
                child: Column(
                  children: getQuestionSwitches(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.settings_outlined),
      ),
    );
  }

  List<Widget> getRadialGauges() {
    List<Widget> gauges = [];
    List<Widget> currPageGauges = [];
    String currPage = "";
    int gaugeCount = 0;
    List<Widget> columnGauges = [];

    for (var entry in questionAverages.entries) {
      var split = entry.key.split("_");
      String pageName = split[0];
      String questionText = split.getRange(1, split.length).join("_");

      if (topValues.containsKey(pageName) &&
          topValues[pageName]!.containsKey(questionText)) {
        if (currPage != pageName) {
          if (currPageGauges.isNotEmpty) {
            columnGauges.add(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: currPageGauges,
            ));
            currPageGauges = [];
          }
          if (columnGauges.isNotEmpty) {
            gauges.add(Column(children: columnGauges));
            columnGauges = [];
          }

          currPage = pageName;
          gaugeCount = 0;
          gauges.add(Text(
            pageName,
            textScaler: const TextScaler.linear(1.8),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));
        }

        double start = 0;
        double end = topValues[pageName]![questionText]!;
        if (start == end) end = 10;

        Color percentileColor = getColorByPrecentile(entry.value, end);

        currPageGauges.add(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  RadialGauge(
                    track: RadialTrack(
                      start: start,
                      end: end,
                      hideLabels: false,
                      steps: 1,
                      color: Colors.black,
                      thickness: 40,
                      trackStyle: const TrackStyle(
                        labelStyle: TextStyle(
                          color: GlobalColors.teamColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trackLabelFormater: (double value) {
                        return value.toStringAsFixed(2);
                      },
                    ),
                    valueBar: [
                      RadialValueBar(
                        valueBarThickness: 40,
                        value:
                            selectedTeamQuestionAnswerAverages[entry.key] ?? 0,
                        color: percentileColor,
                      )
                    ],
                  ),
                  Text(
                    (selectedTeamQuestionAnswerAverages[entry.key] ?? 0)
                        .toStringAsFixed(2),
                    style: TextStyle(
                      color: percentileColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaler: const TextScaler.linear(2),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -70),
                child: Text(questionText),
              )
            ],
          ),
        );
        currPageGauges.add(const SizedBox(width: 20));
        gaugeCount++;

        if (gaugeCount >= 4) {
          columnGauges.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: currPageGauges,
          ));
          currPageGauges = [];
          gaugeCount = 0;
        }
      }
    }

    if (currPageGauges.isNotEmpty) {
      columnGauges.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: currPageGauges,
      ));
    }
    if (columnGauges.isNotEmpty) {
      gauges.add(Column(children: columnGauges));
    }

    return gauges;
  }

  Widget getQuestionAveragesWidgets() {
    Column averages = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Averages: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: GlobalColors.teamColor,
          ),
        ),
        const Divider(),
        ...selectedTeamQuestionAnswerAverages.entries.map((entry) {
          String questionName =
              entry.key; // Extract the question text from the key
          double averageValue = entry.value;
          if (questionName.startsWith("__page")) {
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    questionName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    averageValue
                        .toStringAsFixed(2), // Display the average value
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }
        })
      ],
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: averages,
      ),
    );
  }

  void _handleBackButton() {
    Navigator.of(context).pop();
  }

  List<Widget> getQuestionSwitches() {
    List<Widget> questionsToggles = [];

    List<FormData> teamForms = widget.forms
        .where((form) => extractNumber(form.scoutedTeam ?? "") == widget.team)
        .toList();
    double switchesSize = (screenWidth > 500) ? 500 : screenWidth;

    for (var page in teamForms.last.pages) {
      questionsToggles.add(
        Text(
          page.pageName,
          textScaler: const TextScaler.linear(1.6),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      questionsToggles.add(const SizedBox(height: 5));
      for (var question in page.questions) {
        questionsToggles.add(
          SizedBox(
            width: switchesSize,
            height: 40,
            child: DialogToggleSwitch(
              onToggle: (value) {
                setState(() {
                  questionSwitchesMap[page.pageName]?[question.questionText] =
                      value;
                });
              },
              label: question.questionText,
              initialValue: questionSwitchesMap[page.pageName]
                      ?[question.questionText] ??
                  false,
            ),
          ),
        );

        questionsToggles.add(const SizedBox(height: 5));
      }

      questionsToggles.add(const Divider());
    }

    return questionsToggles;
  }

  Widget getTotalScoreGraph(
      Map<String, Map<String, bool>> questionSwitchesMap) {
    Map<int, List<FormData>> gameForms = {};

    for (var form in widget.forms) {
      if (form.game != null) {
        gameForms.putIfAbsent(form.game!, () => []).add(form);
      }
    }

    Map<int, double> avgs = {};
    Map<int, double> teamScores = {};

    for (int game in gameForms.keys) {
      double currentGameSum = 0;
      int numberOfForms = gameForms[game]?.length ?? 0;

      if (numberOfForms > 0) {
        double sameGameScoreSum = 0;
        int sameGameAmount = 0;
        bool addTeamScore = false;
        for (FormData gameForm in gameForms[game] ?? []) {
          double score = 0;
          for (FormPageData page in gameForm.pages) {
            for (Question question in page.questions) {
              if ((questionSwitchesMap[page.pageName]
                      ?[question.questionText]) ??
                  true) {
                score += question.score;
              }
            }
          }

          currentGameSum += score;

          if (extractNumber(gameForm.scoutedTeam ?? "") == widget.team) {
            sameGameScoreSum += score;
            sameGameAmount++;
            addTeamScore = true;
          }
        }

        if (addTeamScore) {
          teamScores[game] =
              (teamScores[game] ?? 0) + sameGameScoreSum / sameGameAmount;
        }

        avgs[game] = currentGameSum / numberOfForms;
      } else {
        avgs[game] = 0;
      }
    }
    double totalAvg = 0;

    avgs.forEach((game, avg) {
      totalAvg += avg;
    });

    totalAvg /= avgs.length;

    List<double> avgValues = avgs.entries
        .map((entry) => double.parse(totalAvg.toStringAsFixed(2)))
        .toList();

    List<double> teamValues = teamScores.entries
        .map((entry) => double.parse(entry.value.toStringAsFixed(2)))
        .toList();

    return AvgsGraph(
        avgSpots: avgValues,
        teamSpots: teamValues,
        games: teamScores.keys.toList(),
        onPointDoubleClicked: (details) {
          if (details.pointIndex != null) {
            FormData form = widget.forms.firstWhere((form) =>
                form.game == teamScores.keys.toList()[details.pointIndex!] &&
                extractNumber(form.scoutedTeam ?? "0000") == widget.team);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                        "${form.scoutedTeam} - Game #${form.game} by ${form.scouter}"),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [...getAnswersWidgetsForDialog(form)],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        });
  }

  List<Widget> getAnswersWidgetsForDialog(FormData form) {
    List<Widget> answersWidgets = [];

    for (FormPageData page in form.pages) {
      answersWidgets.add(Text(
        page.pageName,
        textScaler: const TextScaler.linear(1.5),
      ));
      for (Question question in page.questions) {
        if (question.type != AnswerType.photo) {
          answersWidgets.add(Text(
            "${question.questionText}: ${question.answer}",
            textScaler: const TextScaler.linear(1.2),
          ));
        } else if (question.answer != "") {
          // verify that indeed is picture present
          Uint8List imageBytes = base64Decode(question.answer as String);
          answersWidgets.add(Text(question.questionText));
          answersWidgets.add(SizedBox(
              width: 300, height: 300, child: Image.memory(imageBytes)));
        }
      }
      answersWidgets.add(const Divider());
      answersWidgets.add(const SizedBox(height: 5));
    }

    answersWidgets.add(const SizedBox(height: 5));
    answersWidgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.close_outlined),
            iconSize: 20,
            tooltip: "Close",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return answersWidgets;
  }

  void calculateQuestionAverages() {
    Map<String, List<double>> questionScores = {};
    Map<String, List<double>> selectedTeamQuestionScores = {};
    Map<String, List<dynamic>> selectedTeamQuestionAnswers =
        {}; // To hold the answers for averaging

    // Loop through all forms
    for (FormData form in widget.forms) {
      // Loop through each page in the form
      for (FormPageData page in form.pages) {
        if (extractNumber(form.scoutedTeam ?? "0") == widget.team) {
          selectedTeamQuestionAnswerAverages["__page${page.pageName}"] = 1;
        }
        // Loop through each question on the page
        for (Question question in page.questions) {
          String questionKey = "${page.pageName}_${question.questionText}";

          // Initialize the list for scores if it's the first time encountering the question
          if (!questionScores.containsKey(questionKey)) {
            questionScores[questionKey] = [];
          }
          // Add the score and answer to their respective lists
          questionScores[questionKey]!.add(question.score);

          // Filter for the selected team
          if (extractNumber(form.scoutedTeam ?? "0") == widget.team) {
            if (!selectedTeamQuestionAnswers.containsKey(questionKey)) {
              selectedTeamQuestionAnswers[questionKey] = [];
            }
            if (!selectedTeamQuestionScores.containsKey(questionKey)) {
              selectedTeamQuestionScores[questionKey] = [];
            }
            selectedTeamQuestionScores[questionKey]!.add(question.score);
            selectedTeamQuestionAnswers[questionKey]!.add(question.answer);
          }
        }
      }
    }

    // Calculate the average score for each question
    questionScores.forEach((questionText, scores) {
      double average = scores.reduce((a, b) => a + b) / scores.length;
      questionAverages[questionText] = average;
    });

    // Calculate the average score for each question for the selected team
    selectedTeamQuestionScores.forEach((questionText, scores) {
      double average = scores.reduce((a, b) => a + b) / scores.length;
      selectedTeamQuestionAverages[questionText] = average;
    });

    // Calculate the average answer for each question for the selected team
    selectedTeamQuestionAnswers.forEach((questionText, answers) {
      double averageAnswer = answers.map((answer) {
            if (answer is num) {
              return tryCast(answer, defaultValue: 0.0);
            } else {
              if (answer is bool) {
                return answer ? 1 : 0;
              } else {
                return 0;
              }
            }
          }).reduce((a, b) => a! + b!)! /
          answers.length;

      selectedTeamQuestionAnswerAverages[questionText] = averageAnswer;
    });
  }

  Widget getPitScoutingDatatable(List<FormData> data) {
    return Column(
      children: data.map((form) {
        return TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                        "${form.scoutedTeam} - Game #${form.game} by ${form.scouter}"),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [...getAnswersWidgetsForDialog(form)],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Text("${form.scoutedTeam} by ${form.scouter}"),
        );
      }).toList(),
    );
  }
}
