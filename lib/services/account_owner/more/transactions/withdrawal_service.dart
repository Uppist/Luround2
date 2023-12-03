import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';







class WithdrawalService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
}