import 'package:agence/clienthome/cupitSearch/cupitsearch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CupitsearchCubit extends Cubit<CupitsearchStates> {
  CupitsearchCubit() : super(CupitsearchInitial());
  static CupitsearchCubit get(context) => BlocProvider.of(context);
  int toggelindexshearch = 0;

  List<String> type_search = ['Agence', 'Wilaya'];
  void changeToggelIndexSearch(index) {
    toggelindexshearch = index;
    emit(ChangeToggelStates());
  }
}
