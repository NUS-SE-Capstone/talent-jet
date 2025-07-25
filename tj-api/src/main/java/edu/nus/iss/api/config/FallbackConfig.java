package edu.nus.iss.api.config;

import edu.nus.iss.api.client.learning.fallback.LearningClientFallback;
import edu.nus.iss.api.client.trade.fallback.TradeClientFallback;
import edu.nus.iss.api.client.user.fallback.UserClientFallback;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FallbackConfig {
    @Bean
    public LearningClientFallback learningClientFallback(){
        return new LearningClientFallback();
    }

    @Bean
    public TradeClientFallback tradeClientFallback(){
        return new TradeClientFallback();
    }

    @Bean
    public UserClientFallback userClientFallback(){
        return new UserClientFallback();
    }

}
