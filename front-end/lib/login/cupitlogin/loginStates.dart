abstract class LoginStates {}

class InitialState extends LoginStates {}

class ConditionalLodinState extends LoginStates {}

class GoodLoginState extends LoginStates {
  final dynamic model;

  GoodLoginState(this.model);
}

class BadLoginState extends LoginStates {}

class HiddenPasswordState extends LoginStates {}

class PutcacheonbordingStates extends LoginStates {}

class SharedSkipState extends LoginStates {}

class RegisterSuccesState extends LoginStates {
  final dynamic model;

  RegisterSuccesState(this.model);
}

class RegisterBadState extends LoginStates {}

class ChangetypeState extends LoginStates {}
