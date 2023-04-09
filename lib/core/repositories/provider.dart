import 'package:flutter/material.dart';
import 'package:weather_app/core/repositories/repository.dart';

class RepositoryProvider<T extends Repository> extends StatefulWidget {
  const RepositoryProvider(
      {super.key, required this.repository, required this.child});
  final T repository;
  final Widget child;

  @override
  RepositoryProviderState createState() => RepositoryProviderState();

  static T of<T extends Repository>(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<RepositoryProvider<T>>()!
        .repository;
  }
}

class RepositoryProviderState extends State<RepositoryProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.repository.dispose();
    super.dispose();
  }
}

// class RepositoryInheritedWidget<T extends Repository> extends InheritedWidget {
//   final T repository;
//   final Widget child;

//   const RepositoryInheritedWidget(
//       {Key? key, required this.repository, required this.child})
//       : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(Widget oldWidget) => true;
// }
