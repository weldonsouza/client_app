import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:client_app/src/core/provider/global_providers.dart';
import 'package:client_app/src/core/route/navigation_service.dart';
import 'package:client_app/src/core/utils/utils.dart';
import 'package:client_app/src/domain/models/service/service_model.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import '../schedule_service/schedule_service_view.dart';

bool titleExpandedContraIndication = false;
bool titleExpandedHowToPrepare = false;
final CarouselController controllerCarouselSlider = CarouselController();

class ServiceProviderController with ChangeNotifier {
  final _serviceEntity = setupLocator.serviceLocatorServiceEntity;

  late ServiceModel service;

  DateTime? joinDateTime;

  DateTime dateNow = DateTime.now();
  List<DateTime> unavailableDates = [];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late List availableHoursInit;
  late List availableHoursEnd;
  late DateTime dateTimeJoin;
  late Duration differenceMinutes;
  late String getServiceId;

  bool isLoading = false;

  bool get getIsLoading => isLoading;

  String get getPriceService => 'Agendar por R\$${formatFraction.format(service.price)}';

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setJoinDateTime(context, DateTime value) {
    joinDateTime = value;

    if (joinDateTime != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScheduleServiceView()),
      );
    }

    notifyListeners();
  }

  setServices(ServiceModel value) {
    service = value;
    
    availableHoursInit = minutesToHoursTime(service.startingTime!);
    availableHoursEnd = minutesToHoursTime(service.endingTime!);

    //Transformar os minutos do fechamento em data
    dateTimeJoin = join(
        DateTime.now(),
        TimeOfDay(
          hour: int.parse(availableHoursEnd[0]),
          minute: int.parse(availableHoursEnd[1]),
        ));

    notifyListeners();
  }

  void init(serviceId, cityId) async {
    setIsLoading(true);
    joinDateTime = null;
    getServiceId = serviceId;
  }

  //Popup do calendario
  void selectDatePicker(context) {
    // Calcular quantas minutos faltam para o encerramento do expediente
    Duration differenceMinutes = dateTimeJoin.difference(dateNow);

    var valueInitDate =
        differenceMinutes.inMinutes > service.maximumDurationService!
            ? DateTime.now()
            : DateTime.now().add(const Duration(days: 1));

    showDatePicker(
      context: context,
      initialDate: valueInitDate,
      firstDate: valueInitDate,
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate != null) {
        selectedDate = pickedDate;

        selectTimePicker(context);
      }
    });
  }

  //Popup da hora
  void selectTimePicker(context) async {
    unavailableDates.clear();
    DateTime dateTimeFormat = DateTime.parse(DateFormat('yyyy-MM-dd').format(dateNow));

    if(service.invalidDates!.isEmpty) {
      unavailableDates.add(DateTime(dateTimeFormat.year, dateTimeFormat.month, dateTimeFormat.day, dateTimeFormat.hour, dateTimeFormat.minute));
    } else {
      for (int i = 0; i < service.invalidDates!.length; i++) {
        DateTime dateTime = DateTime.parse(service.invalidDates![i]);
        unavailableDates.add(DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute));
      }
    }

    // Adicionar o tempo de execução do serviço
    var addServiceTimeInit = unavailableDates[0].add(Duration(minutes: service.maximumDurationService!));

    bool valueMinutesEnd = addServiceTimeInit.minute > 30;

    // Adicionar um dia, caso o agendamento tente ser feito no final do dia anterior
    DateTime dateTime = DateTime.parse(DateFormat('yyyy-MM-dd').format(dateNow.add(const Duration(days: 1))));

    // Calcula a hora inicial do dia + tempo do serviço
    int valueHoursInit = selectedDate == dateTimeFormat
        ? (valueMinutesEnd == true
            ? addServiceTimeInit.hour
            : addServiceTimeInit.hour + 1)
        : (selectedDate == dateTime
            ? (valueMinutesEnd == true
                ? addServiceTimeInit.hour
                : (addServiceTimeInit.hour + 1))
            : int.parse(availableHoursInit[0]));

    // Subtrair o tempo de execução do serviço
    var addServiceTimeEnd = dateTimeJoin
        .subtract(Duration(minutes: service.maximumDurationService!));

    // Calcula hora final do expediente(caso seja para o dia corrente
    int valueHoursEnd = selectedDate == dateTimeFormat
        ? (valueMinutesEnd == true
            ? addServiceTimeInit.hour
            : addServiceTimeInit.hour + 1)
        : int.parse(availableHoursEnd[0]);

    showCustomTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: valueHoursInit,
        minute: int.parse(availableHoursInit[1]),
      ),
      onFailValidation: (context) => NavigationService.showSnackbarMessage('Falha ao selecionar o horario.', false),
      selectableTimePredicate: (pickedTime) =>
          pickedTime!.hour >= valueHoursInit &&
          pickedTime.hour <= valueHoursEnd &&
          pickedTime.minute % 30 == 0,
    ).then((pickedTime) {
      if (pickedTime != null) {
        selectedTime = pickedTime;

        setJoinDateTime(context, join(selectedDate!, selectedTime!));
      }
    });
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  List minutesToHoursTime(int minutes) {
    Duration duration = Duration(minutes: minutes);
    List<String> parts = duration.toString().split(':');
    return parts;
  }
}
