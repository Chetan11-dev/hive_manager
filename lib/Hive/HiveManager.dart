import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveManager {
  static Box _currentlyOpendBox;

  static Future instantiate([String toBeOpendBox]) async {
    Hive.init(
      (await getApplicationDocumentsDirectory()).path,
    );

    if (toBeOpendBox != null) {
      await openNewBox(toBeOpendBox);
    }
  }

  static Future openNewBox(String toBeOpendBox) async {
    if (_currentlyOpendBox != null) {
      _currentlyOpendBox.close();
    }

    //MEANS YOU ARE OPENING SECOND BOX SO CLOSE FIRST ONE
    _currentlyOpendBox = await Hive.openBox(toBeOpendBox);
  }

  static E getValue<E>(dynamic key, {E defaultvalue}) {
    return _currentlyOpendBox.get(key, defaultValue: defaultvalue) as E;
  }

  static Future put(dynamic key, dynamic value) =>
      _currentlyOpendBox.put(key, value);

  static Future putAll(Map entries) => _currentlyOpendBox.putAll(entries);

  static Future<void> close() => Hive.close();
}
