package edu.nus.iss.exam.service.impl;

import edu.nus.iss.exam.constants.AiScoreResult;
import edu.nus.iss.exam.constants.Prompt;
import edu.nus.iss.exam.service.AiScoreService;
import groovy.util.logging.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@lombok.extern.slf4j.Slf4j
@Service
@Slf4j
public class AiScoreServiceImpl implements AiScoreService {
    @Autowired
    private RestTemplate restTemplate;

    @Override
    public AiScoreResult score(String question, String referenceAnswer, String studentAnswer, Double fullScore) {
        String prompt = String.format(Prompt.SCORE_PROMPT, question, referenceAnswer, studentAnswer, fullScore);
        try {
//            String url = "http://host.docker.internal:6060/ai/score";
            String url = "http://tj-ai:6060/ai/score";

            // 构造请求体
            Map<String, String> requestBody = Map.of("prompt", prompt);

            // 构造 HTTP 头部
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(requestBody, headers);

            // 发 POST 请求
            ResponseEntity<Map> response = restTemplate.postForEntity(url, requestEntity, Map.class);

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                String resultText = (String) response.getBody().get("response");
                String totalTokens = (String) response.getBody().get("total_tokens");
                return extractScoreAndExplanation(resultText, totalTokens);
            }
        } catch (Exception e){
            log.error("Ai Score Service is not available!");
        }

        return new AiScoreResult(500, 0d, "AI scoring failed or unavailable.", 0);
    }

    private AiScoreResult extractScoreAndExplanation(String text, String totalTokens) {
        double score = 0d;
        String explanation = "";

        Pattern scorePattern = Pattern.compile("Score[:：]\\s*([0-9]+(\\.[0-9]+)?)");
        Pattern explanationPattern = Pattern.compile("Explanation[:：]\\s*(.*)", Pattern.DOTALL);

        Matcher scoreMatcher = scorePattern.matcher(text);
        Matcher explanationMatcher = explanationPattern.matcher(text);

        if (scoreMatcher.find()) {
            score = Double.parseDouble(scoreMatcher.group(1));
        }
        if (explanationMatcher.find()) {
            explanation = explanationMatcher.group(1).trim();
        }

        return new AiScoreResult(200, score, explanation, Integer.valueOf(totalTokens));
    }
}
