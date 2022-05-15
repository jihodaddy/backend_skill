# @Configuration 어노테이션

  - 설정 파일을 등록하거나 Bean을 등록하기 위한 어노테이션
  - 스프링 빈으로 등록된 다른 클래스 안에서 @Bean으로 직접 빈을 등록해주는 것도 동작은 한다. 
  - 하지만 @Configuration 안에서 @Bean을 사용해야 싱글톤을 보장받을 수 있으므로 @Bean 어노테이션은 반드시 @Configuration과 함께 사용해주어야 한다.

  - @Bean을 수동으로 등록해야 하는 경우
    - 개발자가 직접 제어가 불가능한 라이브러리를 활용할 때
    - 애플리케이션 전범위적으로 사용되는 클래스를 등록할 때
    - 다형성을 활용하여 여러 구현체를 등록해주어야 할 때

  - @PersistenceContext
    - EntityManager를 빈으로 주입할 때 사용하는 어노테이션
    - 그래서 스프링 컨테이너가 시작될 때 EntityManager를 만들어서 빈으로 등록해둡니다.
    - 이 때 스프링이 만들어둔 EntityManager를 주입받을 때 사용합니다.  
    - 사용이유
      - EntityManager를 사용할 때 주의해야 할 점은 여러 쓰레드가 동시에 접근하면 동시성 문제가 발생하여 쓰레드 간에는 EntityManager를 공유해서는 안됩니다.
      - 일반적으로 스프링은 싱글톤 기반으로 동작하기에 빈은 모든 쓰레드가 공유합니다.
      - 그러나 @PersistenceContext으로 EntityManager를 주입받아도 동시성 문제가 발생하지 않습니다.
      - 동시성 문제가 발생하지 않는 이유는
      - 스프링 컨테이너가 초기화되면서 @PersistenceContext으로 주입받은 EntityManager를 Proxy로 감쌉니다.
      - 그리고 EntityManager 호출 시 마다 Proxy를 통해 EntityManager를 생성하여 Thread-Safe를 보장합니다.
## DataSourceConfig 설정 예
```java

import java.util.HashMap;
import javax.persistence.EntityManager;
import javax.sql.DataSource;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;

@EnableJpaAuditing
@Configuration
@EnableJpaRepositories(
    basePackages = "패키지주소",
    entityManagerFactoryRef = "baseEntityManager",
    transactionManagerRef = "baseTransactionManager"
)
@RequiredArgsConstructor
public class DataSourceConfig {

    private static final String AES_KEY = "";

    private final Environment env;

    @Bean
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource getDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean baseEntityManager() {
        LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(getDataSource());
        em.setPackagesToScan(new String[] {"kr.co.oliveyoung.auth.domain"});

        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        em.setJpaVendorAdapter(vendorAdapter);

        HashMap<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", env.getProperty("spring.jpa.hibernate.ddl-auto"));
        properties.put("hibernate.dialect", env.getProperty("spring.jpa.database-platform"));

        String aesKey = System.getProperty("mysql.aeskey");
        if (aesKey == null || !AES_KEY.equals(aesKey)) {
            throw new IllegalArgumentException(String.format("aeskey error!!: [%s]", aesKey));
        }
        properties.put("AES_KEY", aesKey);

        em.setJpaPropertyMap(properties);

        return em;
    }

    @Bean
    public PlatformTransactionManager baseTransactionManager() {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(baseEntityManager().getObject());

        return transactionManager;
    }

}    
```
