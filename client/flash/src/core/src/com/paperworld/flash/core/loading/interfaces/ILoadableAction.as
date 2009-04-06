package com.paperworld.flash.core.loading.interfaces
{
	public interface ILoadableAction
	{
		function get bytesLoaded():int;
		
		function get bytesTotal():int;
		
		function get data():*;
	}
}