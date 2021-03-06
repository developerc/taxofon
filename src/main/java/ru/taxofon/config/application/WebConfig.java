package ru.taxofon.config.application;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

// spring-dispatcher-servlet.xml
@Configuration
@EnableWebMvc
@ComponentScan({"ru.taxofon"})
public class WebConfig extends WebMvcConfigurerAdapter {

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp" );
        //     viewResolver.setSuffix(".html");
        viewResolver.setContentType("text/html;charset=utf-8");
        return viewResolver;
    }

}
