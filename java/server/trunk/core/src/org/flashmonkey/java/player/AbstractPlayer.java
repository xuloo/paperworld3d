package org.flashmonkey.java.player;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.message.api.IMessage;
import org.flashmonkey.java.player.api.IPlayer;
import org.red5.server.api.IConnection;

public abstract class AbstractPlayer implements IPlayer {

	protected List<IAvatar> avatars = Collections.synchronizedList(new ArrayList<IAvatar>());
	
	protected String name;
	
	protected IAvatar scopeObject;	
	
	public AbstractPlayer() {
		
	}
	
	@Override
	public abstract void performScopeQuery(List<IAvatar> avatars);

	@Override
	public abstract boolean sendMessage(IMessage message);
	
	@Override
	public void addAvatar(IAvatar avatar) {
		avatars.add(avatar);
	}
	
	@Override
	public void removeAvatar(IAvatar avatar) {
		avatars.remove(avatar);
	}

	@Override
	public String getName() {
		return name;
	}
	
	@Override
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public IAvatar getScopeObject() {
		return scopeObject;
	}

	@Override
	public void setScopeObject(IAvatar scopeObject) {
		this.scopeObject = scopeObject;
	}
	
	@Override
	public abstract String getId();

}
