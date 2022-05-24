package com.example.jacksondemo.student;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StudentController {

    @Autowired
    StudentService studentService;

    @RequestMapping("jacksontest")
    public void jsontoobject() throws JsonMappingException, JsonProcessingException {
        System.out.println("JsonStringToObject: ");
        studentService.JsonStringToObject();
        System.out.println("JsonToMap: ");
        studentService.JsonToMap();
        System.out.println("JsonToArray: ");
        studentService.JsonToArray();
        System.out.println("JsonToObjectList: ");
        studentService.JsonToObjectList();
    }

}
