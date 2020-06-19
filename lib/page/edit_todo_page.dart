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
  String _today = '2020-06-16';

  @override
  void initState() {
    super.initState();
    if (widget.title != '' && widget.title != null) {
      _viewModel.titleC.text = widget.title;
      _viewModel.contentC.text = widget.content;
    }
    DateTime today = DateTime.now();
    print('${today.year}-${today.month}-${today.day}');
    _today = '${today.year}-${today.month}-${today.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton1(),
        title: Text('TODO', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: InkWell(
                child: Icon(Icons.check_circle_outline, color: Colors.white, size: 28),
                onTap: () => widget.isUpdate
                    ? _viewModel.updateTodo(todoId: widget.todoId, date: _today)
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Card(
                        color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey[350]),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: MyTextField(
                          controller: _viewModel.getTitleC,
                          borderRadius: 2.0,
                          fontSize: 19,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    colors: <Color>[Colors.grey[50], Colors.white, Colors.grey[200]],
                    tileMode: TileMode.clamp,
                  ).createShader(bounds);
                },
                child: Card(
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[350]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(100, 35),
                      topRight: Radius.elliptical(20, 100),
                      bottomLeft: Radius.elliptical(20, 100),
                      bottomRight: Radius.elliptical(100, 50),
                    ),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MyTextField(
                      controller: _viewModel.getContentC,
                      borderRadius: 2.0,
                      fontSize: 19,
                      maxLines: null,
                      height: 450.px,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
