# QueryDSL 서브쿼리

where절의 Subquery

- eq() 사용

```java
Member result = queryFactory
            .selectFrom(member)
            .where(member.age.eq(
                JPAExpressions
                    .select(memberSub.age.max())
                    .from(memberSub)
            ))
            .fetchOne();
```

- goe() 사용

```java
List<Member> result = queryFactory
            .selectFrom(member)
            .where(member.age.goe(
                JPAExpressions
                    .select(memberSub.age.avg())
                    .from(memberSub)
            ))
            .fetch();
```

- in() 사용

```java
List<Member> result = queryFactory
            .selectFrom(member)
            .where(member.age.in(
                JPAExpressions
                    .select(memberSub.age)
                    .from(memberSub)
                    .where(memberSub.age.gt(10))
            ))
            .fetch();
```

- select절의 서브쿼리 - Scalar Subquery

```java
List<Tuple> result = queryFactory
            .select(member.username,
                JPAExpressions
                    .select(memberSub.age.avg())
                    .from(memberSub))
            .from(member)
            .fetch();
```

- from절의 서브쿼리 - Inline ViewPermalink
  - JPA, JPQL에서는 from절의 서브쿼리를 지원하지 않는다.
  - querydsl은 JPQL의 빌더 역할이기 때문에 JPQL이 지원하지 않는 문법은 구현할 수 없다.
  - select, where절의 서브쿼리는 Hibernate가 지원하고 있기에 Hibernate 구현체를 사용하는 querydsl(querydsl-jpa)을 사용할 경우 select, where절의 서브쿼리를 사용할 수 있다.
- 해결방안
  - 가능한 경우 서브쿼리를 join으로 변경한다.
  - 성능이 크게 중요하지 않거나 심각한 성능 저하를 발생하지 않는다면, 쿼리를 분리한다.
  - native sql을 사용한다.
  - from절의 서브쿼리를 사용하는 안 좋은 경우Permalink
  - 한 쿼리가 많은 기능을 지원
  - 화면에 렌더링할 데이터 포맷을 맞추는 경우
  - 비즈니스 로직이 포함된 경우
  - sql은 데이터를 가져오는 역할에만 집중해야한다.
  - 데이터 포맷은 view 계층에서 해결한다.
  - 비즈니스 로직은 service 계층에서 해결한다.

```java
@Repository
public class BuimStdCdCnvtRepoImpl extends QuerydslRepositorySupport implements BuimStdCdCnvtRepoCustom{

	public BuimStdCdCnvtRepoImpl() {
		super(BuimStdCdCnvt.class);
	}

	private static final QBuimStdCdCnvt cdcnvt = QBuimStdCdCnvt.buimStdCdCnvt;
	private static final QBrdhIfLoc loc = QBrdhIfLoc.brdhIfLoc;
	private static final QBrdhIfEquipTySz equip = QBrdhIfEquipTySz.brdhIfEquipTySz;

	@Override
	public List<CdCnvtResult> searchCdCnvt(CdCnvtCondition condition) {
		return from(cdcnvt)
				.select(Projections.constructor(CdCnvtResult.class,
						cdcnvt.ptyTpCd.as("party"),
						cdcnvt.ptyCd.as("partyCode"),
						cdcnvt.stdCdDivCd.when("L").then("Location")
													.when("E").then("EQUIP SIZE/type")
													.otherwise("etc").as("division")
													,
						cdcnvt.ptrUseCdNm.as("partyUseCode"),
						cdcnvt.stdCd.as("standardCode"),
						new CaseBuilder().when(cdcnvt.stdCdDivCd.eq("L")).then(JPAExpressions.select(loc.locNm)
																		.from(loc)
																		.where(cdcnvt.stdCd.eq(loc.locCd)))
										.when(cdcnvt.stdCdDivCd.eq("E")).then(JPAExpressions.select(equip.equipNm)
																		.from(equip)
																		.where(cdcnvt.stdCd.eq(equip.equipTpSzCd)))
										.otherwise("").as("codeName"),
						cdcnvt.stdCdCnvtRmk.as("remark")
//						cdcnvt.regDt.as("registerDate").after(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(cdcnvt.regDt))
//						cdcnvt.regDt.as("registerDate")
						))
				.where(isParty(condition.getPtyTpCd()),
						isDivision(condition.getStdCdDivCd())
						)
				.fetch();

	}

	public BooleanExpression isParty(String party) {
		if(StringUtils.isNullOrEmpty(party)) {
			return cdcnvt.ptyTpCd.contains("");
		}
		return cdcnvt.ptyTpCd.eq(party);
	}

	public BooleanExpression isDivision(String division) {
		if(StringUtils.isNullOrEmpty(division)) {
			return cdcnvt.stdCdDivCd.contains("");
		}
		return cdcnvt.stdCdDivCd.eq(division);
	}
}
```

[참고 블로그](https://jaime-note.tistory.com/74)
