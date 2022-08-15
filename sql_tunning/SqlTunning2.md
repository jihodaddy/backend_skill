## 5. 테이블 Random Access 부하

-   인덱스를 쓰는 이유는 **RowId를 찾기 위함**
-   RowId는 HDD에 있음
-   RowId를 해시 함수로 돌려

### [](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/2%EC%A3%BC%EC%B0%A8.md#clustering-factor)Clustering Factor

테이블 블럭들이 **인덱스 정렬 순으로 얼마나 잘 정렬**되어있는지에 대한 지표

## [](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/2%EC%A3%BC%EC%B0%A8.md#6-%ED%85%8C%EC%9D%B4%EB%B8%94-random-%EC%95%A1%EC%84%B8%EC%8A%A4-%EC%B5%9C%EC%86%8C%ED%99%94-%ED%8A%9C%EB%8B%9D)6. 테이블 Random 액세스 최소화 튜닝

### [](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/2%EC%A3%BC%EC%B0%A8.md#%EC%9D%B8%EB%8D%B1%EC%8A%A4%EA%B0%80-%EB%A7%8E%EC%9D%84-%EB%95%8C%EC%9D%98-%EB%8B%A8%EC%A0%90)인덱스가 많을 때의 단점

-   Command(명령 : 등록/수정/삭제)시 인덱스 변경이 필요하여 시간이 많이 소모
-   인덱스 저장 장소가 필요하여 저장소 용량이 많이 필요하게 됨
-   옵티마이저가 인덱스를 보고 실행계획을 작성하는데, 이때 인덱스가 많으면 많을수록 **옵티마이저는 잘못된 실행계획**을 생성할 확률이 높다.

> 인덱스는 3개 이하를 권장한다.

### [](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/2%EC%A3%BC%EC%B0%A8.md#%EC%9D%B8%EB%8D%B1%EC%8A%A4-%EC%BB%AC%EB%9F%BC-%EC%B6%94%EA%B0%80%EB%A1%9C-%ED%95%B4%EA%B2%B0%ED%95%98%EA%B8%B0)인덱스 컬럼 추가로 해결하기

**문제상황)**

인덱스 : deptno + job

select *
from emp
where deptno = 30
and sal > 2000

위와 같은 쿼리를 실행하게 되면 `sal > 2000`인 값을 인덱스를 통해 알 수 없으므로 아래와 같이 **deptno=30인 값들은 모두 테이블 랜덤 엑세스가 발생**하게 됩니다.

[![인덱스 컬럼 추가](https://github.com/jojoldu/fastcampus-sql-tunning/raw/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EC%BB%AC%EB%9F%BC%EC%B6%94%EA%B0%80.png)](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EC%BB%AC%EB%9F%BC%EC%B6%94%EA%B0%80.png)

(출처 : [DB가이드](http://www.dbguide.net/db.db?cmd=view&boardUid=148221&boardConfigUid=9&categoryUid=216&boardIdx=140&boardStep=1))

이걸 해결하기 위해서 인덱스를 `부서+sal` 로 변경하면 좋겠지만, 이미 다른 곳에서 해당 인덱스를 통해 조회하고 있다면 어려울 것입니다.  
그래서 기존의 다른 조회 쿼리들의 성능을 저해하지 않으면서 개선하는 방법은 **인덱스 컬럼을 추가**하는 것입니다.

인덱스 : deptno + job + sal

[![인덱스컬럼추가2](https://github.com/jojoldu/fastcampus-sql-tunning/raw/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EC%BB%AC%EB%9F%BC%EC%B6%94%EA%B0%802.png)](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EC%BB%AC%EB%9F%BC%EC%B6%94%EA%B0%802.png)

(출처 : [DB가이드](http://www.dbguide.net/db.db?cmd=view&boardUid=148221&boardConfigUid=9&categoryUid=216&boardIdx=140&boardStep=1))

이렇게 **인덱스 스캔은 전과 동일**하지만, **테이블 랜덤 엑세스를 효율**적으로 개선할 수 있게 되었습니다.

## [](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/2%EC%A3%BC%EC%B0%A8.md#8-%EC%9D%B8%EB%8D%B1%EC%8A%A4-%EC%8A%A4%EC%BA%94-%ED%9A%A8%EC%9C%A8)8. 인덱스 스캔 효율

-   수직적 탐색의 효율화
   -   가능한 방법은 인덱스 재생성
-   수평적 탐색의 선택도
   -   인덱스 매칭도를 높이는 것
-   테이블 랜덤 Access 최소화

위 3가지가 인덱스 개선의 방향

### [](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/2%EC%A3%BC%EC%B0%A8.md#%EC%9D%B8%EB%8D%B1%EC%8A%A4-%EB%A7%A4%EC%B9%AD%EB%8F%84-%EC%9D%B8%EB%8D%B1%EC%8A%A4-%EC%8A%A4%EC%BA%94-%EB%B2%94%EC%9C%84-%EC%B5%9C%EC%86%8C%ED%99%94)인덱스 매칭도 (인덱스 스캔 범위 최소화)

아래와 같은 쿼리를 수행한다고 가정해보겠습니다.

select *
from 사원
where 입사일자 between '20121201' and '20130105'
and 성별 = '남'
and 관리자 = '000054';

참고로 Distinct (중복된 값이 얼마나 적은지)는 아래와 같습니다.

-   입사일자 : 매우 좋음 (중복된 값이 적음)
-   관리자 : 보통
-   성별 매우 나쁨 (중복된 값이 많음)

이 상황에서 가장 성능이 좋은 인덱스 구성은 어떤것일까요?

1.  입사일자 + 성별 + 관리자
2.  관리자 + 입사일자 + 성별
3.  성별 + 관리자 + 입사일자

하나씩 확인해보겠습니다.

먼저 1번의 경우  
정렬순서가 입사일자 -> 성별 -> 관리자 순으로 되어있어, 조회시 아래와 같이 인덱스 검색을 하게 됩니다.

[![인덱스매칭1](https://github.com/jojoldu/fastcampus-sql-tunning/raw/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EB%A7%A4%EC%B9%AD1.png)](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EB%A7%A4%EC%B9%AD1.png)

사실상 인덱스 전체를 검색한 것과 마찬가지의 조회가 발생합니다.

다음 2번의 경우

[![인덱스매칭2](https://github.com/jojoldu/fastcampus-sql-tunning/raw/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EB%A7%A4%EC%B9%AD2.png)](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EB%A7%A4%EC%B9%AD2.png)

1번보다 효율은 좋지만, 000054/20121221/여 라는 불필요한 값을 만나게 됩니다.

마지막으로 3번의 경우

[![인덱스매칭3](https://github.com/jojoldu/fastcampus-sql-tunning/raw/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EB%A7%A4%EC%B9%AD3.png)](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/images/%EC%9D%B8%EB%8D%B1%EC%8A%A4%EB%A7%A4%EC%B9%AD3.png)

보시는것처럼 가장 효율이 좋은 것은 3번 `성별 + 관리자 + 입사일자` 임을 알 수 있습니다.  
이를 통해 인덱스 컬럼을 효율적으로 생성하기 위해선 다음의 규칙을 지키시면 좋습니다.

-   **Distinct가 낮은 -> 높은 순**으로 인덱스를 생성하는 것이 유리하다.
   -   성별 -> 관리자 -> 입사일자
-   **단일 컬럼**으로 인덱스를 만들어야 한다면, **Distinct가 높을수록**(즉, 종류가 많을수록) 유리하다.
-   **between, <, >, like**는 본인만 만족하는 조건이라 다음 인덱스 컬럼은 다 깨져버린다.
-   반면에 **=, in** 은 다음 인덱스 컬럼이 안깨지도록 한다.
-   in은 범위 조회가 아닌가?
   -   해당 값 찾고 바로 다시 수직적 탐색을 시작한다.
   -   단, **in의 값이 많으면 많을수록 비효율**이라 Between과 비교가 필요함
   -   인덱스를 안태우도록 좌변을 가공하면 인덱스를 타지 않아 수직적 탐색이 발생하지 않고 오히려 비효율이 개선된다.(ex: `trim(컬럼)`)

in은 범위조회가 아닌가? 라는 의문을 가질 수 있습니다.  
아래 쿼리를 참고하시면 그게 아님을 확인할 수 있습니다.

select *
from t
where c1 in ('A', 'K')

위 쿼리는 사실상 아래 쿼리와 동일하다고 보셔야 합니다.

select *
from t
where c1 = 'A'
union all
select
from
where c1 = 'K'

> union all : 두 테이블의 중복되는 값까지 그룹화한다.

즉, in의 항목 하나하나를 조회하는것과 동일하기에 범위조건이라 할수는 없습니다.

[![inlist](https://github.com/jojoldu/fastcampus-sql-tunning/raw/master/images/inlist.png)](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/images/inlist.png)

(출처 : [DB가이드](http://www.dbguide.net/db.db?cmd=view&boardUid=148221&boardConfigUid=9&categoryUid=216&boardIdx=140&boardStep=1))

즉, 결합 인덱스의 우선 순위는 다음을 기준으로 결정하시면 됩니다.

-   자주 사용하는가?
-   equals(=) 조건인가?

## [](https://github.com/jojoldu/fastcampus-sql-tunning/blob/master/2%EC%A3%BC%EC%B0%A8.md#%EC%B6%94%EC%B2%9C-%EB%8F%84%EC%84%9C)추천 도서

-   오라클 성능 고도화 원리와 해법 (2권부터 읽기를 추천)
-   SQL 전문가 가이드