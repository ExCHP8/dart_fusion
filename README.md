# AppStateWidget
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

## Installation
put this in your pubspec.yaml
```yaml
dependencies:
  appstate_widget:
    git:
      url: https://github.com/Nialixus/appstate_widget.git
      ref: v1.4.0
```

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

## Documentation
[AppStateWidget Dart Documentation](https://raw.githack.com/Nialixus/Appstate-Widget/main/doc/api/index.html "AppStateWidget Documentation")