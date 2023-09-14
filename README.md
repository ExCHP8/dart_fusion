<p align="center">
  <img src="https://user-images.githubusercontent.com/45191605/267848544-e316c985-3369-4609-9aa5-6becfdb9bee8.png" alt="Dart Fusion Logo" width="200">
</p>

# Dart Fusion
A library that brings together a harmonious blend of essential tools, utilities, and components designed to supercharge my Dart projects.

## Table of Contents
- [Dart Fusion](#dart-fusion)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Documentation](#documentation)
- [Dart Fusion CLI](#dart-fusion-cli)
  - [Usage](#dart-fusion-cli-usage)
- [D' Annotation](#dannotation)
  - [Key Features](#dannotation-feature)
  - [Usage](#dannotation-usage)
- [D' Behavior](#dbehavior)
  - [Key Features](#dbehavior-features)
  - [Usage](#dbehavior-usage)
- [D' Builder](#dbuilder)
  - [Key Features](#dbuilder-features)
  - [Usage](#dbuilder-usage)
- [D' Button](#dbutton)
  - [Key Features](#dbutton-features)
  - [Usage](#dbutton-usage)
- [D' Extensions](#dextensions)
  - [Key Features](#dextensions-features)
  - [Usage](#dextensions-usage)
- [D' Image](#dimage)
  - [Key Features](#dimage-features)
  - [Usage](#dimage-usage)
- [D' Log](#dlog)
  - [Key Features](#dlog-features)
  - [Usage](#dlog-usage)
- [D' Model](#dmodel)
  - [Key Features](#dmodel-features)
  - [Usage](#dmodel-usage)
- [D' Overlay](#doverlay)
  - [Key Features](#doverlay-features)
  - [Usage](#doverlay-usage)
- [D' Parse](#dparse)
  - [Key Features](#dparse-features)
  - [Usage](#dparse-usage)
- [D' State Widget](#dstate-widget)
  - [Key Features](#dstate-widget-features)
  - [Usage](#dstate-widget-usage)
- [D' Text Area](#dtext-area)
  - [Key Features](#dtext-area-features)
  - [Usage](#dtext-area-usage)
- [D' Typedefs](#dtypedefs)
  - [Key Features](#dtypedefs-features)
  - [Usage](#dtypedefs-usage)
 
## Installation
put this in your pubspec.yaml
```yaml
dependencies:
  appstate_widget:
    git:
      url: https://github.com/Nialixus/dart_fusion.git
      ## Optional with version
      ref: v2.3.0
```

also run this command in terminal
```bash
dart pub global activate --source git https://github.com/Nialixus/dart_fusion.git
```
---

<p align="center">
  <img src="https://github.com/Nialixus/dart_fusion/assets/45191605/88e37aee-5e2d-4589-ae08-59069c936338" alt="Dart Fusion Logo" width="200">
</p>

# Dart Fusion CLI
The Dart Fusion CLI is a command-line tool that provides a set of utilities to simplifies common tasks such as asset generation, model updates, and localization.

## <a name="dart-fusion-cli-usage"></a> Usage
- **Asset Generation** : Easily generate asset classes from asset directories, making it simple to access assets in your Dart project. To scan asset files and generate them into one dart class, run this command
  
  ```bash
  dart run dart_fusion asset
  ```

  And this is the list of available commands.
  | OPTION        | DESCRIPTION                                         |
  | ------------- | --------------------------------------------------- |
  | -i, --input   | Input directory of where assets took place.         |
  |               | default to `assets`                                 |
  | -o, --output  | Output file of generated asset class.               |
  |               | default to `lib/src/assets.dart`                    |
  | -h, --help    | Print this usage information.                       |

- **Model Updates**: Update models by generating toJSON, fromJSON and copyWith based on given annotation. To update these models, run this command
  ```bash
  dart run dart_fusion model
  ```

  And this is the available commands.
  | OPTION         | DESCRIPTION                             |
  | -------------- | --------------------------------------- |
  | -i, --input    | Input directory of the models.          |
  |                | default to `""`                         |
  | -h, --help     | Print this usage information.           |

- **Localization**: Generate localization classes from JSON files, simplifying the process of managing translations in your Dart applications using Lecto API.
  ```bash
  dart run dart_fusion localize --api-key="4Z5H0ZS-QHZM2Z8-NTYP640-38D9RFF"
  ```

  List of the commands
  | OPTION        | DESCRIPTION                                                    |
  | ------------- | -------------------------------------------------------------- |
  | --api-key     | Lecto API key (required)                                       |
  | -i, --input   | Input directory of where the JSON base translation took place. |
  |               | default to `assets/translation/en.json`                        |
  | --from        | Base language used for translation                             |
  |               | default to `en`                                                |
  | --to          | Targeted translation languages                                 |
  |               | default to `["af", "sq", "am", "ar", "hy", "az", "be", "bel", "bn", "bs", "bg", "ca", "ceb", "zh-CN", "zh-TW", "hr", "cs", "da", "nl", "en", "et", "tl", "fi", "fr", "fy", "gl", "ka", "de", "el", "gu", "ht", "ha", "he", "hi", "hu", "is", "ig", "id", "ga", "it", "ja", "kn", "kk", "km", "ko", "lo", "lv", "lt", "lb", "mk", "mg", "ms", "ml", "mr", "mn", "my", "ne", "nb", "no", "or", "ps", "fa", "pl", "pt", "pt-BR", "pt-PT", "pa", "ro", "ru", "gd", "sr", "sd", "si", "sk", "sl", "so", "es", "su", "sw", "sv", "ta", "th", "tr", "uk", "ur", "uz", "vi", "cy", "xh", "yi", "yo", "zu"]`
  | -h, --help    | Print this usage information.                                  |
---


The AppStateWidget library offers a solution to simplify the boilerplate code commonly associated with using StatefulWidget. By providing a clean and efficient approach, it enhances the developer experience. Designed with convenience and simplicity in mind, AppStateWidget streamlines the development process, allowing you to focus on building intuitive user interfaces without getting bogged down by repetitive code.

## Key Features
* Reduce Boilerplate
  With AppStateWidget, you can significantly reduce boilerplate code when working with StatefulWidget. Say goodbye to excessive code blocks and welcome concise, elegant declarations.
* Improved Readability
  By abstracting away common patterns, the library ensures cleaner and more readable code, making it easier to comprehend and maintain your project.
* Easy to Use
  Implementing AppStateWidget is straightforward. Just extend the class, override specific methods like onStart, onPreparation, onFinish, and let the magic happen.
* Data Passing Made Simple
  With a convenient data method, you can easily declare and pass data between the widget and its state, ensuring your data management is both efficient and organized.

## Usage
To use it, you're going to need extending this class like this

```dart
class MyClass extends AppStateWidget {
  const MyClass({super.key});

  @override
  Map<String, dynamic> data(AppStateValue state){
    return {'controller': TextEditingController()};
  }

  @override
  void onPreparation(AppStateValue state){
    state.value<TextEditingController>('controller').text = 'Loading';
  }

  @override
  Widget onStart(AppStateValue state){
    return TextField(controller: state.value<TextEditingController>('controller'));
  }

  void onReady(AppStateValue state){
    state.value<TextEditingController>('controller').text = 'Data Loaded';
  }

  @override
  void onFinish(AppStateValue state){
    state.value<TextEditingController>('controller').dispose();
  }
}
```

and you can also get [AppStateValue] in its child, by calling this

```dart
AppStateInherited.of(context);
```

or get the data in [AppStateValue] with this

```dart
context.value<TextEditingController>("controller");
```

also to cell setState we change it to
```dart
state.update();
```

## Documentation
For dart doc generated document, you can see it in this
[Documentation](https://raw.githack.com/Nialixus/dart_fusion/main/doc/api/index.html "Dart Fusion Documentation")
