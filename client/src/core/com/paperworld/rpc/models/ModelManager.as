/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.rpc.models
{
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.utils.Dictionary;

	/**
	 * <p>Holds keyed references to all the models listed in the configuration file supplied at runtime.</p>
	 * 
	 * <p>Models are held in <code>Dictionary</code> instances - each type of model (e.g. Collada, Ase etc) has its
	 * own <code>Dictionary</code> containing all the models of that type keyed by the name supplied in the configuration file.</p>
	 */
	public class ModelManager 
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ModelManager(singleton : Singleton) 
		{
			$models = new Dictionary( );
		}

		/**
		 * Returns the Singleton instance of this class.
		 * 
		 * @return Singleton instance of ModelManager
		 */
		public static function getInstance() : ModelManager 
		{
			if ($instance == null) 
				$instance = new ModelManager( new Singleton( ) );

			return $instance;
		}

		/**
		 * Adds a model to the manager's list. Checks if a model of this type has already been
		 * supplied, if not creates a new <code>Dictionary</code> to store these types of models in.
		 * 
		 * @param key The name of the model being added. This name can be used to retrieve the model later.
		 * @param type The type of model being added (e.g. Collada, Ase, MD2 etc).
		 * @param value The loader object that was used to load the model. The model's data will be available from
		 * this object once the load has completed.
		 */
		public function addModel(key : String, type : String, value : EventDispatcher) : void
		{
			if ($models[type] == null) $models[type] = new Dictionary( );

			$models[type][key] = value;
		}

		/**
		 * Returns the type of model the supplied model key is a member of.
		 * 
		 * @param key The <code>String</code> name of the model we want to know the type of.
		 * 
		 * @return The type of model this model is a member of.
		 */
		public function getModelType(key : String) : String
		{
			for (var type:String in $models)
				for (var i:String in $models[type])
					if (i == key) return type	;					 
			
			return null;
		}

		/**
		 * Returns all the models of the type supplied.
		 * 
		 * @param type The <code>String</code> name of the type of model we want.
		 * 
		 * @return The <code>Dictionary</code> containing all the models of the supplied type.
		 */
		public function getModelsOfType(type : String) : Dictionary
		{
			return $models[type] as Dictionary;
		}

		/**
		 * Returns the data that represents the model requested.
		 * 
		 * @param key The name of the model requested.
		 * @param type The type of model requested.
		 * 
		 * @return The data for the model requested. Supplied as an 
		 * <code>XML</code> object that can be passed to the correct parser.
		 */
		public function getModel(key : String, type : String = null) : XML
		{
			var proxy : URLLoader = getModelsOfType( type )[key] as URLLoader;
		
			return new XML( proxy.data );
		}

		/**
		 * Removes a model from the list. Used to try and clean memory 
		 * out once a model is no longer required.
		 * 
		 * @param key the name of the model to be removed.
		 * 
		 * @return Whether or not the model has been removed successfully.
		 */
		public function removeModel(key : String) : Boolean
		{
			if ($models[key] == null) return false;
			
			delete $models[key];
			return true;
		}

		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * The Singleton instance of this class.
		 */	
		private static var $instance : ModelManager;

		/**
		 * The models are stored in a Dictionary.
		 */
		private var $models : Dictionary;
	}
}

class Singleton
{
}