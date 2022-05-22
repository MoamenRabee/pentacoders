import 'package:pentacoders/modules/login/login_screen.dart';
import 'package:pentacoders/shared/components/components.dart';
import 'package:pentacoders/shared/network/local/cach_helper.dart';

void logOut(context)async {
  await CacheHelper.removeData("uId");
  NavigateOff(context, LoginScreen());
}
