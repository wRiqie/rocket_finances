import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_update_command.dart';
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

  void addBill(BillAddCommand command) async {
    emit(state.copyWith(status: BillsStatus.loading));

    final response = await _billsRepository.addBill(command);

    if (response.isSuccess) {
      emit(state.copyWith(status: BillsStatus.success));
    } else {
      emit(state.copyWith(
        status: BillsStatus.error,
        error: response.error,
      ));
    }
  }

  void updateBill(BillUpdateCommand command) async {
    emit(state.copyWith(status: BillsStatus.loading));

    final response = await _billsRepository.updateBill(command);

    if (response.isSuccess) {
      emit(state.copyWith(status: BillsStatus.success));
    } else {
      emit(state.copyWith(
        status: BillsStatus.error,
        error: response.error,
      ));
    }
  }

  void deleteBillById(int id, bool isRecurring) async {
    emit(state.copyWith(status: BillsStatus.loading));

    final response = await _billsRepository.deleteBillById(id, isRecurring);

    if (response.isSuccess) {
      emit(state.copyWith(status: BillsStatus.deleted));
    } else {
      emit(state.copyWith(
        status: BillsStatus.error,
        error: response.error,
      ));
    }
  }

  void deleteBillMonthById(int id) async {
    emit(state.copyWith(status: BillsStatus.loading));

    final response = await _billsRepository.deleteBillMonthById(id);

    if (response.isSuccess) {
      emit(state.copyWith(status: BillsStatus.deleted));
    } else {
      emit(state.copyWith(
        status: BillsStatus.error,
        error: response.error,
      ));
    }
  }

  void payBill(int id, double value) async {
    emit(state.copyWith(status: BillsStatus.loading));

    final response = await _billsRepository.payBillById(id, value);

    if (response.isSuccess) {
      emit(state.copyWith(status: BillsStatus.paid));
    } else {
      emit(state.copyWith(
        status: BillsStatus.error,
        error: response.error,
      ));
    }
  }
}
