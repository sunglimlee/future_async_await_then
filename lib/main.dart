import 'dart:async';

/*
이번에는 error 가 나오는 Future 을 보겠습니다.

 */

Future<int> futureNumber() {
  // 3초 후 Error!가 상자에서 나옵니다
  return Future<int>.delayed(const Duration(seconds: 3), () {
    throw 'Error!';
  });
}

void main() {
  // future 라는 변수에서 미래에(3초 후에) error가 나올 것입니다
  Future<int> future = futureNumber();

  future.then((val) {
    // int가 나오면 해당 값을 출력
    print('val: $val');
  }).catchError((error) {
    // error가 해당 에러를 출력
    print('error: $error');
  });

  print('기다리는 중');
}

/*
이번에는 futureNumber 함수에서 error 가 3초 후에 나올 상자 Future<int> 를 전해주었습니다.
이번에는 catchError 함수가 수행될 차례입니다.
then 함수와 마찬가지로 내부의 함수가 수행될 것입니다.
위 코드의 경우 error 에 Future<int> 상자가 열렸을 때 나올 Error! 가 들어갈 것이므로 error: Error! 가 출력 될 것입니다.


위 코드를 수행했을 때 다음과 같은 출력이 됩니다.

기다리는 중
error: Error!

 */