class ErrorRegisterAndLoginModel {
  String? message;
  ErrorRegisterAndLoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
