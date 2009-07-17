package com.paperworld.java.api;

import org.red5.server.adapter.IApplication;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;

public interface IService extends IApplication {

	public MultiThreadedApplicationAdapter getApplication();
	public void setApplication(MultiThreadedApplicationAdapter application);
}
