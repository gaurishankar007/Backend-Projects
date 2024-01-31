import 'package:chat/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:chat/features/auth/domain/repositories/auth_repo.dart';

import '../features/auth/presentation/cubit/auth_cubit.dart';

import '../app_data.dart';
import '../config/routes/routes.dart';
import '../core/services/network_service.dart';
import '../core/utils/screen_constraint.dart';
import '../features/global/blocs/theme_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

part "injection.dart";

