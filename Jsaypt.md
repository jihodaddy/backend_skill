# Jsaypt (Java Simplified Encryption)
  - 설정파일 암호화처리 라이브러리

```java
public class JasyptConfig {

    
    public StringEncryptor stringEncryptor() {
        PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();
        SimpleStringPBEConfig config = new SimpleStringPBEConfig();
        config.setPassword("test"); //암호화에 사용할 키 -> 중요
        config.setAlgorithm("PBEWithMD5AndDES"); //사용할 알고리즘
        config.setKeyObtentionIterations("1000");
        config.setPoolSize("1");
        config.setProviderName("SunJCE");
        config.setSaltGeneratorClassName("org.jasypt.salt.RandomSaltGenerator");
        config.setStringOutputType("base64");
        encryptor.setConfig(config);
        return encryptor;
    }
}
```

[Jsaypt 공식문서](http://www.jasypt.org/)
