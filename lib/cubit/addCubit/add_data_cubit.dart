import 'package:bloc/bloc.dart';
import 'package:cashy_app/models/finance_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'add_data_state.dart';

class AddDataCubit extends Cubit<AddDataState> {
  AddDataCubit() : super(AddDataInitial());

  addData(FinanceModel financeModel) async {
    emit(AddDataLoading());

    try {
      await Hive.box<FinanceModel>('financeBox').add(financeModel);
      emit(AddDataSuccess());
    } catch (e) {
      emit(AddDataFailure());
    }
  }
}
