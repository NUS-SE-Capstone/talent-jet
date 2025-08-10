package edu.nus.iss.exam.constants;

public class Prompt {
    public static final String SCORE_PROMPT="Please grade the following student's answer based on the given question and reference answer.\n\n" +
            "Question:\n" +
            "%s\n\n" +
            "Reference Answer:\n" +
            "%s\n\n" +
            "Student Answer:\n" +
            "%s\n\n" +
            "Please provide a score between 0 and %.1f and explain the reasoning.\n" +
            "Format:\n" +
            "Score: <number>\n" +
            "Explanation: <your explanation>\n";
}
