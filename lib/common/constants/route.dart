abstract class EndPoints {
  EndPoints._();

  static const baseUrl = "https://api.unsplash.com/photos/client_id=zgMzFufnbj0PUIURafyHfa5fPo5X8VG23tQHv7kHFlw";


  static const auth = _Auth();


}

class _Auth {
  const _Auth();

  final login = 'login-res';
  final forgotPassword = 'forgot-password-res';
}




