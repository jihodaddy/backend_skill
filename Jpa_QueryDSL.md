# JPA QueryDSL

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
