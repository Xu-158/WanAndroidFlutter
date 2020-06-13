import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';

class BasePage<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget child)
      builder;
  final T viewModel;
  final Widget child;
  final Function(T) onFirstLoading;

  BasePage({this.viewModel, this.child, this.builder, this.onFirstLoading});
  @override
  _BasePageState<T> createState() => _BasePageState<T>();
}

class _BasePageState<T extends BaseModel> extends State<BasePage<T>> {
  T viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    if (widget.onFirstLoading != null) {
      widget.onFirstLoading(viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(
        child: widget.child,
        builder: widget.builder,
      ),
    );
  }
}
