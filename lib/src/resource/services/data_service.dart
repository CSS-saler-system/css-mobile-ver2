import 'package:flutter_application_1/src/resource/response/campaign_response.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/response/enteprise_response.dart';
import 'package:flutter_application_1/src/resource/response/get_sellings_response.dart';
import 'package:flutter_application_1/src/resource/response/login_response.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../response/order_response.dart';

part 'data_service.g.dart';

@RestApi(baseUrl: "https://css-api.azurewebsites.net/api/v3.0/collaborator/")
abstract class DataService {
  factory DataService(Dio dio) = _DataService;

  @POST("login")
  Future<LoginResponse> login(@Query("loginToken") String firebaseToken,
      @Query("registrationToken") String registrationToken);

// CUSTOMER

  @POST('customer/new')
  Future<String> createCustomer(
      @Header("Authorization") String? token, @Body() dynamic request);
  @GET("customer/list")
  Future<List<CustomerData>> getCustomers(
      @Header("Authorization") String? token);

  @GET("customer/get/{customerId}")
  Future<CustomerData> getCustomer(
      @Header("Authorization") String? token, @Path("customerId") String id);

  @PUT("customer/update")
  Future<String> updateCustomer(
      @Header("Authorization") String? token, @Body() dynamic request);

// END CUSTOMER

// PRODUCT

  @GET("product/list")
  Future<ListProductResponse> getProducts(
    // @Header("Authorization") String? token,
    @Query("page_number") int? page,
    @Query("page_size") int? pageSize,
    @Query("status") String? status,
    @Query("pointSale") int? pointSale,
    @Query("price") String? price,
    @Query("inStock") String? inStock,
    @Query("brand") String? brand,
    @Query("productName") String? productName,
  );

  @GET("product/list/{id}")
  Future<ListProductResponse> getEntepriseProducts(
    // @Header("Authorization") String? token,
    @Path("id") String id,
    @Query("pageNumber") int? page,
    @Query("pageSize") int? pageSize,
    @Query("status") String? status,
    @Query("pointSale") int? pointSale,
    @Query("price") String? price,
    @Query("inStock") String? inStock,
    @Query("brand") String? brand,
    @Query("productName") String? productName,
  );

  @GET("product/get/{id}")
  Future<ProductData> getProductDetail(
    @Header("Authorization") String? token,
    @Path("id") String id,
  );

  @POST("request_selling/create")
  Future<String> sellingCreate(
      @Header("Authorization") String? token, @Body() dynamic body);

  @GET("request_selling/get/{accountId}")
  Future<SellingResponse> getSellings(
    @Header("Authorization") String? token,
    @Path("accountId") String accountId,
    @Query("pageNumber") int page,
    @Query("pageSize") int pageSize,
  );

  @GET("campaign/list")
  Future<CapmpaignsResponse> getCampaigns(
      @Header("Authorization") String? token);

  //
  @POST("order/new")
  Future<String> newOrder(
      @Header("Authorization") String? token, @Body() dynamic request);

  @GET("order/list/{collaboratorId}")
  Future<GetOrders> getOrders(
    @Header("Authorization") String? token,
    @Path("collaboratorId") String collaboratorId,
  );

  @GET("order/get/{orderId}")
  Future<OrderObject> getOrderDetail(
    @Header("Authorization") String? token,
    @Path("orderId") String orderId,
  );

  @GET("enterprise/list")
  Future<ListEnteprise> getEnteprise(
    @Query("pageNumber") int page,
    @Query("pageSize") int pageSize,
  );
}
