abstract class ModifierStates {}

class InitialModifierStates extends ModifierStates {}

class HiddenPasswordModifierState extends ModifierStates {}

class HiddenPasswordModifierrState extends ModifierStates {}

class HiddenPasswordModifierrrState extends ModifierStates {}

class AjouterImageProfileState extends ModifierStates {}

class AjouterImageProfilecameraState extends ModifierStates {}

class RemovePhotoprofilState extends ModifierStates {}

class AjouterImageProfileClientState extends ModifierStates {}

class AjouterImageProfilecameraClientState extends ModifierStates {}

class RemovePhotoprofilClientState extends ModifierStates {}

class GoodUpdateAgenceInfoState extends ModifierStates {}

class BadUpdateAgenceInfoState extends ModifierStates {}

class GoodUpdateClientInfoState extends ModifierStates {}

class BadUpdateClientInfoState extends ModifierStates {}

class GoodUpdatePasswordAgenceState extends ModifierStates {
  dynamic model;

  GoodUpdatePasswordAgenceState({this.model});
}

class BadUpdatePasswordAgenceState extends ModifierStates {}

class ModifierConditionalLodinState extends ModifierStates {}

class DeletSelectImageState extends ModifierStates {}
