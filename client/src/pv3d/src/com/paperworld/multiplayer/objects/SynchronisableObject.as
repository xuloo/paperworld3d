package com.paperworld.multiplayer.objects 
{
	import org.papervision3d.objects.DisplayObject3D;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.math.Quaternion;		

	/**
	 * @author Trevor
	 */
	public class SynchronisableObject extends BaseClass implements Synchronizable 
	{
		public var object : DisplayObject3D;

		private var logger : XrayLog = new XrayLog( );

		public function SynchronisableObject(object : DisplayObject3D = null)
		{
			super( );
			
			this.object = object;
		}

		public function getObject() : *
		{
			return object;
		}

		public function synchronise(input : Input, state : State) : void
		{			
			//logger.info("synchronising object " + state.orientation.w);
			this.object.x = state.position.x;
			this.object.y = state.position.y;
			this.object.z = state.position.z;

			object.localRotationY = state.orientation.w;
		}

		override public function destroy() : void
		{
		}
	}
}
