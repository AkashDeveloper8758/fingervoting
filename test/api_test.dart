import 'package:finger_voting/core/apiClient.dart';
import 'package:finger_voting/repositories/api_calls_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

main() {
  test(
    " get product by subcategory from stream ",
    () async {
//arrange
      bool check = false;
      var apiClient = ApiClient(Client());
      var apiRepo = ApiRepository(apiClient);
      var res = await apiRepo.voteCandidate('ddman', 'cand1');
      print('voting result: $res');
      expect(res, true);
    },
  );
}
