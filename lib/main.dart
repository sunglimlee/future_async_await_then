import 'dart:async';

/*
async / await 또한 Dart 의 비동기 처리를 위한 것으로 Future 를 조금 더 용이하게 다루기 위한 키워드입니다.
어떤 역할을 하는지 보기 전에 중요한 원칙을 이야기 하겠습니다.

await 키워드를 사용한 함수는 무조건 async 함수이어야 합니다.
async 함수는 무조건 Future 를 반환해야 합니다.
1번 규칙은 별로 어렵지 않은 규칙입니다.
await 라는 키워드를 함수 내부에서 사용한다면 해당 함수 스코프를 알려주는 { ... } 의 앞에 async 를 적어주기만 하면 됩니다.
 */

Future<String> helloWorld() {
  return Future.delayed(const Duration(seconds: 3), () {
    const hello = "Hello World";
    print(hello);
    return hello;
  });
}
// [error] 'await' can only be used in 'async' or 'async*' methods.
// await 를 사용하면 async 를 반드시 사용하자.
void main() async {
  final future = await helloWorld();
  print(future);
}

/*

이 코드의 특징은 Future 을 return 하는 함수를 호출할 때,
await 키워드를 사용한 것입니다.
main() 함수에서 await 키워드를 사용했기 때문에 async 함수로도 만들어 주었습니다.
그 외에는 동일합니다. 이 코드의 실행 결과는 다음과 같습니다.

Hello World
Hello World

"어? helloWorld() 함수는 Future 를 return 해주는데
왜 Hello World 가 2번 출력되지?" 하시는 분이 계실 겁니다.
(제가 그랬습니다...)
그 이유는 위에서 말씀드렸다시피 await 키워드를 만나면 해당 함수를 잠시 정지하고,
await 키워드가 붙은 동작이 완료될 때까지 기다립니다.
그리고 결과를, 상자안의 내용물을 바로 넘겨줍니다.
이 방법을 통해 Future<String> 으로 String 을 얻을 수 있습니다.
*/