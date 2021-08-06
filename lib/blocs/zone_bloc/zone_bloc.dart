import 'dart:async';

import 'package:kids_care/models/zone.dart';
import 'package:kids_care/services/zone_service.dart';

class ZoneBLoC {
  Stream<List<Zone>> get zoneList async* {
    List<Zone> d = await ZoneService.browse();
    yield d;
  }

  final StreamController<int> _zoneCounter = StreamController<int>();

  Stream<int> get zoneCounter => _zoneCounter.stream;

  ZoneBLoC() {
    zoneList.listen((list) => _zoneCounter.add(list.length));
  }
}
