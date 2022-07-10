import 'package:flutter/material.dart';

class UserBase {}

class DoLoginEvent extends UserBase {}

class DoRegisterEvent extends UserBase {
  final BuildContext context2;
  DoRegisterEvent(this.context2);
}
