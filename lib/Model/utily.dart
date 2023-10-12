import 'package:hive/hive.dart';
import 'package:moneymanagementapp/Model/add_data.dart';


int totals = 0;
List<Add_data> getChartData(int index) {
  List<Add_data> data = [];

  switch (index) {
    case 0:
      data = today();
      break;
    case 1:
      data = week();
      break;
    case 2:
      data = month();
      break;
    case 3:
      data = year();
      break;
    default:
  }

  return data;
  
}
final box = Hive.box<Add_data>('data');
double myTotal = total();
double total() {
  var history2 = box.values.toList();
  double total = 0.0; 

  for (var i = 0; i < history2.length; i++) {
    final amount = history2[i].amount;
    final parsedAmount = double.tryParse(amount) ??
        0.0; 

    if (history2[i].IN == 'Income') {
      total += parsedAmount;
    } else {
      total -= parsedAmount;
    }
  }

  return total;
}

double income() {
  var history2 = box.values.toList();
  double totalIncome = 0.0;

  for (var i = 0; i < history2.length; i++) {
    final amount = history2[i].amount;
    final parsedAmount = double.tryParse(amount) ?? 0.0;

    if (history2[i].IN == 'Income') {
      totalIncome += parsedAmount;
    }
  }

  return totalIncome;
}

double expenses() {
  var history2 = box.values.toList();
  double totalExpenses = 0.0;

  for (var i = 0; i < history2.length; i++) {
    final amount = history2[i].amount;
    final parsedAmount = double.tryParse(amount) ?? 0.0;

    if (history2[i].IN != 'Income') {
      totalExpenses += parsedAmount;
    }
  }

  return totalExpenses;
}

List<Add_data> today() {
  List<Add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> week() {
  List<Add_data> a = [];
  DateTime date = DateTime.now();
  var history2 = box.values.toList();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].datetime.day &&
        history2[i].datetime.day <=  date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> month() {
  List<Add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> year() {
  List<Add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int totalChart(List<Add_data> history2) {
  List<int> a = [0, 0];

  for (var i = 0; i < history2.length; i++) {
    try {
      int parsedAmount = int.tryParse(history2[i].amount) ?? 0;
      a.add(history2[i].IN == 'Income' ? parsedAmount : -parsedAmount);
    } catch (e) {
      // print(
          // 'Error parsing amount at index $i: ${history2[i].amount}, using default value of 0');
      a.add(0);
    }
  }

  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<Add_data> history2, bool hour) {
  List<Add_data> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].datetime.hour == history2[c].datetime.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].datetime.day == history2[c].datetime.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(totalChart(a));
    a.clear();
    c = counter;
  }
  // print(total);
  return total;
}

void editData(Add_data existingData, String newName, String newExplain,
    String newAmount, String newIN, DateTime newDateTime) {
  existingData.name = newName;
  existingData.explain = newExplain;
  existingData.amount = newAmount;
  existingData.IN = newIN;
  existingData.datetime = newDateTime;
  existingData.save();
}
double calculateIncome(List<Add_data> data) {
  double totalIncome = 0.0;
  
  for (final entry in data) {
    final amount = double.tryParse(entry.amount) ?? 0.0;
    if (entry.IN == 'Income') {
      totalIncome += amount;
    }
  }
  
  return totalIncome;
}

double calculateExpenses(List<Add_data> data) {
  double totalExpenses = 0.0;
  
  for (final entry in data) {
    final amount = double.tryParse(entry.amount) ?? 0.0;
    if (entry.IN != 'Income') {
      totalExpenses += amount;
    }
  }
  
  return totalExpenses;
}
