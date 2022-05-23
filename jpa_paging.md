# JPA 페이징

- application.properties
  - logging.level.com.example= DEBUG  //패키지 경로, 로커 DEBUG까지 나오도록
- Pageable은 Page로 리턴 Imp에 getContent()를 통해 리스트로 반환
- data.sql 로 데이터 insert

### application.properties
```java

#spring.thymeleaf.cache=false

spring.jpa.hibernate.ddl-auto=create
spring.jpa.show-sql=true
spring.jpa.hibernate.format_sql=true
spring.jpa.hibernate.generate-ddl=true

spring.datasource.url=jdbc:mariadb://localhost:3306/mydb
spring.datasource.username=root
spring.datasource.password=1234
spring.datasource.driver-class-name=org.mariadb.jdbc.Driver

spring.sql.init.mode=always
spring.sql.init.data-locations=classpath:data.sql
spring.jpa.defer-datasource-initialization=true
#
##한글 깨질때
spring.sql.init.encoding=UTF-8

#logging.level.org.hibernate.type.descriptor.sql=trace
logging.level.com.example= DEBUG

spring.servlet.multipart.max-file-size= -1
spring.servlet.multipart.max-request-size= 20MB

```


### controller
```java
import com.example.demo4.service.EmployeeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("employee")
public class EmployeeController {

    private final Logger logger = LoggerFactory.getLogger(EmployeeController.class);

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("list")
    public String list(@RequestParam(required = false)Integer pageNumber, Model model){
        logger.info("employee list");
        long count = employeeService.getEmployeeCnt();
        int page = (pageNumber == null)? 1: pageNumber;
        int size = 10;
        
        int totalPages = (int)Math.ceil((double)count/size);    //ceil - 절상

        logger.debug("==========================");
        logger.debug("count = " + count);
        logger.debug("page = " + page);
        logger.debug("size = " + size);
        logger.debug("totalPages = " + totalPages);
        logger.debug("==========================");

        Pageable pageable = PageRequest.of(page-1, size);   
        //page-1: 페이지는 0페이지부터 시작되기때문에
        model.addAttribute("employees", employeeService.getEmployeeList(pageable));
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("page", page);

        return "employee/list";
    }


}


```
### ServiceImp
```java
import com.example.demo4.repository.EmployeeRepository;
import com.example.demo4.repository.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class EmployeeServiceImp implements EmployeeService{

    @Autowired
    private EmployeeRepository employeeRepository;

    @Override
    public List<Employee> getEmployeeList(Pageable pageable) {
        return employeeRepository.findAll(pageable).getContent();  
        //페이지객체 리턴값을 getContent()로 리스트로 반환.
    }

    @Override
    public Long getEmployeeCnt() {
        return employeeRepository.count();
    }
}

```
### Repository
```java
import com.example.demo4.repository.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer>{

        }
```
### 페이지네이션
- list.html (타임리프)
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>사원 목록</title>
    <style>
        *{ text-align:center}
        .count{
            margin-left:30px; font-size:small;
        }
        tr{align:center;}
        thead{ background-color:#ddd;}
        .pageBox{text-align:center;}
        .pagenation{list-style:none; }
        .page-item{display:inline-block}
        .page-link{text-decoration:none;}
        button a{text-decoration:none; color:black;}
    </style>
</head>
<body>

<h1>사원 목록</h1>
<table width="700px" border="1" align="center" style="border-collapse:collapse;">
    <thead>
    <tr>
        <th>사번</th>
        <th>이름</th>
        <th>성</th>
        <th>성별</th>
        <th>생년월일</th>
        <th>E-mail</th>
        <th>부서</th>
    </tr>
    </thead>
    <tbody>
        <tr th:each="employee : ${employees}">
            <td th:text="${employee.no}"></td>
            <td th:text="${employee.firstName}"></td>
            <td th:text="${employee.lastName}"></td>
            <td th:text="${employee.sex}"></td>
            <td th:text="${employee.birthday}"></td>
            <td th:text="${employee.mailAddress}"></td>
            <td th:text="${employee.department.name}"></td>
        </tr>
    </tbody>
</table>
<div class="pageBox">
    <ul class="pagenation">
        <li class="page-item" th:each="i: ${#numbers.sequence(1, totalPages)}"
                                th:classappend="${i == page? active : ''}">
            <a class="page-link" th:href="|/employee/list?pageNumber=${i}|">
              <span th:text="${i}">1</span>
            </a>
        </li>
    </ul>
</div>
</body>
</html>
```

