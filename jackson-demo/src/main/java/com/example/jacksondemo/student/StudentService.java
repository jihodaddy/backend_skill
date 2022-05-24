package com.example.jacksondemo.student;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.stereotype.Service;

@Service
public class StudentService {

    private String jsonStr = "{\"name\" : \"홍길동\", \"email\" : \"test@test.com\",\"address\":\"서울시 강남구\"}";
    private String jsonArrStr = "[{\"name\" : \"이순신\", \"email\" : \"test1@test.com\",\"address\":\"서울시 강남구\"},{\"name\" : \"성춘향\", \"email\" : \"test2@test.com\",\"address\":\"서울시 송파구\"}]";

    public void JsonStringToObject() throws JsonMappingException, JsonProcessingException {

        // {
        // "name" : "홍길동" ,
        // "email" : "test@test.com",
        // "address" : "서울시 강남구"
        // }
        // String jsonStr = "{\"name\" : \"홍길동\", \"email\" :
        // \"test@test.com\",\"address\":\"서울시 강남구\"}";

        ObjectMapper objectMapper = new ObjectMapper();
        // JSON -> Object
        Student student = objectMapper.readValue(jsonStr, Student.class);

        // 출력
        System.out.println(student); // Student(name=홍길동, email=test@test.com, address=서울시 강남구)
    }

    public void JsonToMap() throws JsonMappingException, JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        // JSON -> Map
        Map<String, Object> jsonMap = objectMapper.readValue(jsonStr, new TypeReference<Map<String, Object>>() {
        });

        // 출력
        System.out.println(jsonMap); // {name=홍길동, email=test@test.com, address=서울시 강남구}
    }

    public void JsonToArray() throws JsonMappingException, JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        Student[] studentArr = objectMapper.readValue(jsonArrStr, Student[].class);

        // 출력
        // [Student(name=이순신, email=test1@test.com, address=서울시 강남구), Student(name=성춘향,
        // email=test2@test.com, address=서울시 송파구)]
        System.out.println(Arrays.toString(studentArr));
    }

    public void JsonToObjectList() throws JsonMappingException, JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        List<Student> studentList = objectMapper.readValue(jsonArrStr, new TypeReference<List<Student>>() {
        });
        // 출력
        // [Student(name=이순신, email=test1@test.com, address=서울시 강남구), Student(name=성춘향,
        // email=test2@test.com, address=서울시 송파구)]
        System.out.println(studentList);
    }
}
