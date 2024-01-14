import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/user/user_model.dart';

class SharedData {
  static DateFormat dateFormat = DateFormat('d MMM', 'id_ID');
  static ValueNotifier<UserModel?> userData = ValueNotifier(null);
  static String defaultAvatar = 'https://robohash.org/Jeanne.png?set=set4';
}