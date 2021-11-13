import 'package:fad_shee/main.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/base_repository.dart';

class InvoiceRepository extends BaseRepository {
  Future<Result> fetchInvoiceDetails(int invoiceId) async {
    Result result = await getIt.get<ApiService>().invoices.fetchInvoiceDetails(invoiceId);
    return result;
  }

  @override
  clearData() {
    // No stored data to be cleared
  }
}
