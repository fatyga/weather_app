import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/viewModels/base_model.dart';
import 'package:weather_app/locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T)? onModelReady;

  const BaseView({super.key, required this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => locator<T>(),
        child: Consumer<T>(builder: widget.builder));
  }
}
