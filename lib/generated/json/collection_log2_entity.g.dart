import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';


CollectionLog2Entity $CollectionLog2EntityFromJson(Map<String, dynamic> json) {
  final CollectionLog2Entity collectionLog2Entity = CollectionLog2Entity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    collectionLog2Entity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    collectionLog2Entity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    collectionLog2Entity.message = message;
  }
  final List<CollectionLog2Data>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CollectionLog2Data>(e) as CollectionLog2Data)
      .toList();
  if (data != null) {
    collectionLog2Entity.data = data;
  }
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
  if (other != null) {
    collectionLog2Entity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    collectionLog2Entity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    collectionLog2Entity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    collectionLog2Entity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    collectionLog2Entity.hasMorePages = hasMorePages;
  }
  return collectionLog2Entity;
}

Map<String, dynamic> $CollectionLog2EntityToJson(CollectionLog2Entity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['other'] = entity.other?.toJson();
  data['total'] = entity.total;
  data['currentPage'] = entity.currentPage;
  data['perPage'] = entity.perPage;
  data['hasMorePages'] = entity.hasMorePages;
  return data;
}

extension CollectionLog2EntityExtension on CollectionLog2Entity {
  CollectionLog2Entity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<CollectionLog2Data>? data,
    CollectionOrderOther? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return CollectionLog2Entity()
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..message = message ?? this.message
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..total = total ?? this.total
      ..currentPage = currentPage ?? this.currentPage
      ..perPage = perPage ?? this.perPage
      ..hasMorePages = hasMorePages ?? this.hasMorePages;
  }
}

CollectionLog2Data $CollectionLog2DataFromJson(Map<String, dynamic> json) {
  final CollectionLog2Data collectionLog2Data = CollectionLog2Data();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLog2Data.id = id;
  }
  final int? pCollectionOrderId = jsonConvert.convert<int>(
      json['p_collection_order_id']);
  if (pCollectionOrderId != null) {
    collectionLog2Data.pCollectionOrderId = pCollectionOrderId;
  }
  final int? fCat = jsonConvert.convert<int>(json['f_cat']);
  if (fCat != null) {
    collectionLog2Data.fCat = fCat;
  }
  final int? gType = jsonConvert.convert<int>(json['g_type']);
  if (gType != null) {
    collectionLog2Data.gType = gType;
  }
  final String? hPhone = jsonConvert.convert<String>(json['h_phone']);
  if (hPhone != null) {
    collectionLog2Data.hPhone = hPhone;
  }
  final String? jContent = jsonConvert.convert<String>(json['j_content']);
  if (jContent != null) {
    collectionLog2Data.jContent = jContent;
  }
  final String? kPromiseTime = jsonConvert.convert<String>(
      json['k_promise_time']);
  if (kPromiseTime != null) {
    collectionLog2Data.kPromiseTime = kPromiseTime;
  }
  final int? mOverdueDays = jsonConvert.convert<int>(json['m_overdue_days']);
  if (mOverdueDays != null) {
    collectionLog2Data.mOverdueDays = mOverdueDays;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    collectionLog2Data.createdAt = createdAt;
  }
  final CollectionOrderData? aAAAAABLCollectionOrder = jsonConvert.convert<
      CollectionOrderData>(json['a_a_a_a_a_a_b_l_collection_order']);
  if (aAAAAABLCollectionOrder != null) {
    collectionLog2Data.aAAAAABLCollectionOrder = aAAAAABLCollectionOrder;
  }
  return collectionLog2Data;
}

Map<String, dynamic> $CollectionLog2DataToJson(CollectionLog2Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['p_collection_order_id'] = entity.pCollectionOrderId;
  data['f_cat'] = entity.fCat;
  data['g_type'] = entity.gType;
  data['h_phone'] = entity.hPhone;
  data['j_content'] = entity.jContent;
  data['k_promise_time'] = entity.kPromiseTime;
  data['m_overdue_days'] = entity.mOverdueDays;
  data['created_at'] = entity.createdAt;
  data['a_a_a_a_a_a_b_l_collection_order'] =
      entity.aAAAAABLCollectionOrder?.toJson();
  return data;
}

extension CollectionLog2DataExtension on CollectionLog2Data {
  CollectionLog2Data copyWith({
    int? id,
    int? pCollectionOrderId,
    int? fCat,
    int? gType,
    String? hPhone,
    String? jContent,
    String? kPromiseTime,
    int? mOverdueDays,
    String? createdAt,
    CollectionOrderData? aAAAAABLCollectionOrder,
  }) {
    return CollectionLog2Data()
      ..id = id ?? this.id
      ..pCollectionOrderId = pCollectionOrderId ?? this.pCollectionOrderId
      ..fCat = fCat ?? this.fCat
      ..gType = gType ?? this.gType
      ..hPhone = hPhone ?? this.hPhone
      ..jContent = jContent ?? this.jContent
      ..kPromiseTime = kPromiseTime ?? this.kPromiseTime
      ..mOverdueDays = mOverdueDays ?? this.mOverdueDays
      ..createdAt = createdAt ?? this.createdAt
      ..aAAAAABLCollectionOrder = aAAAAABLCollectionOrder ??
          this.aAAAAABLCollectionOrder;
  }
}

CollectionLog2DataAAAAAABLCollectionOrder $CollectionLog2DataAAAAAABLCollectionOrderFromJson(
    Map<String, dynamic> json) {
  final CollectionLog2DataAAAAAABLCollectionOrder collectionLog2DataAAAAAABLCollectionOrder = CollectionLog2DataAAAAAABLCollectionOrder();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLog2DataAAAAAABLCollectionOrder.id = id;
  }
  final int? kStatus = jsonConvert.convert<int>(json['k_status']);
  if (kStatus != null) {
    collectionLog2DataAAAAAABLCollectionOrder.kStatus = kStatus;
  }
  final int? nBorrowAmount = jsonConvert.convert<int>(json['n_borrow_amount']);
  if (nBorrowAmount != null) {
    collectionLog2DataAAAAAABLCollectionOrder.nBorrowAmount = nBorrowAmount;
  }
  final int? oPeriodIndex = jsonConvert.convert<int>(json['o_period_index']);
  if (oPeriodIndex != null) {
    collectionLog2DataAAAAAABLCollectionOrder.oPeriodIndex = oPeriodIndex;
  }
  final String? pExpectRepayTime = jsonConvert.convert<String>(
      json['p_expect_repay_time']);
  if (pExpectRepayTime != null) {
    collectionLog2DataAAAAAABLCollectionOrder.pExpectRepayTime =
        pExpectRepayTime;
  }
  final String? tBorrowSn = jsonConvert.convert<String>(json['t_borrow_sn']);
  if (tBorrowSn != null) {
    collectionLog2DataAAAAAABLCollectionOrder.tBorrowSn = tBorrowSn;
  }
  final String? uPhone = jsonConvert.convert<String>(json['u_phone']);
  if (uPhone != null) {
    collectionLog2DataAAAAAABLCollectionOrder.uPhone = uPhone;
  }
  final String? vName = jsonConvert.convert<String>(json['v_name']);
  if (vName != null) {
    collectionLog2DataAAAAAABLCollectionOrder.vName = vName;
  }
  final String? sFlowOutTime = jsonConvert.convert<String>(
      json['s_flow_out_time']);
  if (sFlowOutTime != null) {
    collectionLog2DataAAAAAABLCollectionOrder.sFlowOutTime = sFlowOutTime;
  }
  final int? aEBorrowCount = jsonConvert.convert<int>(json['a_e_borrow_count']);
  if (aEBorrowCount != null) {
    collectionLog2DataAAAAAABLCollectionOrder.aEBorrowCount = aEBorrowCount;
  }
  final int? aJProductId = jsonConvert.convert<int>(json['a_j_product_id']);
  if (aJProductId != null) {
    collectionLog2DataAAAAAABLCollectionOrder.aJProductId = aJProductId;
  }
  return collectionLog2DataAAAAAABLCollectionOrder;
}

Map<String, dynamic> $CollectionLog2DataAAAAAABLCollectionOrderToJson(
    CollectionLog2DataAAAAAABLCollectionOrder entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['k_status'] = entity.kStatus;
  data['n_borrow_amount'] = entity.nBorrowAmount;
  data['o_period_index'] = entity.oPeriodIndex;
  data['p_expect_repay_time'] = entity.pExpectRepayTime;
  data['t_borrow_sn'] = entity.tBorrowSn;
  data['u_phone'] = entity.uPhone;
  data['v_name'] = entity.vName;
  data['s_flow_out_time'] = entity.sFlowOutTime;
  data['a_e_borrow_count'] = entity.aEBorrowCount;
  data['a_j_product_id'] = entity.aJProductId;
  return data;
}

extension CollectionLog2DataAAAAAABLCollectionOrderExtension on CollectionLog2DataAAAAAABLCollectionOrder {
  CollectionLog2DataAAAAAABLCollectionOrder copyWith({
    int? id,
    int? kStatus,
    int? nBorrowAmount,
    int? oPeriodIndex,
    String? pExpectRepayTime,
    String? tBorrowSn,
    String? uPhone,
    String? vName,
    String? sFlowOutTime,
    int? aEBorrowCount,
    int? aJProductId,
  }) {
    return CollectionLog2DataAAAAAABLCollectionOrder()
      ..id = id ?? this.id
      ..kStatus = kStatus ?? this.kStatus
      ..nBorrowAmount = nBorrowAmount ?? this.nBorrowAmount
      ..oPeriodIndex = oPeriodIndex ?? this.oPeriodIndex
      ..pExpectRepayTime = pExpectRepayTime ?? this.pExpectRepayTime
      ..tBorrowSn = tBorrowSn ?? this.tBorrowSn
      ..uPhone = uPhone ?? this.uPhone
      ..vName = vName ?? this.vName
      ..sFlowOutTime = sFlowOutTime ?? this.sFlowOutTime
      ..aEBorrowCount = aEBorrowCount ?? this.aEBorrowCount
      ..aJProductId = aJProductId ?? this.aJProductId;
  }
}