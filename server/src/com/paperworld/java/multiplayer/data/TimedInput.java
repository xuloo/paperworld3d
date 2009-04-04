package com.paperworld.java.multiplayer.data;

import com.paperworld.java.data.Input;


public class TimedInput {

	public int time;
	
	public Input input;
	
	public TimedInput() {
		
	}
	
	public TimedInput(int time, Input input) {
		this.time = time;
		this.input = input;
	}
	
	public int getTime() {
		return time;
	}
	
	public void setTime(int time) {
		this.time = time;
	}
	
	public Input getInput() {
		return input;
	}
	
	public void setInput(Input input) {
		this.input = input;
	}
}
