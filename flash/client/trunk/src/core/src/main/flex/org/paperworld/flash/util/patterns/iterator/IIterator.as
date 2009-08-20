package com.paperworld.flash.util.patterns.iterator
{
	public interface IIterator
	{
		function hasNext():Boolean;
		
		function next():*;
		
		function size():int;
	}
}