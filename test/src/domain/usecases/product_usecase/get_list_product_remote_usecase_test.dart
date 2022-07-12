import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/domain/repositories/product_repository/product_repository.dart';
import 'package:nanoshop/src/domain/usecases/domain_layer_usecase.dart';
import '../../../core/dummy_data/dummy_product.dart';
import 'get_list_product_remote_usecase_test.mocks.dart';

@GenerateMocks(
  [
    ProductRepository,
  ],
  customMocks: [
    MockSpec<ProductParam>(
      as: #MockProductParam,
      returnNullOnMissingStub: false,
    )
  ],
)
void main() {
  MockProductRepository mockProductRepository = MockProductRepository();
  GetListProductRemoteUsecase usecase =
      GetListProductRemoteUsecase(mockProductRepository);

  DataState<List<Product>> dataSuccess = const DataSuccess(
    data: dummyProducts,
  );

  DataState<List<Product>> dataFailure = DataFailed(
    error: DioError(
      requestOptions: RequestOptions(
        path: '',
      ),
      response: Response(
        requestOptions: RequestOptions(
          path: '',
        ),
        statusCode: 404,
      ),
    ),
  );

  ProductParam productParam = ProductParam(page: 1, limit: 10);

  group(
    'get_list_product_remote_usecase',
    () {
      test(
        'Lấy dữ liệu thành công',
        () async {
          when(mockProductRepository.getListProductRemote(any)).thenAnswer(
            (_) async => dataSuccess,
          );

          final result = await usecase.call(productParam);

          expect(result, dataSuccess);

          verify(mockProductRepository.getListProductRemote(productParam));

          verifyNoMoreInteractions(mockProductRepository);
        },
      );

      test(
        'Lấy dữ liệu thất bại',
            () async {
          when(mockProductRepository.getListProductRemote(any)).thenAnswer(
                (_) async => dataFailure,
          );

          final result = await usecase.call(productParam);

          expect(result, dataFailure);

          verify(mockProductRepository.getListProductRemote(productParam));

          verifyNoMoreInteractions(mockProductRepository);
        },
      );
    },
  );
}
