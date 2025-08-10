package edu.nus.iss.exam.service;

import edu.nus.iss.exam.constants.AiScoreResult;

public interface AiScoreService {
    AiScoreResult score(String question,String referenceAnswer, String studentAnswer, Double fullScore);
}
