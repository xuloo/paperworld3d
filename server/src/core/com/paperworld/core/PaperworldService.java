package com.paperworld.core;

import java.util.Map;

import org.red5.server.adapter.IApplication;
import org.red5.server.api.IBandwidthConfigure;
import org.red5.server.api.IBasicScope;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.listeners.IConnectionListener;
import org.red5.server.api.stream.IStreamCapableConnection;
import org.red5.server.api.stream.support.SimpleConnectionBWConfig;
import org.red5.server.framework.Application;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.player.Player;
import com.paperworld.lobby.LobbyData;
import com.paperworld.scenes.RemoteScene;
import com.paperworld.scenes.SceneData;
import com.paperworld.scenes.SceneManager;

/**
 * PaperworldService is the root of a PaperWorld3D server application. All calls
 * to the server from the flash client are routed through the service to prevent
 * ending up with a bloated ApplicationAdaptor that's impossible to
 * debug/troubleshoot/edit etc. etc.
 * 
 * Here we handle:
 * 
 * Calls to connect to the server. Calls to connect to a particular scene that
 * the server is currently handling. Calls to provide input for a specific
 * player. Calls to disconnect from a scene and/or reconnect to another scene.
 * Calls to disconnect from the application.
 * 
 * @author Trevor
 * 
 */
public class PaperworldService implements IApplication, IConnectionListener {

	public static Logger log = LoggerFactory.getLogger(Application.class);

	/**
	 * The SceneManager keeps a record of all the available scenes and the
	 * connected Players. It also manages connecting and disconnecting players
	 * from scenes and registering and unregistering player from scenes.
	 */
	protected SceneManager sceneManager = new SceneManager();

	/**
	 * We hold on to a reference to the main ApplicationAdaptor (this is set in
	 * the paperworld-service.xml Spring config file) - this allows us to
	 * provide all the Scenes with a reference to the ApplicationAdaptor in its
	 * role as a IShedulingService - in this way all scenes are timed from the
	 * same service allowing a central place to control server-side timing.
	 */
	private Application application;

	private IScope scope;
	
	private static PaperworldService instance;
	
	/**
	 * Empty Constructor.
	 */
	public PaperworldService() {
	}
	
	public void init() {
		System.out.println("Initialising paperworldservice " + scope);
		Map<String, RemoteScene> scenes = sceneManager.getScenes();

		for (String key : scenes.keySet()) {
			RemoteScene scene = (RemoteScene) scenes.get(key);
			//scene.init(application);
		}
	}

	public Object[] connectToScene(String username, String zoneId) {
		System.out.println(username + " connecting to " + zoneId + ", " + sceneManager.sceneExists(zoneId));
		if (!sceneManager.sceneExists(zoneId)) {
			return new Object[] { false, username };
		}

		sceneManager.addPlayerToScene(username, zoneId);

		return new Object[] { true, username };
	}

	public RemoteScene[] getAvailableScenes() {
		return sceneManager.getScenesArray();
	}

	public void handleInput(String username, Integer t, Boolean left,
			Boolean right, Boolean forward, Boolean back, Boolean up,
			Boolean down, Boolean yawNegative, Boolean yawPositive,
			Boolean pitchNegative, Boolean pitchPositive, Boolean rollNegative,
			Boolean rollPositive, Double mouseX, Double mouseY, Boolean firing) {

		Player player = sceneManager.getPlayer(username);
	
		AvatarInput input = new AvatarInput();

		input.left = left;
		input.right = right;
		input.forward = forward;
		input.back = back;
		input.up = up;
		input.down = down;
		input.yawNegative = yawNegative;
		input.yawPositive = yawPositive;
		input.pitchNegative = pitchNegative;
		input.pitchPositive = pitchPositive;
		input.rollNegative = rollNegative;
		input.rollPositive = rollPositive;
		input.mouseX = mouseX;
		input.mouseY = mouseY;
		input.firing = firing;

		player.receiveInput(t, input);
	}

	public void setScenes(Map<String, RemoteScene> scenes) {
		sceneManager.setScenes(scenes);

		for (RemoteScene scene : sceneManager.getScenesArray()) {
			scene.init(application);
		}

	}
	
	public SceneData[] getScenesList() {
		
		Map<String, RemoteScene> scenes = sceneManager.getScenes();
		SceneData[] scenesList = new SceneData[scenes.size()];
		
		int i = 0;
		
		for (String key : scenes.keySet()) {
			RemoteScene zone = scenes.get(key);
			SceneData theatre = zone.getSceneData();
			
			String name = zone.getName();
			theatre.setName(name);
			
			scenesList[i] = theatre;
			i++;
		}
		System.out.println("returning " + scenesList.length + " theatres");
		return scenesList;
	}
	
	public SceneData getSceneData(String username) {
		Player player = sceneManager.getPlayers().get(username);
		RemoteScene scene = player.getScene();
		return scene.getSceneData();
	}
	
	public SceneData getLobbyData(String username) {
		Player player = sceneManager.getPlayers().get(username);
		RemoteScene scene = player.getScene();
		RemoteScene lobby = sceneManager.getScene(scene.getName() + "Lobby");
		System.out.println("scene " + scene + " lobby name: " + (scene.getName() + "Lobby") + " lobby: " + lobby);
		return lobby.getSceneData();
	}

	public boolean appConnect(IConnection conn, Object[] params) {
		
		String username = params[0].toString();

		Player player = (Player) Red5.getConnectionLocal().getScope()
				.getContext().getBean("player");
		player.setUsername(username);
		player.setConnection(conn);

		sceneManager.addPlayer(player);

		System.out.println(params[0] + ", " + params[1] + " player created: " + player + " with avatar " + player.avatar);
		
		return true;
	}

	public void appDisconnect(IConnection conn) {
		Player player = sceneManager.getPlayer(conn);
		removePlayer(player);
	}

	private void removePlayer(Player player) {
		sceneManager.removePlayer(player);
	}

	public boolean appJoin(IClient arg0, IScope arg1) {
		return false;
	}

	public void appLeave(IClient arg0, IScope arg1) {
		System.out.println("app leaving");
	}

	public boolean appStart(IScope scope) {
		System.out.println("paperworld service started - scope being registered");
		this.scope = scope;
		return true;
	}

	public void appStop(IScope arg0) {
		System.out.println("app stopping");
	}

	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		return false;
	}

	public void roomDisconnect(IConnection arg0) {
		System.out.println("room disconnecting");
	}

	public boolean roomJoin(IClient arg0, IScope arg1) {
		return false;
	}

	public void roomLeave(IClient arg0, IScope arg1) {
		System.out.println("leaving room");
	}

	public boolean roomStart(IScope arg0) {
		System.out.print("Room STarting");
		return false;
	}

	public void roomStop(IScope arg0) {

	}

	public void notifyConnected(IConnection arg0) {

	}

	public void notifyDisconnected(IConnection arg0) {

	}

	public void setApplication(Application a) {
		application = a;
		application.addListener(this);
		scope = application.getScope();
	}

	public Application getApplication() {
		return application;
	}

	public Map<String, Player> getPlayers() {
		return sceneManager.getPlayers();
	}

	public boolean addChildScope(IBasicScope arg0) {
		return false;
	}
	
	public IScope getScope() {
		return scope;
	}
}
