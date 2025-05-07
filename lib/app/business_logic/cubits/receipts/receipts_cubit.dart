import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_state.dart';
import 'package:rocket_finances/app/data/repositories/receipts_repository.dart';

class ReceiptsCubit extends Cubit<ReceiptsState> {
  final ReceiptsRepository _receiptsRepository;

  ReceiptsCubit(this._receiptsRepository) : super(ReceiptsState());

  void getAllByUserId(String id) async {
    emit(state.copyWith(status: ReceiptsStatus.loading));

    final response = await _receiptsRepository.getAllReceiptsByUserId(id);

    if (response.isSuccess) {
      emit(state.copyWith(
        status: ReceiptsStatus.success,
        receipts: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: ReceiptsStatus.error,
        error: response.error,
      ));
    }
  }
}
