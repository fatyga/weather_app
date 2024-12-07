import 'package:flutter/material.dart';
import 'package:weather_app/core/models/status.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key, required this.status});
  final Status status;

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();

    switch (status.state) {
      case StatusState.fetching:
        widget = Bar(
            leading: const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  strokeWidth: 2,
                )),
            comment: status.comment,
            bgColor: Colors.grey[100]);
        break;
      case StatusState.error:
        widget = Bar(
            onTap: status.action,
            leading: Icon(Icons.error, color: Colors.red, size: 20),
            comment: '${status.comment} Tap to try again',
            bgColor: Colors.red[100]);

        break;
      case StatusState.success:
        widget = Bar(
            onTap: status.action,
            leading: Icon(Icons.done, color: Colors.green, size: 20),
            comment: '${status.comment} Tap to refresh',
            bgColor: Colors.green[100]);

        break;
    }
    return widget;
  }
}

class Bar extends StatelessWidget {
  final Widget leading;
  final String? comment;
  final Color? bgColor;
  final Function()? onTap;

  const Bar(
      {super.key,
      required this.leading,
      this.comment,
      required this.bgColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: bgColor),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            leading,
            const SizedBox(width: 8),
            Text(comment ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))
          ])),
    );
  }
}
