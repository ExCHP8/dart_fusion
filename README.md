# AppStateWidget
Making `StatefulWidget` prettier and less boilerplate.

## Installation
put this in your pubspec.yaml
```yaml
dependencies:
  appstate_widget:
    git:
      url: https://github.com/Nialixus/Appstate-Widget.git
```

## Usage
To use it, you're going to need extending this class like this

```dart
class MyClass extends AppStateWidget {
    const MyClass({super.key});

    @override
    Map<String, dynamic> data(AppStateValue state){
    return {"controller": TextEditingController()};
    }

    @override
    void onPreparation(AppStateValue state){
    state.data['controller'].text = 'Loading';
    }

    @override
    Widget onStart(AppStateValue state){
    return TextField(controller: state.data['controller']);
    }

    void onReady(AppStateValue state){
    state.data['controller'].text = 'Loaded';
    }

    @override
    void onFinish(AppStateValue state){
    state.data['controller'].dispose();
    }
}
```

## Documentation
[Dart generated doc](https://github.com/Nialixus/Appstate-Widget/tree/main/doc/api/index.html "AppStateWidget Documentation")