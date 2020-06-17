import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/todo_list_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/todo_list_model.dart';
import 'package:wanandroidflutter/widget/base/base_Page.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/base/empty_widget.dart';
import 'package:wanandroidflutter/widget/common/back_button.dart';
import 'package:wanandroidflutter/widget/common/easyRefresh_widget.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoListViewModel _viewModel = TodoListViewModel();

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
                child: Icon(Icons.add_circle_outline, size: 28),
                onTap: () => _viewModel.doEdit(),
              ))
        ],
      ),
      body: BasePage<TodoListViewModel>(
        viewModel: _viewModel,
        onFirstLoading: (v) {
          v.getToDoListData();
        },
        builder: (context, model, child) {
          return BaseWidget(
            reqStatus: model.getReqStatus,
            child: RefreshWidget(
              onLoad: () => model.onLoad(),
              onRefresh: () => model.onRefresh(),
              controller: model.getEasyRefreshController,
              child: model.getTodoList.length == 0
                  ? EmptyWidget()
                  : ListView.builder(
                      itemCount: model.getTodoList.length,
                      itemBuilder: (context, index) {
                        TodoListModel t = model.getTodoList[index];
                        return Container(
                          child: ExpansionTile(
                            leading: Icon(Icons.comment),
                            title: t.status == 1
                                ? Text(
                                    t.title ?? 'title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor:Colors.black87,
                                    ),
                                  )
                                : Text(
                                    t.title ?? 'title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                            backgroundColor: themeColor.withOpacity(0.1),
                            onExpansionChanged: (value) {},
                            initiallyExpanded: false,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Visibility(
                                      visible: t.content.isNotEmpty,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              width: winWidth * 0.8,
                                              margin: EdgeInsets.all(10),
                                              child: Card(
                                                color: themeColor,
                                                elevation: 5,
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    t.content ?? '内容',
                                                    maxLines: null,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            t.dateStr ?? 'time',
                                            style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 2,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              CupertinoSwitch(
                                                trackColor: Colors.grey,
                                                activeColor: themeColor,
                                                value: t.status == 1,
                                                onChanged: (v) {
                                                  model.changeStatusTodo(
                                                      todoId: t.id, status: t.status);
                                                  t.status == 1 ? t.status = 0 : t.status = 1;
                                                },
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            child: Icon(Icons.edit, size: 35, color: themeColor),
                                            onTap: () => model.doEdit(
                                                todoId: t.id,
                                                title: t.title,
                                                content: t.content,
                                                isUpdate: true),
                                          ),
                                          InkWell(
                                            child: Icon(Icons.delete_forever,
                                                size: 35, color: themeColor),
                                            onTap: () =>
                                                model.deleteTodo(todoId: t.id, index: index),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
            ),
          );
        },
      ),
    );
  }
}
