package com.paperworld.rpc.smoothers
{
	import com.paperworld.rpc.data.AvatarState;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Quaternion;
	
	public class Smoother3D extends AbstractSmoother
	{	
		public function Smoother3D()
		{
		}

		override public function smooth(from:AvatarState, to:AvatarState, tightness:Number):void
		{						
			from.orientation = Quaternion.slerp( from.orientation, to.orientation, tightness );
        	
			var matrix : Matrix3D = Matrix3D.quaternion2matrix( from.orientation.x, from.orientation.y, from.orientation.z, from.orientation.w );
        	
			matrix.n14 = from.transform.n14 + (to.transform.n14 - from.transform.n14) * tightness;
			matrix.n24 = from.transform.n24 + (to.transform.n24 - from.transform.n24) * tightness;
			matrix.n34 = from.transform.n34 + (to.transform.n34 - from.transform.n34) * tightness;
        	
			from.transform = matrix;
		}
		
	}
}