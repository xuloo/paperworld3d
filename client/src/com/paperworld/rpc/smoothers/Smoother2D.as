package com.paperworld.rpc.smoothers
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.data.AvatarState;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.math.Quaternion;
	
	public class Smoother2D extends AbstractSmoother
	{		
		private const toDEGREES :Number = 180/Math.PI;
		private const toRADIANS :Number = Math.PI/180;
		
		private var _rotationAxis:Number3D = new Number3D(0.0, 1.0, 0.0);
		
		private var logger:XrayLog = new XrayLog();
		
		public function Smoother2D()
		{
		}
		
		override public function smooth(from:AvatarState, to:AvatarState, tightness:Number):void
		{
			from.orientation = Quaternion.slerp( from.orientation, to.orientation, tightness );
			
			/*var angle:Number = from.rotation + (to.rotation - from.rotation) * tightness;
        	
        	var vector:Number3D = _rotationAxis.clone();
        	
        	var matrix:Matrix3D = new Matrix3D();
        	
        	Matrix3D.rotateAxis( from.transform, vector );
        	var rotationMatrix:Matrix3D = Matrix3D.rotationMatrix( vector.x, vector.y, vector.z, angle );
        	from.transform.calculateMultiply3x3( rotationMatrix, from.transform );*/
        	
        	//logger.info("\nangle: " + from.rotation);
			var matrix : Matrix3D = Matrix3D.quaternion2matrix( from.orientation.x, from.orientation.y, from.orientation.z, from.orientation.w );
        	
			matrix.n14 = from.transform.n14 + (to.transform.n14 - from.transform.n14) * tightness;
			matrix.n24 = from.transform.n24 + (to.transform.n24 - from.transform.n24) * tightness;
			matrix.n34 = from.transform.n34 + (to.transform.n34 - from.transform.n34) * tightness;
        	
			from.transform = matrix;
			//from.rotation = angle;
			//from.transform.copy(to.transform);
			
			/*from.orientation = Quaternion.slerp( from.orientation, to.orientation, tightness );
        	
			var matrix : Matrix3D = Matrix3D.quaternion2matrix( from.orientation.x, from.orientation.y, from.orientation.z, from.orientation.w );
        	
			matrix.n14 = from.transform.n14 + (to.transform.n14 - from.transform.n14) * tightness;
			matrix.n24 = from.transform.n24 + (to.transform.n24 - from.transform.n24) * tightness;
			matrix.n34 = from.transform.n34 + (to.transform.n34 - from.transform.n34) * tightness;
        	*/
			//from.transform = matrix;
			
			//logger.info("position: " + from.position);
		}
	}
}