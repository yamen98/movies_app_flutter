enum LoginByEnum {
  password,
  gesturePassword,
  fingerprint,
  faceId,
}

extension LoginByEnumExtension on LoginByEnum {
  int get type {
    switch (this) {
      case LoginByEnum.gesturePassword:
        return 0;
      case LoginByEnum.password:
        return 1;
      case LoginByEnum.fingerprint:
        return 2;
      case LoginByEnum.faceId:
        return 3;
      default:
        return 0;
    }
  }
}
