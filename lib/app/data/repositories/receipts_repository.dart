import 'package:rocket_finances/app/data/data_sources/receipts_data_source.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/models/receipt_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class ReceiptsRepository {
  Future<DefaultResponseModel<List<ReceiptModel>>> getAllReceiptsByUserId(
      String id);
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
}
