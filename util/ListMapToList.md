# List<Map<String, Object>> to List<String> 자료형 변환

 - List<Map> 에서 특정 key 값들의 value를 List로 저장할 때 java stream() 사용 예제
```java
 public static void main(String[] args) {

        List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
        List<String> valueList = mapList.stream()
                                .filter(t -> t.containsKey("Key 값")).map(m -> m.get("원하는 Key").toString()).collect(Collectors.toList()); //collect(Collectors.toList());
        } 
 ```

