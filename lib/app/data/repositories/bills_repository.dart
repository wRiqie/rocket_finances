import 'package:rocket_finances/app/data/data_sources/bills_data_source.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class BillsRepository {
  Future<DefaultResponseModel<List<BillModel>>> getAllBillsByUserId(String id);
}

class BillsRepositoryImp implements BillsRepository {
  final BillsDataSource _billsDataSource;

  BillsRepositoryImp(this._billsDataSource);

  @override
  Future<DefaultResponseModel<List<BillModel>>> getAllBillsByUserId(String id) {
    return ExecuteService.tryExecuteAsync(
        () => _billsDataSource.getAllBillsByUserId(id));
  }
}
