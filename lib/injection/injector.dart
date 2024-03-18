import 'package:chat/core/database/local_database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../initializer.dart';
import '../config/routes/routes.dart';
import '../core/network/network_status.dart';
import '../core/services/user_service.dart';
import '../core/utils/screen_size.dart';
import '../features/auth/data/dataSources/auth_local_data_source.dart';
import '../features/auth/data/dataSources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repo_impl.dart';
import '../features/auth/domain/repositories/auth_repo.dart';
import '../features/global/presentations/blocs/theme_cubit.dart';

part "getters.dart";
part "injection.dart";
