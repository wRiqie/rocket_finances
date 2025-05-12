import 'package:rocket_finances/app/data/data_sources/receipts_data_source.dart';
import 'package:rocket_finances/app/data/models/commands/receipt/receipt_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/receipt/receipt_update_command.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/models/receipt_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class ReceiptsRepository {
  Future<DefaultResponseModel<List<ReceiptModel>>> getAllReceiptsByUserId(
      String id);

  Future<DefaultResponseModel<void>> addReceipt(ReceiptAddCommand command);

  Future<DefaultResponseModel<void>> updateReceipt(
      ReceiptUpdateCommand command);

  Future<DefaultResponseModel<void>> deleteReceiptById(int id);
}

class ReceiptsRepositoryImp extends ReceiptsRepository {
  final ReceiptsDataSource _receiptsDataSource;

  ReceiptsRepositoryImp(this._receiptsDataSource);

  @override
  Future<DefaultResponseModel<List<ReceiptModel>>> getAllReceiptsByUserId(
      String id) {
    return ExecuteService.tryExecuteAsync(
        () => _receiptsDataSource.getAllReceiptsByUserId(id));
  }

  @override
  Future<DefaultResponseModel<void>> addReceipt(ReceiptAddCommand command) {
    return ExecuteService.tryExecuteAsync(
        () => _receiptsDataSource.addReceipt(command));
  }

  @override
  Future<DefaultResponseModel<void>> deleteReceiptById(int id) {
    return ExecuteService.tryExecuteAsync(
        () => _receiptsDataSource.deleteReceiptById(id));
  }

  @override
  Future<DefaultResponseModel<void>> updateReceipt(
      ReceiptUpdateCommand command) {
    return ExecuteService.tryExecuteAsync(
        () => _receiptsDataSource.updateReceipt(command));
  }
}
