import 'package:rocket_finances/app/data/data_sources/bills_data_source.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_update_command.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class BillsRepository {
  Future<DefaultResponseModel<List<BillModel>>> getAllBillsByUserId(String id);

  Future<DefaultResponseModel<void>> addBill(BillAddCommand command);

  Future<DefaultResponseModel<void>> updateBill(BillUpdateCommand command);

  Future<DefaultResponseModel<void>> deleteBillById(int id, bool isRecurring);

  Future<DefaultResponseModel<void>> deleteBillMonthById(int id);

  Future<DefaultResponseModel<void>> payBillById(int id, double value);
}

class BillsRepositoryImp implements BillsRepository {
  final BillsDataSource _billsDataSource;

  BillsRepositoryImp(this._billsDataSource);

  @override
  Future<DefaultResponseModel<List<BillModel>>> getAllBillsByUserId(String id) {
    return ExecuteService.tryExecuteAsync(
        () => _billsDataSource.getAllBillsByUserId(id));
  }

  @override
  Future<DefaultResponseModel<void>> addBill(BillAddCommand command) {
    return ExecuteService.tryExecuteAsync(
        () => _billsDataSource.addBill(command));
  }

  @override
  Future<DefaultResponseModel<void>> deleteBillById(int id, bool isRecurring) {
    return ExecuteService.tryExecuteAsync(
        () => _billsDataSource.deleteBillById(id, isRecurring));
  }

  @override
  Future<DefaultResponseModel<void>> deleteBillMonthById(int id) {
    return ExecuteService.tryExecuteAsync(
        () => _billsDataSource.deleteBillMonthById(id));
  }

  @override
  Future<DefaultResponseModel<void>> updateBill(BillUpdateCommand command) {
    return ExecuteService.tryExecuteAsync(
        () => _billsDataSource.updateBill(command));
  }

  @override
  Future<DefaultResponseModel<void>> payBillById(int id, double value) {
    return ExecuteService.tryExecuteAsync(
        () => _billsDataSource.payBillById(id, value));
  }
}
