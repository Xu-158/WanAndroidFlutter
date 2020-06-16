import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/project_tree_model.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';

class ProjectTreeViewModel extends BaseModel {
  List<ProjectTreeModel> projectTreeList = List();

  List<ProjectTreeModel> get getProjectTreeList => projectTreeList;

  void getProjectTreeData(){
    Api.getProjectTree().then((value){
      if (value == null) throw Exception('${value['errorMsg']}');
      value['data'].map((v){
        ProjectTreeModel projectTree = ProjectTreeModel.fromJson(v);
        projectTreeList.add(projectTree);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }
}