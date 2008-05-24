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
	import com.paperworld.rpc.models.factories.ColladaModelFactory;
	import com.paperworld.rpc.models.factories.DAEModelFactory;
	
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;	

	public class ModelFactory
	{
		private static const PREFIX_KEY : String = "com.paperworld.games.util.";

		private static const SUFFIX_KEY : String = "ModelFactory";

		public function ModelFactory()
		{
		}

		public static function getFactory(key : String) : ModelFactory
		{
			//var FactoryClass:Class = getDefinitionByName(key + "ModelFactory") as Class;
			//var factory:ModelFactory = FactoryClass.getInstance() as ModelFactory;

			var factory : ModelFactory;

			switch (key)
			{
				case "Collada":
					{
					factory = ColladaModelFactory.getInstance();
					break;
				}
				case "DAE":
				{
					factory = DAEModelFactory.getInstance()
					break;
				}
			}

			return factory;
		}
		
		public static function getInstance():ModelFactory
		{
			return new ModelFactory();
		}
		
		public static function getModel(key:String, materials:MaterialsList = null, scale:Number = 1.0):DisplayObject3D 
		{
			var type:String = ModelManager.getInstance().getModelType(key);

			return getFactory(type).returnModel(key, materials, scale);
		}
		
		public function returnModel(key:String, materials:MaterialsList = null, scale:Number = 1.0):DisplayObject3D
		{
			return new DisplayObject3D();
		}
	}
}