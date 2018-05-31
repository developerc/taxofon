package ru.taxofon.config.application;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import ru.taxofon.dao.AccTaxDao;
import ru.taxofon.dao.DamageDescriptionDao;
import ru.taxofon.dao.DamageListDao;
import ru.taxofon.dao.TaxofonListDao;
import ru.taxofon.dao.impl.AccTaxDaoImpl;
import ru.taxofon.dao.impl.DamageDescriptionDaoImpl;
import ru.taxofon.dao.impl.DamageListDaoImpl;
import ru.taxofon.dao.impl.TaxofonListDaoImpl;
import ru.taxofon.entity.AccTax;
import ru.taxofon.entity.DamageDescription;
import ru.taxofon.entity.DamageList;
import ru.taxofon.entity.TaxofonList;

@Configuration
@PropertySource(value = "classpath:util.properties")
@PropertySource(value = "classpath:auth.properties")
public class AppConfig {
    @Autowired
    private Environment environment;

    @Bean
    public DriverManagerDataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(environment.getRequiredProperty("jdbc.mariadb.driver"));
        dataSource.setUrl(environment.getRequiredProperty("jdbc.mariadb.url"));
        dataSource.setUsername(environment.getRequiredProperty("jdbc.mariadb.user"));
        dataSource.setPassword(environment.getRequiredProperty("jdbc.mariadb.password"));
        return dataSource;
    }

    @Bean
    public TaxofonListDao taxofonListDao(){
        return new TaxofonListDaoImpl(TaxofonList.class);
    }

    @Bean
    public DamageListDao damageListDao(){
        return new DamageListDaoImpl(DamageList.class);
    }

    @Bean
    public DamageDescriptionDao damageDescriptionDao(){
        return new DamageDescriptionDaoImpl(DamageDescription.class);
    }

    @Bean
    public AccTaxDao accessibleDao(){
        return new AccTaxDaoImpl(AccTax.class);
    }
}
