package edu.nus.iss.authsdk.gateway.config;

import edu.nus.iss.authsdk.gateway.util.AuthUtil;
import edu.nus.iss.authsdk.gateway.util.JwtSignerHolder;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;

@Configuration
public class AuthAutoConfiguration {

    @Bean
    @ConditionalOnClass(DiscoveryClient.class)
    public JwtSignerHolder jwtSignerHolder(DiscoveryClient discoveryClient){
        return new JwtSignerHolder(discoveryClient);
    }

    @Bean
    public AuthUtil authUtil(JwtSignerHolder jwtSignerHolder, StringRedisTemplate stringRedisTemplate){
        return new AuthUtil(jwtSignerHolder, stringRedisTemplate);
    }
}
