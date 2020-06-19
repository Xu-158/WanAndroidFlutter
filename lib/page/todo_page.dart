import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/todo_list_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/common/theme.dart';
import 'package:wanandroidflutter/model/todo_list_model.dart';
import 'package:wanandroidflutter/util/sp_util.dart';
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
  Color tColor;

  @override
  void initState() {
    super.initState();
    SPUtil.get(type: String , key: SPUtil.themeColor).then((value) => tColor = themeColorMap[value]);
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
                child: Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
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
                            leading: Icon(Icons.edit,color: tColor,),
                            title: t.status == 1
                                ? Text(
                                    t.title ?? 'title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: tColor.withOpacity(0.5),
                                      fontSize: 18,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.black87,
                                    ),
                                  )
                                : Text(
                                    t.title ?? 'title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: tColor,
                                      fontSize: 18,
                                    ),
                                  ),
                            backgroundColor: tColor.withOpacity(0.2),
                            onExpansionChanged: (value) {},
                            initiallyExpanded: false,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Visibility(
                                      visible: t.content.isNotEmpty,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              width: winWidth ,
                                              child: Theme(
                                                data: ThemeData(
                                                  cardColor: tColor.withOpacity(0.5),
                                                ),
                                                child: Card(
                                                  elevation: 5,
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      t.content ?? '内容',
                                                      maxLines: null,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 2,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '编辑日期：${t.dateStr ?? 'time'}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 2,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              CupertinoSwitch(
                                                trackColor: Colors.grey,
                                                activeColor: tColor,
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
                                            child: Icon(
                                              Icons.edit,
                                              color: tColor,
                                              size: 35,
                                            ),
                                            onTap: () => model.doEdit(
                                                todoId: t.id,
                                                title: t.title,
                                                content: t.content,
                                                isUpdate: true),
                                          ),
                                          InkWell(
                                            child: Icon(Icons.delete_forever,color: tColor, size: 35),
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
