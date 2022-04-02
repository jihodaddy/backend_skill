package com.spring_boot.shop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackageClasses = MainController.class)
public class SpringBootShopApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringBootShopApplication.class, args);
	}

}
