import 'package:flutter/material.dart';

import '../models/collection_order_entity.dart';


class UserProvider extends ChangeNotifier {
  CollectionOrderOther? _userEntity = CollectionOrderOther.fromJson({
    "progress": {
      "points": [0, 0.2, 0.4, 0.5, 1],
      "levelProgress": [{
        "level": "",
        "type": 0
      }, {
        "level": 1,
        "type": 1
      }, {
        "level": 2,
        "type": 1
      }, {
        "level": 3,
        "type": 1
      }, {
        "level": 4,
        "type": 1
      }],
      "amountProgress": [{
        "amount": 0,
        "type": 0
      }, {
        "amount": 1200,
        "type": 1
      }, {
        "amount": 3600,
        "type": 1
      }, {
        "amount": 6000,
        "type": 1
      }, {
        "amount": 24000,
        "type": 1
      }],
      "amountProgress2": [0, 60000, 60000, 30000, 150000],
      "currentLevel": 1,
      "nextAmount": 60000,
      "nextLevel": 1,
      "currentKey": 0
    },
    "profile": {
      "a_name": "4\u98de\u817e\u50ac\u6536\u7ec4(\u5185)",
      "b_admin_id": 1,
      "c_collection_agency_id": 92,
      "d_collection_group_id": 22,
      "e_collection_stages": "93",
      "f_status": 1,
      "g_comment": "123",
      "h_collection_ing_order_count": 0,
      "i_today_current_kpi_level": 0,
      "j_today_init_amount": 300000,
      "k_current_new_count": 0,
      "l_current_negotiating_count": 0,
      "m_currrent_promised_count": 0,
      "n_current_broken_count": 0,
      "o_current_refused_count": 0,
      "p_today_current_repay_count": 0,
      "r_today_current_repay_amount": 0,
      "t_today_lv1_commission": 0,
      "u_today_lv2_commission": 0,
      "v_today_lv3_commission": 0,
      "w_today_lv4_commission": 0,
      "a_a_month_lv1_commission": 0,
      "a_b_month_lv2_commission": 0,
      "a_c_month_lv3_commission": 0,
      "a_d_month_lv4_commission": 0,
      "a_e_today_commission_rate": 0.8,
      "a_f_last_call_at": "2025-02-06T16:00:00.000000Z",
      "updated_at": "2025-02-06T16:00:00.000000Z"
    }
  }) as CollectionOrderOther?;
  CollectionOrderOther get userEntity => _userEntity!;

  void setUserEntity(CollectionOrderOther userEntity) {
    if (userEntity.profile?.updatedAt != _userEntity?.profile?.updatedAt ) {
      _userEntity = userEntity;
      notifyListeners();
    }
  }


}
