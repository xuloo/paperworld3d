package com.paperworld.core.avatar.behaviour;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.util.DisplayObject3D;

public interface IAvatarBehaviour {
	public void update(AvatarInput input, AvatarState state, DisplayObject3D displayObject);
}
