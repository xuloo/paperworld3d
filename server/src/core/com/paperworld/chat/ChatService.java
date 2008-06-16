package com.paperworld.chat;

import java.util.ArrayList;

import org.red5.server.adapter.IApplication;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.red5.server.framework.Application;

import com.paperworld.core.PaperworldService;

public class ChatService implements IApplication{
		
	private ISharedObject so;
	
	private PaperworldService service;
	
	private Application application;
	
	public ChatService()
	{
	}
	
	private ISharedObject getSharedObject(IScope scope, String name) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);
		return service.getSharedObject(scope, name, false);
	}
	
	public boolean chatMessage(String username, String scene, String msg) {
		
		System.out.println("receiving message: " + msg + " from " + username);
		
		ISharedObject so = getSharedObject(Red5.getConnectionLocal().getScope(), scene + "Chat");
		
		so.beginUpdate();
		ArrayList<ChatMessage> messages = getMessagesForUser(so, username);
		System.out.println("message.size() " + messages.size());
		ChatMessage chatMessage = new ChatMessage(username, msg, messages.size());

		messages.add(chatMessage);
		
		so.setAttribute(username, messages);
		so.endUpdate();
		
		return true;
	}
	
	private ArrayList<ChatMessage> getMessagesForUser(ISharedObject so, String username) {
		//ISharedObject so = getSharedObject(Red5.getConnectionLocal().getScope());
		
		ArrayList<ChatMessage> chatMessages = (ArrayList<ChatMessage>) so.getAttribute(username);
		
		if (chatMessages == null)
		{
			chatMessages = new ArrayList<ChatMessage>();
			//so.setAttribute(username, chatMessages);
		}
		
		return chatMessages;
	}

	public boolean appConnect(IConnection arg0, Object[] arg1) {
		System.out.println("ChatService connecting");
		return false;
	}

	public void appDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub
		
	}

	public boolean appJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void appLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		
	}

	public boolean appStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	public void appStop(IScope arg0) {
		// TODO Auto-generated method stub
		
	}

	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub
		
	}

	public boolean roomJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		
	}

	public boolean roomStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomStop(IScope arg0) {
		// TODO Auto-generated method stub
		
	}
	
	public void setService(PaperworldService service) {
		this.service = service;
	}
	
	public void setApplication(Application a) {
		application = a;
		application.addListener(this);
	}
}
