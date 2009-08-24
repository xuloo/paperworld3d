package org.flashmonkey.java.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.flashmonkey.java.api.IAvatar;
import org.flashmonkey.java.api.IPaperworldService;
import org.flashmonkey.java.api.IPlayer;
import org.flashmonkey.java.api.message.IMessage;
import org.flashmonkey.java.multiplayer.messages.processors.BroadcastMessageProcessor;
import org.flashmonkey.java.util.AbstractProcessor;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

public abstract class AbstractPaperworldService extends BaseService implements IPaperworldService {

	protected MultiThreadedApplicationAdapter application;
	
	/**
	 * A Map of IPlayer objects currently using this service keyed
	 * by the Player's connection id.
	 */
	protected final ConcurrentMap<String, IPlayer> players = new ConcurrentHashMap<String, IPlayer>();
	
	protected final ConcurrentMap<String, IAvatar> avatars = new ConcurrentHashMap<String, IAvatar>();
	
	protected final List<AbstractProcessor> messageProcessors = Collections.synchronizedList(new ArrayList<AbstractProcessor>());

	protected Map<String, Integer> idMap = new ConcurrentHashMap<String, Integer>();
	
	public AbstractPaperworldService() {
		
	}
	
	public void init() {
		addMessageProcessor(new BroadcastMessageProcessor(this));
	}
	
	@Override
	public void addMessageProcessor(AbstractProcessor processor) {
		messageProcessors.add(processor);
	}

	@Override
	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
		this.application.addListener(this);
	}

	@Override
	public boolean appConnect(IConnection connection, Object[] args) {
		System.out.println("user " + args[0].toString() + " with password " + args[1].toString() + " joining");
		return true;
	}

	@Override
	public void appDisconnect(IConnection connection) {

	}

	@Override
	public boolean appJoin(IClient client, IScope scope) {
		System.out.println("appJoin");
		return true;
	}

	@Override
	public void appLeave(IClient client, IScope scope) {

	}

	@Override
	public boolean appStart(IScope scope) {
		System.out.println("appStart");
		return true;
	}

	@Override
	public void appStop(IScope scope) {

	}

	@Override
	public boolean roomConnect(IConnection connection, Object[] args) {
		System.out.println("roomConnect");
		return true;
	}

	@Override
	public void roomDisconnect(IConnection connection) {

	}

	@Override
	public boolean roomJoin(IClient client, IScope scope) {
		System.out.println("roomJoin");
		return true;
	}

	@Override
	public void roomLeave(IClient client, IScope scope) {

	}

	@Override
	public boolean roomStart(IScope scope) {
		System.out.println("roomStart");
		return true;
	}

	@Override
	public void roomStop(IScope scope) {

	}

	@Override
	public Object receiveMessage(IMessage message) {
		System.out.println("receiving message: " + message);
		for (AbstractProcessor processor : messageProcessors) {
			if (processor.canProcess(message.getClass())) {
				return processor.process(message);
			}
		}
		
		return null;
	}
	
	public Map<String, IPlayer> getPlayers() {
		return players;
	}
	
	public ISharedObject getSharedObject(String name, boolean persistent) {

        ISharedObjectService service = (ISharedObjectService) ScopeUtils
                .getScopeService(application.getScope(),
                        ISharedObjectService.class, false);
        return service
                .getSharedObject(application.getScope(), name, persistent);
    }
	
	public String getNextId(String id) {
		int currentId = idMap.get(id);
		idMap.put(id, currentId + 1);
		
		return id + "_" + currentId;
	}
	
	public Object echo(Object object) {
		System.out.println("echoing " + object);
		return object;
	}

}
