# List<Map<String, Object>> ,, List<String> 자료형 변환

- stream.map().collect(Collectors.toList()) 사용
```java
    final List<Student> stu = Arrays.asList(Student.of(1, "kim", 100),
                                            Student.of(2, "park", 87),
                                            Student.of(3, "lee", 95));
    List<Map<String,Object>> collectTest = stu.stream()
                                .map(Student::toMap).collect(Collectors.toList());
```

- List<Map<String, Object> to List<string>
  - toMap 메소드를 작성후
```java
 public static Map<String, Object> toMap(Student student) {
            try {
                Field[] fields = student.getClass().getDeclaredFields();
                Map<String, Object> results = new HashMap<>();
                for (Field field : fields) {
                    results.put(field.getName(), field.get(student));
                }
                return results;

            } catch (IllegalAccessException | IllegalArgumentException e) {
                return null;
            }

        }
```
```java
 public static void main(String[] args) {

        List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
        List<String> valueList = mapList.stream()
                                .filter(t -> t.containsKey("Key 값")).map(m -> m.get("원하는 Key").toString()).collect(Collectors.toList()); //collect(Collectors.toList());
        } 
 ```
- ObjectMapper 활용
  - jackson 라이브러리
```java
final ObjectMapper objectMapper = new ObjectMapper();
        final List<Object> collectedPeople = objectMapper
                        .convertValue(people, new TypeReference<List<Object>>() {});
```
