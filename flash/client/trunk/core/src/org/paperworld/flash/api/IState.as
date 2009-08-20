package org.paperworld.flash.api
{
	import org.paperworld.flash.util.math.Quaternion;
	import org.paperworld.flash.util.math.Vector3f;
	
	public interface IState
	{
		function get position():Vector3f;		
		function set position(value:Vector3f):void;
		
		function get orientation():Quaternion;
		function set orientation(value:Quaternion):void;
		
		function clone():IState;
		function equals(other:IState):Boolean;
		function notEquals(other:IState):Boolean;
		function compare(other:IState):Boolean;
	}
}