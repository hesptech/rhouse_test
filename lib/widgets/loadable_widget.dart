import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/navigator_config.dart';
import 'package:flutter_black_white/widgets/error_view_widget.dart';

///Widget that displays a loading to load another widget by passing as a parameter a future function
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
              if(mounted) {
                setState(() {
                  loadError = error?.toString();
                  debugPrint(loadError);
                })
              }
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
      return const ErrorViewWidget();
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


loadingDialogShow() {
    return showDialog(
      barrierDismissible: false,
      context: NavigatorConfig.context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: const AlertDialog(
              elevation: 0,
              content: SizedBox(height: 120, child: LoadWidget()),
            ));
      },
    );
  }