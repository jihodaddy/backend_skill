# 인증 토큰과 세션

## 바로 직전의 통신도 기억 못하는 HTTP

- HTTP는 stateless한 특성을 가지기 때문에 각 통신의 상태는 저장되지 않습니다.
- 하지만 우리가 웹 서비스를 사용할 때를 생각해봅시다.
- 매번 새 페이지를 요청할때마다 로그인을 해야 한다면 사용이 불가능할 것입니다.

## 기억하는 척 하기 위해 사용되는 세션과 토큰

- 이 문제를 해결하기 위한 대표적인 도구 두 가지가 바로 세션(Session)과 토큰(Token)입니다.
- 유저가 로그인을 시도할 때 서버상에서 일치하는 유저 정보를 찾았다면
- 인증(Authentication) 확인의 표시로 세션이나 토큰을 발급/전달해줍니다.
- 그럼 웹 브라우저 측에서 해당 세션/토큰 정보를 받아 간직하고 있다가
- 새로운 request를 보낼 때마다 인가(Authorization)를 위해 해당 세션/토큰을 함께 보냅니다.
- 그런데 세션과 토큰 모두 존재 목적은 거의 같지만 차이점은 존재합니다.
  `그 중 가장 큰 차이점은 세션은 데이터베이스 서버에 저장된다는 것, 토큰은 클라이언트 측에서만 저장한다는 점입니다.`

## 차이점 1. 사이즈

**세션 < 토큰**
세션을 사용시 주고받는 session id의 크기는 매우 작습니다.
반면 (JWT기준) 토큰은 같은 데이터를 담고 있어도 그에 비해 크기가 큽니다.
사실 이 차이점을 신경쓰고 쓰는 사람은 많지 않은 것 같습니다만..

## 차이점 2. 안전성

**세션**

- 세션은 서버측에서 저장/관리하기 때문에 상대적으로 온전한 상태를 유지하기 유리합니다.
- 하지만 여전히 공격의 위험이 있기에 유효기간, HttpOnly, Secure 옵션 등을 주어 쿠키에 저장합니다.

**토큰**

- 반대로 토큰은 웹 브라우저측 (local storage, 혹은 쿠키 등)에 저장되기 때문에 공격에 노출될 가능성이 더 큽니다.
- 이런 경우를 대비해 토큰에는 민감한 정보를 담지 않습니다.
- 그리고 유효기간을 짧게 설정해 공격에 노출될 수 있는 시간을 최소화합니다.

- 하지만 짧은 주기로 토큰이 무효화되면 서비스 사용자는 계속 로그인을 해줘야 하는 번거로움이 있기 때문에
- 애초에 로그인(인증)시 refresh token이라는 것을 추가적으로 발급합니다.
- refresh token은 좀 더 긴 유효기간을 가졌으며 최대한 안전한 곳에 저장됩니다.
- 기존의 토큰이 만료되거나 변질되면 refresh token을 통해 토큰을 재발급합니다.

## 차이점 3. 확장성

- 최근 대부분의 웹 서비스가 토큰 방식을 선택하게 된 이유가 바로 확장성에 있습니다.
- 세션은 서버에 저장되기 때문에 한꺼번에 다중 접속자가 발생한다면 과부하가 걸릴 수 있습니다.
- 그럼 과부하를 덜어주기 위해 서버를 여러 대를 두면 되겠죠?
- 하지만 또 서버가 여러대라면 세션을 쓰기가 복잡해집니다.

### 서버 분산 / 클러스터 환경에서 드러나는 결정적인 차이

- 요즘 많은 서비스들은 서버 과부하 부담을 줄이기 위해 여러 서버를 두고 서비스를 운영합니다.
- 그리고 앞서 언급했듯 HTTP는 stateless, connectionless 하기 때문에
- request마다 내가 접속한 서버가 달라질 수도 있습니다!!
- 이렇게 되어 버리면 session 정보가 없는 다른 서버에 접속할 때마다 계속 로그인해줘야 합니다.
- 서버 분산 환경에서는 로드 밸런서가 각 request에 대한 서버를 지정해준다.
- 물론 이러한 세션의 단점을 해결하기 위해
- sticky session, session clustering과 같은 방안이 나오기도 했습니다만
- 또 이 방안들도 감안해야 할 처리 비용이 발생하기 때문에
- 애초에 이런 걱정 없이 쓸 수 있는 토큰이 인기가 많은 게 아닌가 싶습니다.

- sticky session은 처음 지정받은 서버만 사용할 수 있기 때문에
- 해당 서버가 터지거나 과부하가 걸려도 어찌할 도리가 없습니다.
- session clustering은 모든 서버마다 세션을 복사해줘야 하기 때문에
- 상당한 메모리를 요구할 뿐 아니라 매 로그인마다 오버헤드가 크게 발생합니다.
- 물론 세션용 서버를 따로 두고 쓰는 방법도 있습니다.
- 하지만 만일을 대비하여 서버를 복제해두어야 합니다.
- 애초에 토큰방식을 사용한다면 추가 서버 없이 인증/인가를 처리할 수 있습니다.