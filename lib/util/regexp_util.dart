// example: Android避坑指南，发现了一个极度不<em class='highlight'>安全</em>的操作
String filterHtml(String value) {
  String result;
  print(value);
  String result1 = new RegExp("<[^>]*>").firstMatch(value).group(0);
  value = value.replaceAll('$result1', '');
  result1 = new RegExp("</[^>]*>").firstMatch(value).group(0);
  result = value.replaceAll('$result1', '');
  print('$value');
  return result;
}
