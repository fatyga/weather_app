import 'package:flutter/material.dart';
import 'bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  const BlocProvider({super.key, required this.bloc, required this.child});
  final T bloc;
  final Widget child;

  @override
  BlocProviderState createState() => BlocProviderState<T>();

  static T of<T extends Bloc>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<BlocProvider<T>>()!.bloc;
  }
}

class BlocProviderState<T extends Bloc> extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

// class BlocInheritedWidget<T extends Bloc> extends InheritedWidget {
//   final T bloc;
//   final Widget child;

//   const BlocInheritedWidget({Key? key, required this.bloc, required this.child})
//       : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(Widget oldWidget) => true;
// }
