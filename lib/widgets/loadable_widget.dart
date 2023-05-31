import 'package:flutter/material.dart';

class LoadableWidget<T> extends StatefulWidget {
  final Future<T> Function() loader;
  final Widget Function(BuildContext, T) builder;

  const LoadableWidget({super.key, required this.loader, required this.builder});

  @override
  State<StatefulWidget> createState() => _LoadableWidget<T>();
}

class _LoadableWidget<T> extends State<LoadableWidget<T>> {
  T? state;
  String? loadError;

  @override
  void initState() {
    super.initState();
    widget
        .loader()
        .then((value) => setState(() {
              state = value;
            }))
        .onError((error, stackTrace) => {
              setState(() {
                loadError = error?.toString();
                debugPrint(loadError);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final loaded = state;
    if (loaded != null) {
      return widget.builder(context, loaded);
    }
    final errorMessage = loadError;
    if (errorMessage != null) {
      return Expanded(child: Text(errorMessage));
    }
    return const LoadWidget();
  }
}

class LoadWidget extends StatelessWidget {
  const LoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
      Expanded(child: Container()),
      const CircularProgressIndicator(),
      const Text("Loading"),
      Expanded(child: Container())
    ]));
  }
}
