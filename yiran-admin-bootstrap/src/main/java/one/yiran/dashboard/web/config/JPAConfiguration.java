package one.yiran.dashboard.web.config;

import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.persistence.EntityManager;

@Configuration
@EntityScan(basePackages = {"one.yiran","com.ext"})
@EnableJpaRepositories(value = {"one.yiran", "com.ext"})
@EnableTransactionManagement
public class JPAConfiguration {

//    @Autowired
//    private Environment env;
//
//    @Bean
//    public DataSource getDataSource() {
//        HikariConfig config = new HikariConfig();
//        config.setJdbcUrl(env.getProperty("spring.datasource.url"));
//        config.setUsername(env.getProperty("spring.datasource.username"));
//        config.setPassword(env.getProperty("spring.datasource.password"));
//        return new HikariDataSource(config);
//    }
//
//    @Bean
//    public EntityManagerFactory entityManagerFactory(DataSource dataSource) throws SQLException {
//
//        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
//        vendorAdapter.setGenerateDdl(true);
//
//        LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
//        factory.setJpaVendorAdapter(vendorAdapter);
//        factory.setPackagesToScan("one.yiran.dashboard.entity,com.biz");
//        factory.setDataSource(dataSource);
//        factory.afterPropertiesSet();
//
//        return factory.getObject();
//    }
//
//    @Bean
//    public EntityManager entityManager(EntityManagerFactory entityManagerFactory) {
//        return entityManagerFactory.createEntityManager();
//    }
//
//    @Bean
//    public PlatformTransactionManager transactionManager(DataSource dataSource) throws SQLException {
//        JpaTransactionManager txManager = new JpaTransactionManager();
//        txManager.setDataSource(dataSource);
//        txManager.setEntityManagerFactory(entityManagerFactory(dataSource));
//        return txManager;
//    }

    @Bean
    public JPAQueryFactory jpaQuery(EntityManager entityManager) {
        return new JPAQueryFactory(entityManager);
    }

//    @Bean
//    public HibernateExceptionTranslator hibernateExceptionTranslator() {
//        return new HibernateExceptionTranslator();
//    }
}