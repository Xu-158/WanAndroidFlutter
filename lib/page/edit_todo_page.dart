import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/edit_todo_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/widget/common/back_button.dart';
import 'package:wanandroidflutter/widget/common/text_field_widget.dart';

class EditTodoPage extends StatefulWidget {
  final title;
  final content;
  final todoId;
  final isUpdate;

  const EditTodoPage({Key key, this.title, this.content, this.todoId, this.isUpdate})
      : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  EditTodoViewModel _viewModel = EditTodoViewModel();
  var date = '2020-06-16';

  @override
  void initState() {
    super.initState();
    if (widget.title != '' && widget.title != null) {
      _viewModel.titleC.text = widget.title;
      _viewModel.contentC.text = widget.content;
    }
//    todo date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton1(),
        title: Text('TODO'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: InkWell(
                child: Icon(Icons.check_circle_outline, size: 28),
                onTap: () => widget.isUpdate
                    ? _viewModel.updateTodo(todoId: widget.todoId,date:date)
                    : _viewModel.release(),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: winWidth,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '标题：',
                    style: TextStyle(fontSize: 17),
                  ),
                  MyTextField(
                    controller: _viewModel.getTitleC,
                    width: winWidth * 0.7.px,
                    borderRadius: 2.0,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: themeColor)),
                child: MyTextField(
                  controller: _viewModel.getContentC,
                  fontSize: 19,
                  width: winWidth * 0.85.px,
                  borderRadius: 10.0,
                  maxLines: null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
