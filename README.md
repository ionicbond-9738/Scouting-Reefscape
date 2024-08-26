# Scouting Site

> A base scouting site for FTC / FRC (Or any competition alike) teams.

# Getting Started
First off, fork this repository by pressing the [`Fork`](https://github.com/DanPeled/Scouting-Tool/fork) button located on the top of this repository page.

## Requirements:
1. [Dart](https://dart.dev/get-dart) & [Flutter](https://docs.flutter.dev/get-started/install) installed (Recommeneded, not neccessary).
2. [Git](https://git-scm.com/) installed (or modify from github, but less recommended).
3. A [Firebase](https://firebase.google.com/) project with a [Firestore Database](https://firebase.google.com/docs/firestore) & the `web` option configured.

## Setting up custom question & pages
Go to the [`lib/services/scouting/scouting.dart`](https://github.com/DanPeled/Scouting-Tool/blob/master/lib/services/scouting/scouting.dart) file and modify the `pages` `List<FormPageData>` located at the top of the class. 

e.g : 
```dart
static final List<FormPageData> _pages = [
    FormPageData(
      pageName: "Autonomous",
      questions: [
        Question(
          type: AnswerType.text,
          questionText: "Notes amount",
          evaluation: 2,
        ),
        Question(
          type: AnswerType.dropdown,
          questionText: "Start position",
          options: [
            "Top",
            "Middle",
          ],
          evaluation: {
            "Top": 1,
            "Middle": 2,
          },
        ),
        Question(
          type: AnswerType.checkbox,
          questionText: "Autonomous?",
          evaluation: 5,
        ),
        Question(
          type: AnswerType.multipleChoice,
          options: [
            "Yes",
            "No",
            "Brocolli",
          ],
          questionText: "How many?",
          evaluation: {
            "Yes": 1,
            "No": 3,
            "Brocolli": 4,
          },
        ),
        Question(
          type: AnswerType.number,
          questionText: "Your opinion about canibalism",
          evaluation: 12,
        ),
        Question(
          type: AnswerType.counter,
          questionText: "Did they do it?",
          options: [
            0, // initial
            0, // min
          ],
          evaluation: 2,
        ),
      ],
    ),
  ];
  ```
## Setting up auto match getting (from [The Blue Alliance](https://www.thebluealliance.com/))
In order to get all of the matches for your competition:
1. Modify the `lib/generate_matches_json.dart` file to use your TBA API Key here:
```dart
  const String tbaAPIKey =
      "<APIKEY>"; // example value, replace to use in your own project
```
2. run the 
```bash
dart run lib/generate_matches_json.dart
``` 
command in your cli, and the matches.json file will be downloaded into your project

# Using the search functionality
On the `Summation` and `Averages` pages, exists a search bar that allows to search for specific entries in a simple way.
E.g If im looking for any team that has a score of 12 on the `autonomous` page, ill enter `autonomous:12`.

Or if im looking for all the entries of team `9738` from game # `12` ill do `team:9738, game:12`.  

## Supported Search Keys
|   Name    | Search key |
|  -------- |  --------  |
| Team (number only) | `team` |
| Game | `game` |
| Scouter | `scouter` |
| Total Score | `score` |
| Form Page | `pageName` |

* this list can be extended through the `handleSearchQuery` function on the [`lib/services/scouting/helper_methods.dart`](https://github.com/DanPeled/Scouting-Tool/blob/master/lib/services/scouting/helper_methods.dart) file
# Documentation
...

# Deploying to github pages
## Bash Script Deployment:
In the root folder, run the `gh-deploy.sh` file in order to push onto the `ghpages` branch in your repository.
In order to make it work:
- Your root folder will **have** to be linked to a git repository remote
- Modify the `gh-deploy.sh` commands to either include or disclude the `<base href="/">` on your code (Discluded by default)

## Manual Deployment:
In order to deploy to `GitHub Pages`, you will need to do the following steps:
1. Run the `flutter build web --web-renderer html` command in the root folder of your project.
2. In the `build/web/index.html` file, remove the line that says : `<base href="/">` (IF YOU WONT REMOVE THIS LINE, YOUR WEBSITE **WILL NOT WORK** ON DEFAULT)
3. Push the `build/web` dir's content into a GitHub repo / branch and enable github pages to it.
