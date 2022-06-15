# INNER JOIN / OUTER JOIN

- inner join 을 A 와 B에 대해 수행하는 것은, A와 B의 교집합을 말합니다. 벤다이어그램으로 그렸을 때 교차되는 부분입니다.
- outer join을 A와 B에 대해 수행하는 것은, A와 B의 합집합을 말합니다. 벤다이어 그램으로 그렸을 때, 합집합 부분입니다.

### 기본 예제

- 두개의 컬럼 A,B , 컬럼은 1개

```
A    B
-    -
1    3
2    4
3    5
4    6
```

- Inner Join

```
select * from a INNER JOIN b on a.a = b.b;
select a.*,b.*  from a,b where a.a = b.b;

a | b
--+--
3 | 3
4 | 4
```

- Left Outer Join

```
select * from a LEFT OUTER JOIN b on a.a = b.b;
select a.*,b.*  from a,b where a.a = b.b(+);

a |  b
--+-----
1 | null
2 | null
3 |    3
4 |    4
```

-

- Right Outer Join

```
select * from a RIGHT OUTER JOIN b on a.a = b.b;
select a.*,b.*  from a,b where a.a(+) = b.b;

a    |  b
-----+----
3    |  3
4    |  4
null |  5
null |  6
```

- Full Outer Join

```
select * from a FULL OUTER JOIN b on a.a = b.b;



 a   |  b
-----+-----
   1 | null
   2 | null
   3 |    3
   4 |    4
null |    6
null |    5
```

![join](https://user-images.githubusercontent.com/94466572/173870234-d9cbdfb9-40fe-43e7-ba6e-db0061efc823.png)
