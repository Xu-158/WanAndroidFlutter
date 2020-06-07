import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/widget/base_model.dart';

class BaseWidget<T extends BaseModel> extends StatefulWidget {

  final Widget Function(BuildContext context, T viewModel, Widget child) builder;
  final T viewModel;
  final Widget child;
  final Function(T) onLoading;

  BaseWidget({this.viewModel, this.child, this.builder,this.onLoading});
  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseModel> extends State<BaseWidget<T>> {
  T viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    if(widget.onLoading!=null){
      widget.onLoading(viewModel);
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
