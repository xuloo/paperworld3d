package com.paperworld.flash.core.patterns.iterator
{
	public interface IIterator
	{
		function hasNext():Boolean;
		
		function next():*;
		
		function size():int;
	}
}