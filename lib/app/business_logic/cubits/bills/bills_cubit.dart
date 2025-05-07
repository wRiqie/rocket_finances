import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/data/repositories/bills_repository.dart';

class BillsCubit extends Cubit<BillsState> {
  final BillsRepository _billsRepository;

  BillsCubit(this._billsRepository) : super(BillsState());

  void getAllByUserId(String id) async {
    emit(state.copyWith(status: BillsStatus.loading));

    final response = await _billsRepository.getAllBillsByUserId(id);

    if (response.isSuccess) {
      emit(state.copyWith(
        status: BillsStatus.success,
        bills: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: BillsStatus.error,
        error: response.error,
      ));
    }
  }
}
