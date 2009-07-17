package com.paperworld.java.api.message;

public interface IPlayerMessage extends IMessage {

	public String getPlayerId();
	
	public void setPlayerId(String playerId);
}
