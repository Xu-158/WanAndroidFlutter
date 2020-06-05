
import 'package:wanandroidflutter/util/size_util.dart';

String baseUrl= 'https://www.wanandroid.com';

extension IntFit on int{
  double get px{
    return SizeUtil.setPx(this.toDouble());
  }
  double get rpx{
    return SizeUtil.setRpx(this.toDouble());
  }
}

extension Double on double{
  double get px{
    return SizeUtil.setPx(this);
  }

  double get rpx{
    return SizeUtil.setRpx(this);
  }
}