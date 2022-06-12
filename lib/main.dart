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
  // 3초 후에 Future<String> 에서 "Hello World" 가 나옵니다
  return Future.delayed(const Duration(seconds: 3), () {
    const hello = "Hello World";
    print(hello);
    return hello;
  });
}

void main() {
  final future = helloWorld();
  print(future);
}


/*
이 코드의 특징은 Future 을 return 하는 함수를 호출하지만 await 키워드를 사용하지 않은 것입니다.
main() 함수에서 Future<String> 을 받아 future 에 저장하고 출력합니다. 이 코드의 실행결과는 다음과 같습니다.

Instance of 'Future<String>'
Hello World

첫 번째 줄인 Instance of 'Future<String>' 은 main() 함수의 print(future) 에서,
두 번째 줄인 Hello World 는 helloWorld() 함수에서 출력된 것입니다.
어째서 future 의 출력순서가 첫 번째인지, Instance of 'Future<String>' 으로 출력 되는지 설명하겠습니다.

출력 순서가 첫 번째인 이유는 await 키워드를 사용하지 않았으며
then() 함수를 사용하지 않았으므로
비동기적으로 처리되기 때문에 3초가 되기 전에 print(future) 가 수행됩니다.
값이 Instance of 'Future<String>' 인 이유는 제가 계속 강조했다시피 Future 로 반환된 값은
상자가 열렸을 때 나오는 값으로 바뀌는 것이 아니기 때문입니다.
helloWorld() 함수의 return 타입은 Future<String> 이므로 future 의 타입은 String 으로 바뀌는 것이 아닌
계속 Future<String> 입니다.
 */