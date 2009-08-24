package org.flashmonkey.flash.api
{	
	public interface IAvatar
	{
		/**
		 * The unique id for this avatar - generated by the server.
		 */
		function get id() : String;

		/**
		 * @private
		 */
		function set id(value : String) : void;
		
		function get object() : IPaperworldObject;

		function set object(value : IPaperworldObject) : void;

		function get time() : int;

		function set time(time : int) : void;

		function get input() : IInput;

		function set input(input : IInput) : void;

		function get state() : IState;

		function set state(state : IState) : void;
		
		function set behaviour(behaviour : IBehaviour) : void;
	}
}