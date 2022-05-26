# msa 이론
  - DDD( Domain-Driven Design ) 도메인 주도 설계
  - 연관 객체의 묶음을 **AGGREGATE**
  - Aggregates에 포함된 특정 Entity를 **Root Entity**라 함
  - 그리고 Repository를 만들때 Aggregate의 Root Entity에 대해서만 Repository를 제공하라 함
 
 ## 예시
  - 주문 도메인
    - Order는 하나의 배송지(shippingAddress)와 
    - 하나 이상의 품목(LineItem)을 가지며
    - 하나 이상의 주문결제(OrderPayment)를 가짐
      - OrderPayment는 추상 클래스로 모바일결제(MobilePayment)와 (신용카드)CreditPayment상속
  - 
![orderdomain](https://user-images.githubusercontent.com/94466572/170524254-3e2847db-3a9f-469d-aa9a-edbac799dec6.png)
