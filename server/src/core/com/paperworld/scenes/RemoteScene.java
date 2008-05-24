package com.paperworld.scenes;

import java.util.ArrayList;
import java.util.Map;

import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.red5.server.framework.Application;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;
import com.paperworld.core.PaperworldService;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.jobs.PlayerUpdateJob;
import com.paperworld.core.jobs.SharedObjectUpdateJob;
import com.paperworld.core.player.Player;

public class RemoteScene implements IScheduledJob {

	public static Logger log = LoggerFactory.getLogger(RemoteScene.class);
	
	protected ArrayList<Player> players = new ArrayList<Player>();

	/** Stores the name of the SharedObject to use. */
	protected String name;

	/** Should the SharedObject be persistent? */
	protected boolean persistent = false;

	protected ISharedObject so;

	protected PaperworldService service;

	protected AbstractSteeringBehaviour behaviour;

	public RemoteScene() {
		
	}

	public void init(ISchedulingService scheduler) {
		//application.addScheduledJob(1000 / 25, players);
		//scheduler.addScheduledJob(1000 / 25, this);
		//scheduler.addScheduledJob(1000 / 25, new PlayerUpdateJob(players));
		scheduler.addScheduledJob(1000 / 200, new SharedObjectUpdateJob(this));
	}

	public void addPlayer(Player player) {
		so = getSharedObject(Red5.getConnectionLocal().getScope());
		players.add(player);
	}
	
	public ArrayList<Player> getPlayers() {
		return players;
	}

	public void removePlayer(Player player) {
		players.remove(player);
		if (players.size() < 1) {
			so.close();
			so = null;
		}
	}

	private ISharedObject getSharedObject(IScope scope) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);
		return service.getSharedObject(scope, name, persistent);
	}

	public String getName() {
		return name;
	}

	private int renderCounter = 0;

	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

		if (renderCounter > 5) {

			if (so != null) {

				so.beginUpdate();
				
				for (Player player : players) {
					Avatar avatar = player.avatar;
					so.setAttribute(avatar.id, avatar.getAvatarData());
				}

				so.endUpdate();
			}

			renderCounter = 0;
		}

		renderCounter++;
	}

	public void setName(String n) {
		name = n;
	}

	public void setPersistent(boolean p) {
		persistent = p;
	}

	public void setService(PaperworldService service) {
		this.service = service;
	}
	
	public void setBehaviour(AbstractSteeringBehaviour b) {
		behaviour = b;
	}

	public AbstractSteeringBehaviour getBehaviour() {
		return behaviour;
	}
	
	public ISharedObject getSO() {
		return so;
	}
}
