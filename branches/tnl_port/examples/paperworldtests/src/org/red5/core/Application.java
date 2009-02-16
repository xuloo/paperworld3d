package org.red5.core;

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

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.ServiceUtils;

import com.paperworld.server.api.NetObject;

/**
 * Red5Server Framework.
 * 
 * @author The Red5 Project (red5@osflash.org)
 * @author Dominick Accattato
 * @author Joachim Bauch (jojo@struktur.de)
 */
public class Application extends ApplicationAdapter {

	public Application() {
		System.out.println("paperworldtests");
	}

	/** {@inheritDoc} */
	@Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {

		String uid = conn.getClient().getId();

		// Notify client about unique id.
		ServiceUtils.invokeOnConnection(conn, "setClientID",
				new Object[] { uid });

		return true;
	}

	public NetObject receiveGhostConnectionPackets(NetObject netObject) {
		System.out.println("receiving dummy packets " + netObject);
		
		return netObject;
	}
}
