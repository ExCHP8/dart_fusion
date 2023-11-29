part of '../dart_fusion_flutter.dart';

/// Making [StatefulWidget] prettier and less boilerplate.
abstract class DWidget extends StatefulWidget {
  /// Default constant constructor with one field of [key].
  ///
  /// To use it, you're going to need extending this class
  /// ```dart
  /// class MyClass extends DWidget {
  ///   const MyClass({super.key});
  ///
  ///   @override
  ///   Map<String, dynamic> data(DState state){
  ///     return {"controller": TextEditingController()};
  ///   }
  ///
  ///   @override
  ///   void onPreparation(DState state){
  ///     state.value<TextEditingController>('controller').text = 'Loading';
  ///   }
  ///
  ///   @override
  ///   Widget onStart(DState state){
  ///     return TextField(controller: state.value<TextEditingController>('controller'));
  ///   }
  ///
  ///   void onReady(DState state){
  ///      state.value<TextEditingController>('controller').text = 'Loaded';
  ///   }
  ///
  ///   @override
  ///   void onFinish(DState state){
  ///      state.value<TextEditingController>('controller').dispose();
  ///   }
  /// }
  /// ```
  const DWidget({super.key});

  /// Overriding [DState.build] inside [createState].
  Widget onStart(DState state);

  /// A map to declare and passing data inside class. This make things cleaner.
  JSON data(DState state) => {"message": "Hello World"};

  /// Overriding [DState.dispose] inside [createState].
  void onFinish(DState state) {}

  /// Overriding [DState.initState] inside [createState].
  void onPreparation(DState state) {}

  ///  Overriding [WidgetsBinding] after [DState.build] has been done.
  void onReady(DState state) {}

  @override
  State<DWidget> createState() => DState();
}

/// State child class of [DWidget].
class DState extends State<DWidget> {
  /// Declare [DWidget.data].
  late JSON data = widget.data(this);

  /// Overriding [setState].
  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onReady(this));
    return DInherited(value: this, child: widget.onStart(this));
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

/// A scope to pass [DState] data to its descendant.
class DInherited extends InheritedWidget {
  /// [DState] data to be passed.
  final DState value;

  /// Default constructor to pass [DState] to its descendant.
  const DInherited({
    super.key,
    required this.value,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget != this;

  /// A shortcut to call [DInherited] from [BuildContext].
  static DInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DInherited>();
  }
}
