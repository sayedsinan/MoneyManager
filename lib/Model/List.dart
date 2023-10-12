





import 'package:moneymanagementapp/Model/List1.dart';

List<money> geter() {
  money upwork = money();
  upwork.name = 'upwork';
  upwork.fee = '650';
  upwork.time = 'today';
  upwork.image = 'Education.png';
  upwork.buy = false;
  money starbucks = money();
  starbucks.buy = true;
  starbucks.fee = '15';
  starbucks.image = 'food.png';
  starbucks.name = 'starbucks';
  starbucks.time = 'today';
  money trasfer = money();
  trasfer.buy = true;
  trasfer.fee = '100';
  trasfer.image = 'Transfer.png';
  trasfer.name = 'trasfer for sam';
  trasfer.time = 'jan 30,2022';
money adding = money();
  adding.buy = true;
  adding.fee = '100';
  adding.image = 'adding.png';
  adding.name = 'adding';
  adding.time = 'jan 30,2022';

  return [upwork, starbucks, trasfer, upwork, starbucks, trasfer,adding];
}