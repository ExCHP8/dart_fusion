part of '../dart_fusion.dart';

/// Making [StatefulWidget] prettier and less boilerplate.
abstract class DStateWidget extends StatefulWidget {
  /// Default constant constructor with one field of [key].
  ///
  /// To use it, you're going to need extending this class
  /// ```dart
  /// class MyClass extends DStateWidget {
  ///   const MyClass({super.key});
  ///
  ///   @override
  ///   Map<String, dynamic> data(DStateValue state){
  ///     return {"controller": TextEditingController()};
  ///   }
  ///
  ///   @override
  ///   void onPreparation(DStateValue state){
  ///     state.value<TextEditingController>('controller').text = 'Loading';
  ///   }
  ///
  ///   @override
  ///   Widget onStart(DStateValue state){
  ///     return TextField(controller: state.value<TextEditingController>('controller'));
  ///   }
  ///
  ///   void onReady(DStateValue state){
  ///      state.value<TextEditingController>('controller').text = 'Loaded';
  ///   }
  ///
  ///   @override
  ///   void onFinish(DStateValue state){
  ///      state.value<TextEditingController>('controller').dispose();
  ///   }
  /// }
  /// ```
  const DStateWidget({super.key});

  /// Overriding [DStateValue.build] inside [createState].
  Widget onStart(DStateValue state);

  /// A map to declare and passing data inside class. This make things cleaner.
  JSON data(DStateValue state) => {"message": "Hello World"};

  /// Overriding [DStateValue.dispose] inside [createState].
  void onFinish(DStateValue state) {}

  /// Overriding [DStateValue.initState] inside [createState].
  void onPreparation(DStateValue state) {}

  ///  Overriding [WidgetsBinding] after [DStateValue.build] has been done.
  void onReady(DStateValue state) {}

  @override
  State<DStateWidget> createState() => DStateValue();
}

/// State child class of [DStateWidget].
class DStateValue extends State<DStateWidget> {
  /// Declare [DStateWidget.data].
  late JSON data = widget.data(this);

  /// Overriding [setState].
  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onReady(this));
    return DStateInherited(value: this, child: widget.onStart(this));
  }

  @override
  void initState() {
    super.initState();
    widget.onPreparation(this);
  }

  @override
  void dispose() {
    widget.onFinish(this);
    super.dispose();
  }
}

/// A scope to pass [DStateValue] data to its descendant.
class DStateInherited extends InheritedWidget {
  /// [DStateValue] data to be passed.
  final DStateValue value;

  /// Default constructor to pass [DStateValue] to its descendant.
  const DStateInherited({
    super.key,
    required this.value,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => oldWidget != this;

  /// A shortcut to call [DStateInherited] from [BuildContext].
  static DStateInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DStateInherited>();
  }
}
