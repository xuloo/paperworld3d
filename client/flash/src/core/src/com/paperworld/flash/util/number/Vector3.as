package com.paperworld.flash.util.number
{
	import org.papervision3d.core.math.Number3D;

	public class Vector3 extends Number3D
	{
		public function Vector3(x:Number=0, y:Number=0, z:Number=0)
		{
			super(x, y, z);
		}
		
		public function setMagnitude(s:Number):void 
		{
			
		}
		
		public function distance(n:Number3D):Number 
		{
			return 0;
		}
		
		public function dot(v:Vector3):Number
		{
			return 0;
		}
		
		public function cross(v:Vector3):Vector3
		{
			return null;
		}
		
		public function clear():void
		{
			
		}
		
		public function get magnitude():Number 
		{
			return 0;
		}
		
		public static function vectorBetween(v1:Vector3, v2:Vector3):Vector3
		{
			return null;
		}
		
		public function isZero():Boolean
		{
			return false;
		}
		
		public function returnDivision(s:Number):Vector3
		{
			return null;
		}
		
		public function get squareMagnitude():Number 
		{
			return 0;
		}
		
		public function returnScale(s:Number):Vector3
		{
			return null;
		}
		
		public function normalise():void 
		{
			
		}
		
		public function equals(other:Vector3):Boolean
		{
			return false;
		}
	}
}