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

Future<List<String>> world() async {
  final future1 = await helloWorld(); // await 로 3초간 정지하지만, future1 에는 Future<String> 이 아닌 String 이 저장
  final future2 = await byeByeWorld(); // await 로 3초간 정지하지만, future2 에는 Future<String> 이 아닌 String 이 저장

  print('(world) future1: $future1');
  print('(world) future2: $future2');
  print('(world) future1과 future2와 관계 없는 print 문, 빨리 수행될 수록 좋음');
  return [future1, future2];  // 두 번의 await 로 world() 함수 종료까지 6초 소요
}

void main() {
  final futures = world();  // world() 함수의 return 타입은 Future<List<String>> 이므로
  print('(main) future: $futures');  // futures 의 값은 Instance of 'Future<List<String>>'
}/*


await 키워드를 보면 함수는 그 동작이 완료될 때까지 기다립니다.
world() 함수는 await 가 필요한 동작 2개가 있으니 (각 3초씩) 총 6초가 소요되어 return [future1, future2]
에 도달할 것입니다.
이 말은 즉, world() 내 3개의 print 도 6초 후에 일어나며,
main() 의 futures 변수는 6초 이후에 Future<List<String>> 상자를 열 수 있다는 뜻입니다.

코드 실행 결과는 다음과 같습니다. (이해하기 쉽도록 실제 출력되지 않지만 출력문이 나올 때까지 걸린 시간도 적겠습니다.)

(main) future: Instance of 'Future<List<String>>' //0초
(world) future1: Hello World    // 6초
(world) future2: Bye Bye World  // 6초
(world) future1과 future2와 관계 없는 print문, 빨리 수행될 수록 좋음 // 6초

world() 함수의 마지막 print 는 await 때문에 future1 과 future2 와도 관계없는데도 불구하고,
6초 후에, 그것도 가장 마지막에 실행되었습니다.
*/