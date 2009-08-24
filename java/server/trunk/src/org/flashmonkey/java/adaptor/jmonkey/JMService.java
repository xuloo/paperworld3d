package org.paperworld.java.adaptor.jmonkey;

import org.paperworld.java.api.IScene;
import org.paperworld.java.service.SimpleService;

/**
 * Extends the SimpleService class to provide an adaptor for a JMonkey scene.
 * 
 * @author Trevor
 *
 */
public class JMService extends SimpleService {
	
	IScene scene = new JMScene();
	
	public JMService() {
		
	}
}
