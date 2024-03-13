import 'package:calendar_scheduler/data/repository/schedule_repository_impl.dart';
import 'package:calendar_scheduler/domain/repository/schedule_repository.dart';
import 'package:calendar_scheduler/domain/usecase/delete_shcedule.dart';
import 'package:calendar_scheduler/domain/usecase/get_all_schedule.dart';
import 'package:calendar_scheduler/domain/usecase/get_schedule_by_color.dart';
import 'package:calendar_scheduler/domain/usecase/get_temporary_delete_schedule.dart';
import 'package:calendar_scheduler/domain/usecase/register_schedule.dart';
import 'package:calendar_scheduler/domain/usecase/temporary_delete_schedule.dart';
import 'package:calendar_scheduler/domain/usecase/update_schedule.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  serviceLocator.registerLazySingleton<ScheduleRepository>(
      () => ScheduleRepositoryImpl());

  final _repository = serviceLocator<ScheduleRepository>();

  //usecases
  serviceLocator.registerLazySingleton<RegisterScheduleUsecase>(
      () => RegisterScheduleUsecase(repository: _repository));
  serviceLocator.registerLazySingleton<UpdateScheduleUsecase>(
      () => UpdateScheduleUsecase(repository: _repository));
  serviceLocator.registerLazySingleton<TemporaryDeleteScheduleUsecase>(
      () => TemporaryDeleteScheduleUsecase(repository: _repository));
  serviceLocator.registerLazySingleton<DeleteScheduleUsecase>(
      () => DeleteScheduleUsecase(repository: _repository));
  serviceLocator.registerLazySingleton<GetAllScheduleUsecase>(
      () => GetAllScheduleUsecase(repository: _repository));
  serviceLocator.registerLazySingleton<GetScheduleByColorUsecase>(
      () => GetScheduleByColorUsecase(repository: _repository));
  serviceLocator.registerLazySingleton<GetTemporaryDeleteScheduleUsecase>(
      () => GetTemporaryDeleteScheduleUsecase(repository: _repository));
}
