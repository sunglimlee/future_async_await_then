import 'dart:async';

/*
async / await 또한 Dart 의 비동기 처리를 위한 것으로 Future 를 조금 더 용이하게 다루기 위한 키워드입니다.
어떤 역할을 하는지 보기 전에 중요한 원칙을 이야기 하겠습니다.

await 키워드를 사용한 함수는 무조건 async 함수이어야 합니다.
async 함수는 무조건 Future 를 반환해야 합니다.
1번 규칙은 별로 어렵지 않은 규칙입니다.
await 라는 키워드를 함수 내부에서 사용한다면 해당 함수 스코프를 알려주는 { ... } 의 앞에 async 를 적어주기만 하면 됩니다.
 */

Future<String> helloWorld() async {
  return await Future.delayed(const Duration(seconds: 3), () {
    const hello = "Hello World";
    print(hello);
    return hello;
  });
}

void main() {
  // 위의 함수에서 아무리 async 와 await 를 사용했었어도 함수를 이용해서 받는 변수에 await 를 넣지 않으면 그냥 Future<String>
  // 이 반환되는구나.
  final future = helloWorld();
  print(future);
}
/*

이 코드의 특징은 async 함수를 호출할 때, await 키워드를 사용하지 않은 것입니다. 이 코드의 실행 결과는 다음과 같습니다.

Instance of 'Future<String>'
Hello World

결과가 이와 같은 이유는 4-1 번 코드의 설명과 동일하기 때문에 생략하겠습니다.
*/