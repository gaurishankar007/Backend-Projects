import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../features/auth/data/dataSources/auth_local_source.dart';
import '../features/auth/data/dataSources/auth_remote_source.dart';
import '../features/auth/data/repositories/auth_repo_impl.dart';
import '../features/auth/domain/repositories/auth_repo.dart';

import '../app_data.dart';
import '../config/routes/routes.dart';
import '../core/services/network_connection.dart';
import '../core/utils/screen_size.dart';
import '../features/global/presentations/blocs/theme_cubit.dart';

part "injection.dart";
part "getters.dart";
