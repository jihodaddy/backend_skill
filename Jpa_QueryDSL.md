# JPA QueryDSL

## QueryDSL 사용하는 방법

```java
Querydsl 사용하는 방법
// 기존 방법 1.
public interface MemberRepository extends JpaRepository<Member, Long>, MemberRepositoryCustom {}

// 기존 방법2
public class MemberRepositoryCustom extends QuerydslRepositorySupport {}

// 추천하는 방법
@Repository
@RequiredArgsConstructor
public class MemberRepositoryCustom {
    private final JpaQueryFactory queryFactory; // 물론 이를 위해서는 빈으로 등록을 해줘야 한다.
}
```

JpaQueryFactory 빈으로 등록하는 방법

```java
@Configuration
public class QuerydslConfiguration {
    @Autowired
    EntityManager em;

    @Bean
    public JPAQueryFactory jpaQueryFactory() {
       return new JPAQueryFactory(em);
    }
}
```

## 기본 사용법

```java
CriteriaBuilder cb = em.getCriteriaBuilder();
CriteriaQuery<Member> cp = cb.createQuery(Member.class);

Root<Member> root = cq.from(Member.class);

cq.select(root);
cq.where(cb.equal(root.get("userId"), "admin"));

cq.orderBy(cb.asc(root.get("id")));

TypedQuery<Member> query = em.createQuery(cq);
```

## 동적쿼리는 BooleanExpression 사용하기

동적쿼리를 작성하는 방법에는 BooleanBuilder 를 작성하는 방법과 Where 절과 피라미터로 Predicate 를 이용하는 방법 그리고 Where 절과 피라미터로 Predicate 를 상속한 BooleanExpression 을 사용하는 방법 이렇게 있다.

예제를 보면 알겠지만 BooleanBuilder 를 사용하는 방법은 어떤 쿼리가 나가는지 예측하기 힘들다는 단점이 있다.

그리고 Predicate 보다는 BooleanExpression 을 사용하는 이유로는 BooleanExpression 은 and 와 or 같은 메소드들을 이용해서 BooleanExpression 을 조합해서 새로운 BooleanExpression 을 만들 수 있다는 장점이 있다. 그러므로 재사용성이 높다. 그리고 BooleanExpression 은 null 을 반환하게 되면 Where 절에서 조건이 무시되기 때문에 안전하다.

BooleanBuilder 를 이용하는 예제

```java
public List<MemberTeamDto> searchByBuilder(MemberSearchCondition condition){
    BooleanBuilder builder = new BooleanBuilder();

    if (hasText(condition.getUsername())) {
        builder.and(member.username.eq(condition.getUsername()));
    }

    if(hasText(condition.getTeamName())){
        builder.and(team.name.eq(condition.getTeamName()));
    }

    if(condition.getAgeGoe() != null) {
        builder.and(member.age.goe(condition.getAgeGoe()));
    }

    if(condition.getAgeLoe() != null){
        builder.and(member.age.loe(condition.getAgeLoe()));
    }

    return queryFactory
            .select(new QMemberTeamDto(
                    member.id.as("memberId"),
                    member.username,
                    member.age,
                    team.id.as("teamId"),
                    team.name.as("teamName")
            ))
            .from(member)
            .leftJoin(member.team, team)
            .where(builder)
            .fetch();
}
```

Where 절과 BooleanExpression 을 이용하는 에제

```java
public List<MemberTeamDto> searchByWhere(MemberSearchCondition condition){
    return queryFactory
            .select(new QMemberTeamDto(
                    member.id.as("memberId"),
                    member.username,
                    member.age,
                    team.id.as("teamId"),
                    team.name.as("teamName")
            ))
            .from(member)
            .leftJoin(member.team, team)
            .where(
                usernameEq(condition.getUsername()),
                teamNameEq(condition.getTeamName()),
                ageGoe(condition.getAgeGoe()),
                ageLoe(condition.getAgeLoe())
            )
            .fetch();
}

private BooleanExpression usernameEq(String username) {
    return hasText(username) ? member.username.eq(username) : null;
}

private BooleanExpression teamNameEq(String teamName) {
    return hasText(teamName) ? team.name.eq(teamName) : null;
}

private BooleanExpression ageGoe(Integer ageGoe) {
    return ageGoe != null ? member.age.goe(ageGoe) : null;
}

private BooleanExpression ageLoe(Integer ageLoe) {
    return ageLoe != null ? member.age.loe(ageLoe) : null;
}

private BooleanExpression ageBetween(Integer ageLoe, Integer ageGoe) {
    return ageLoe(ageLoe).and(ageGoe(ageGoe));
}
```

Dto 조회할때 필요한 칼럼만 가져오기

```java
public List<MemberTeamDto> findSameTeamMember(Long teamId){
    return queryFactory
            .select(new QMemberTeamDto(
                    member.id,
                    member.username,
                    member.age,
                    Expressions.asNumber(teamId),
                    team.name
            ))
            .from(member)
            .innerJoin(member.team, team)
            .where(member.team.id.eq(teamId))
            .fetch();
}
```
