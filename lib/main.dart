import 'dart:async';

/*
await 키워드는 수행 중인 함수를 중간에 동작이 완료될 때까지 멈춥니다.
따라서 해당 동작 이후 코드는 동작 완료 전까지 실행되지 않습니다.

then() 함수는 수행 중인 함수를 중간에 멈추도록 하지 않습니다.
따라서 해당 동작 이후 코드는 계속 실행됩니다. */

Future<String> helloWorld() {
  return Future.delayed(const Duration(seconds: 3), () {
    return "Hello World";
  });
}

Future<String> byeByeWorld() {
  return Future.delayed(const Duration(seconds: 3), () {
    return "Bye Bye World";
  });
}

List<Future<String>> world() {
  final future1 = helloWorld();
  future1.then((val) {
    print('(world) future1: $val'); // world() 함수가 실행되고 3초 후 출력
  });

  final future2 = helloWorld();
  future2.then((val) {
    print('(world) future2: $val'); // world() 함수가 실행되고 3초 후 출력
  });

  print('(world) future1과 future2와 관계 없는 print문, 빨리 수행될 수록 좋음');

  return [future1, future2]; // world() 함수가 실행되고 거의 곧바로 return 됨
}

void main() {
  final futures = world(); // futures의 타입은 world() 함수의 return 타입인 List<Future<String>>
  print('(main) future: $futures');
}

/*


6-1번 코드와 비슷하게 동작합니다만 코드 실행 결과는 다소 다릅니다.

(world) future1과 future2와 관계 없는 print 문, 빨리 수행될 수록 좋음  // 0초
(main) future: [Instance of 'Future<String>', Instance of 'Future<String>']  // 0초
(world) future1: Hello World    // 3초
(world) future2: Bye Bye World  // 3초
world() 함수에 이제 await 가 없으니 코드가 중간에 멈추지 않습니다.
다만 나중에 future1 의 상자와 future2 의 상자가 열렸을 때,
then() 함수를 실행할 뿐이죠. 중간에 멈추지 않기 때문에 future1 과 future2 와 관계없는 print 문은 world() 함수가
실행됨과 거의 동시에 출력합니다.
또, future1 과 future2 상자 내 값의 출력까지 6초나 걸린 6-1번 코드와는 다르게 6-2번 코드는 3초밖에 안걸립니다.


혹시 6-1번 코드와 6-2번 코드의 world() 함수의 return 타입이 각각 Future<List<String>> 이고,
List<Future<String>> 인지 잘 모르겠는 분들이 있을 수 설명을 적습니다.

6-1번 코드의 경우, await 를 사용하기 때문에 world() 함수는 호출한 녀석에게 바로 Future 상자를 return 해줍니다.
다만 상자가 열렸을 때 나올 타입이 List<String>> 이기 때문에,
world() 함수의 return 타입은 최종적으로 Future<List<String>> 입니다.
6-2번 코드의 경우, await 를 사용하지 않았기 때문에 함수를 중간에 멈추지 않고 거의 곧바로 return 에 도달하여
List 를 return 합니다.
다만, 그 List 안에 담겨져 있는 원소들이 Future<String> 이죠.
따라서 world() 함수의 return 타입은 최종적으로 List<Future<String>> 입니다.

이 설명을 보아도 잘 모르겠는 분들은 위쪽의 async / await 란 무엇인가를 다시 읽어주세요.
2번 코드와 3번 코드로 then 을 async / await 로 대체할 수 있지만,
6-1번 코드와 6-2번 코드로 then 을 완전히 대체하지 못한다는 것을 보았습니다.
하지만 완전히 대체하지는 못 하는 것뿐이지 거의 대부분의 경우 대체할 수 있을 것이라고 생각합니다.

*/