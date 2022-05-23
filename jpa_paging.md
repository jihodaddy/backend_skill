# JPA 페이징

- application.properties
  - logging.level.com.example= DEBUG  //패키지 경로, 로커 DEBUG까지 나오도록
- Pageable은 Page로 리턴 Imp에 getContent()를 통해 리스트로 반환


- controller
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
        int size = 5;
        
        int totalPages = (int)Math.ceil((double)count/size);    //ceil - 절상

        logger.debug("==========================");
        logger.debug("count = " + count);
        logger.debug("page = " + page);
        logger.debug("size = " + size);
        logger.debug("totalPages = " + totalPages);
        logger.debug("==========================");

        Pageable pageable = PageRequest.of(page-1, size);   //page-1: 페이지는 0페이지부터 시작되기때문에
        model.addAttribute("employees", employeeService.getEmployeeList(pageable));

        return "employee/list";
    }


}

```
- ServiceImp
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
        return employeeRepository.findAll(pageable).getContent();   //페이지객체 리턴값을 getContent()로 리스트로 반환.
    }

    @Override
    public Long getEmployeeCnt() {
        return employeeRepository.count();
    }
}

```
- Repository
```java
import com.example.demo4.repository.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer>{

        }
```
- 페이지네이션
```java

```

