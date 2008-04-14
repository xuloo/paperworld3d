package com.paperworld.core;

/*
 * RED5 Open Source Flash Server - http://www.osflash.org/red5
 * 
 * Copyright (c) 2006-2007 by respective authors (see below). All rights reserved.
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later 
 * version. 
 * 
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License along 
 * with this library; if not, write to the Free Software Foundation, Inc., 
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 */

import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Class that keeps a list of client names in a SharedObject.
 * 
 * @author The Red5 Project (red5@osflash.org)
 * @author Joachim Bauch (jojo@struktur.de)
 */
public class ClientManager {
	
	public static Logger log = LoggerFactory.getLogger(Application.class);

	/** Stores the name of the SharedObject to use. */
	private String name;

	/** Should the SharedObject be persistent? */
	private boolean persistent;

	/**
	 * Create a new instance of the client manager.
	 * 
	 * @param name
	 * 			name of the shared object to use
	 * @param persistent
	 * 			should the shared object be persistent
	 */
	public ClientManager(String name, boolean persistent) {
		this.name = name;
		this.persistent = persistent;
	}

	/**
	 * Return the shared object to use for the given scope.
	 * 
	 * @param scope
	 * 			the scope to return the shared object for
	 * @return the shared object to use
	 */
	private ISharedObject getSharedObject(IScope scope) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope,
						ISharedObjectService.class,
						false);
		return service.getSharedObject(scope, name, persistent);
	}

	/**
	 * A new client connected. This adds the username to
	 * the shared object of the passed scope. 
	 * 
	 * @param scope
	 * 			scope the client connected to 
	 * @param username
	 * 			name of the user that connected
	 * @param uid
	 * 			the unique id of the user that connected
	 */
	@SuppressWarnings("unchecked")
	public void addClient(IScope scope, String username, String uid) {
		log.debug("adding client");
		ISharedObject so = getSharedObject(scope);
		so.setAttribute(uid, username);
	}
	
	/**
	 * A new client connected. This adds the username to
	 * the shared object of the passed scope. 
	 * 
	 * @param scope
	 * 			scope the client connected to 
	 * @param username
	 * 			name of the user that connected
	 * @param uid
	 * 			the unique id of the user that connected
	 */
	@SuppressWarnings("unchecked")
	public void addClient(IScope scope, com.paperworld.core.Client client) {
		ISharedObject so = getSharedObject(scope);
		so.setAttribute(client.getUid(), client);
	}

	/**
	 * A client disconnected. This removes the username from
	 * the shared object of the passed scope.
	 * 
	 * @param scope
	 * 			scope the client disconnected from
	 * @param uid
	 * 			unique id of the user that disconnected
	 * @return the username of the disconnected user
	 */
	@SuppressWarnings("unchecked")
	public String removeClient(IScope scope, String uid) {
		ISharedObject so = getSharedObject(scope);
		if (!so.hasAttribute(uid)) {
			// SharedObject is empty. This happes when the last client
			// disconnects.
			return null;
		}

		Client client = (Client) so.getAttribute(uid);
		//String username = so.getStringAttribute(uid);
		String username = client.getUsername();
		so.removeAttribute(uid);
		return username;
	}

}
