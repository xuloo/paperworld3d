package org.paperworld.java.player;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.paperworld.java.api.IAvatar;
import org.paperworld.java.api.IInput;
import org.paperworld.java.api.IPaperworldService;
import org.paperworld.java.api.IPlayer;
import org.paperworld.java.api.message.IMessage;
import org.paperworld.java.input.BasicInput;
import org.red5.server.api.IConnection;
import org.red5.server.api.service.ServiceUtils;

public class BasicPlayer implements IPlayer {

	protected List<IAvatar> avatars = Collections.synchronizedList(new ArrayList<IAvatar>());
	
	protected IAvatar scopeObject;
	
	protected IInput input;
	
	protected String name;
	
	protected IConnection connection;
	
	protected IPaperworldService service;
	
	public BasicPlayer(IPaperworldService service, String name, IConnection connection) {
		this.service = service;
		setName(name);
		setConnection(connection);
		
		input = new BasicInput();
		
		scopeObject = service.getFactory().getAvatar(this);
	}
	
	public boolean sendMessage(IMessage message) {
		return ServiceUtils.invokeOnConnection(getConnection(),
				"receiveMessage", new Object[] { message });
	}
	
	@Override
	public IAvatar getScopeObject() {	
		return scopeObject;
	}
	
	@Override
	public void setScopeObject(IAvatar scopeObject) {
		this.scopeObject = scopeObject;
		
		if (!avatars.contains(scopeObject)) {
			avatars.add(scopeObject);
		}
	}
	
	@Override
	public void addAvatar(IAvatar avatar) {
		avatars.add(avatar);		
	}
	
	@Override
	public void removeAvatar(IAvatar avatar) {
		avatars.remove(avatar);	
		if (avatar.equals(scopeObject)) {
			scopeObject = null;
		}
	}

	@Override
	public void performScopeQuery(List<IAvatar> avatars) {
		
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
	public IConnection getConnection() {
		return connection;
	}
	
	@Override
	public void setConnection(IConnection connection) {
		this.connection = connection;
	}
	
	public String getId() {
		return getConnection().getClient().getId();
	}
}
