package com.paperworld.java.impl;

import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

import com.paperworld.java.api.IService;

public class BaseService implements IService {

	protected MultiThreadedApplicationAdapter application;
	
	@Override
	public MultiThreadedApplicationAdapter getApplication() {
		return application;
	}

	@Override
	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
	}

	@Override
	public boolean appConnect(IConnection arg0, Object[] arg1) {
		return false;
	}

	@Override
	public void appDisconnect(IConnection arg0) {

	}

	@Override
	public boolean appJoin(IClient arg0, IScope arg1) {
		return false;
	}

	@Override
	public void appLeave(IClient arg0, IScope arg1) {

	}

	@Override
	public boolean appStart(IScope arg0) {
		return false;
	}

	@Override
	public void appStop(IScope arg0) {

	}

	@Override
	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		return false;
	}

	@Override
	public void roomDisconnect(IConnection arg0) {

	}

	@Override
	public boolean roomJoin(IClient arg0, IScope arg1) {
		return false;
	}

	@Override
	public void roomLeave(IClient arg0, IScope arg1) {

	}

	@Override
	public boolean roomStart(IScope arg0) {
		return false;
	}

	@Override
	public void roomStop(IScope arg0) {

	}

}
