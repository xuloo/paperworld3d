package com.paperworld.core.util;

import java.util.Random;

public class RandomUtils {

	public static Random generator = new Random();
	
	public static int randomBinomial(int max) {
		return generator.nextInt(max) - generator.nextInt(max);		
	}
	
	public static int getRandomInt(int min, int max) {
		return generator.nextInt(min + max) + min;
	}
	
	public static int[] getRandomInts(int min, int max, int amount) {
		int[] numbers = new int[amount];
		for (int i = 0; i < amount; i++) {
			numbers[i] = getRandomInt(min, max);
		}
		
		return numbers;
	}
}
