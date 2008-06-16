package com.paperworld.scenes;

import java.util.ArrayList;

import org.red5.server.adapter.IApplication;
import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.red5.server.framework.Application;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.actions.Action;
import com.paperworld.core.PaperworldService;
import com.paperworld.core.jobs.PlayerUpdateJob;
import com.paperworld.core.jobs.SharedObjectUpdateJob;
import com.paperworld.core.player.Player;

public class RemoteScene /*implements IScheduledJob*/ {

	public static Logger log = LoggerFactory.getLogger(RemoteScene.class);
	
	protected ArrayList<Player> players = new ArrayList<Player>();

	/** Stores the name of the SharedObject to use. */
	protected String name;

	/** Should the SharedObject be persistent? */
	protected boolean persistent = false;

	//protected ISharedObject so;

	protected PaperworldService service;

	protected Action behaviour;
	
	private int updateRate;
	
	protected SceneData sceneData;
	
	protected IScope scope;
	
	public RemoteScene() {
		sceneData = new SceneData();
	}

	public void init(Application application) {
		System.out.println("Initialising RemoteScene (" + name + ")");
		scope = application.getScope();
		application.addScheduledJob(1000 / 25, new PlayerUpdateJob(players));
		application.addScheduledJob(1000 / updateRate, new SharedObjectUpdateJob(this));
	}

	public void addPlayer(Player player) {
		System.out.println("adding player " + player);
		System.out.println("adding " + player.getUsername() + " to " + (name + "_players"));
		getSharedObject(name + "_players").setAttribute(player.getUsername(), player.getPlayerData());
		players.add(player);
	}
	
	public ArrayList<Player> getPlayers() {
		return players;
	}

	public void removePlayer(Player player) {
		players.remove(player);
		getSharedObject(name).removeAttribute(player.getUsername());
		getSharedObject(name + "_players").removeAttribute(player.getUsername());
		if (players.size() < 1) {
			try {
				//ISharedObject so = getSharedObject();
				//so.close();
				//so = null;
			}
			catch (Exception e) {
				
			}
		}
	}

	protected ISharedObject getSharedObject(String name) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);
		return service.getSharedObject(scope, name, persistent);
	}

	public String getName() {
		return name;
	}

	private int renderCounter = 0;
/*
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
	}*/

	public void setName(String n) {
		name = n;
		sceneData.name = n;
	}

	public void setPersistent(boolean p) {
		persistent = p;
	}

	public void setService(PaperworldService service) {
		this.service = service;
	}
	
	public void setBehaviour(Action b) {
		behaviour = b;
	}

	public Action getBehaviour() {
		return behaviour;
	}
	
	public ISharedObject getSO() {
		return getSharedObject(name);
	}
	
	public void setUpdateRate(int updateRate) {
		this.updateRate = updateRate;
	}
	
	public SceneData getSceneData() {
		return sceneData;
	}
	
	public void setScope(IScope scope) {
		this.scope = scope;
	}
	
	public void setImage(String image) {
		sceneData.image = image;
	}
	
	public void setModel(String model) {
		sceneData.model = model;
	}
	
	public void setPlayer(Player player) {
		System.out.println("RemoteScene.setPlayer()");
		players.add(player);
	}
}
