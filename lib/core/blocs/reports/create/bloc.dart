import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/reports/create/state.dart';
import 'package:hellohome/core/models/report.dart';
import 'package:hellohome/core/repositories/reports.dart';

import 'event.dart';

class ReportCreateBloc extends Bloc<ReportAddEvent, ReportCreateState> {
  ReportCreateBloc() : super(ReportAddInitial());

  @override
  Stream<ReportCreateState> mapEventToState(ReportAddEvent event) async* {
    if (event is ReportCreatePressed) {
      yield* _mapReportCreatePressedToState(event.report);
    }
  }

  Stream<ReportCreateState> _mapReportCreatePressedToState(Report report) async*{
    yield ReportCreateLoading();
    try {
      await ReportsRepository.create(report);
      yield ReportCreateSuccess();
    } catch(e) {
      print(e);
      yield ReportCreateError();
    }
  }

}

