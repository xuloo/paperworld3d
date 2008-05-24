package com.paperworld.rpc.objects 
{
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;	
	
	/**
	 * @author Trevor
	 */
	public interface IAvatarBehaviour 
	{
		function update(input : AvatarInput, state : AvatarState, displayObject : DisplayObject3D) : void;
		
		function destroy():void;
	}
}
