﻿/*
 * PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 * AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 * PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 * ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 * RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 * ______________________________________________________________________
 * papervision3d.org + blog.papervision3d.org + osflash.org/papervision3d
 *
 * Copyright 2006 (c) Carlos Ulloa Matesanz, noventaynueve.com.
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
 
package org.papervision3d.objects.parsers
{
	import flash.display.BitmapData;
	import flash.events.*;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.papervision3d.materials.shaders.FlatShader;
	import org.papervision3d.materials.shaders.GouraudShader;
	import org.papervision3d.materials.shaders.LightShader;
	import org.papervision3d.materials.shaders.PhongShader;
	import org.papervision3d.materials.shaders.ShadedMaterial;
	import org.papervision3d.materials.shaders.Shader;
	import org.papervision3d.Papervision3D;
	
	import org.ascollada.ASCollada;
	import org.ascollada.core.*;
	import org.ascollada.fx.*;
	import org.ascollada.io.DaeReader;
	import org.ascollada.types.*;
	import org.ascollada.utils.Logger;
	import org.papervision3d.core.*;
	import org.papervision3d.core.animation.controllers.*;
	import org.papervision3d.core.animation.core.*;
	import org.papervision3d.core.geom.*;
	import org.papervision3d.core.geom.renderables.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.core.proto.*;
	import org.papervision3d.events.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.shadematerials.*;
	import org.papervision3d.materials.special.*;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;


	import org.papervision3d.objects.parsers.ascollada.Node3D;
	import org.papervision3d.objects.parsers.ascollada.Skin3D;
	import org.papervision3d.materials.special.LineMaterial;

	import org.papervision3d.objects.parsers.ascollada.*;
	import org.papervision3d.lights.PointLight3D;


	/**
	 * @author Tim Knip
	 */
	public class DAE extends DisplayObject3D
	{		
		/** Default scale, used when no scale was set. */
		public static var DEFAULT_SCALE:Number = 100;
		
		/** Full filename. */
		public var filename:String;
		
		/** File title. */
		public var fileTitle:String;
		
		/** Base url. */
		public var baseUrl:String;
		
		/** ASCollada document. @see org.ascollada.core.DaeDocument */
		public var document:DaeDocument;
		
		/** Does the collada contain animations? */
		public var hasAnimations:Boolean = false;
		
		/** The first skin found in the file. */
		public var skin:Skin3D;
		
		/**
		 * 
		 * @param	asset
		 * @param	async
		 * @return
		 */
		public function DAE( async:Boolean = false ):void
		{
			super();
			
			_reader = new DaeReader(async);
			
			this.name = "DAE_" + this.id;
		}
		
		/**
		 * Sets the 3D scale as applied from the registration point of the object.
		 */
		override public function set scale( scale:Number ):void
		{
			super.scaleX = scale;
			super.scaleY = scale;
			super.scaleZ = -scale;
			_loadScaleSet = true;
		}
		
		/**
		 * Gets the 3D scale as applied from the registration point of the object.
		 */
		override public function get scale():Number
		{
			if( super.scaleX == super.scaleY && super.scaleX == -super.scaleZ )
				return super.scaleX;
			else
				return NaN;
		}
		
		/**
		 * Gets the scale along the local Z axis as applied from the registration point of the object.
		 */
		override public function get scaleZ():Number
		{
			return super.scaleZ;
		}
	
		/**
		 * Sets the scale along the local Z axis as applied from the registration point of the object.
		 */
		override public function set scaleZ( scale:Number ):void
		{
			super.scaleZ = -scale;
			_loadScaleSet = true;
		}
		
		/**
		 * Clones this DAE. NOTE: only works for simple dae's. Skinning, animation, etc. is still unsupported.
		 * 
		 * @return	The clone DAE.
		 */
		public function clone():DAE
		{
			var dae:DAE = new DAE();
			
			cloneObj( dae, this._rootNode );
			
			_numClones++;
			
			return dae;
		}
		
		/**
		 * Loads a Collada file from url, xml or bytearray.
		 * 
		 * @param	asset		Url, XML or ByteArray
		 * @param	materials	Optional MaterialsList.
		 */
		public function load(asset:*, materials:MaterialsList = null ):void
		{
			this.materials = materials || new MaterialsList();
			this.buildFileInfo(asset);
			_asset = asset;
			
			if( _asset is ByteArray || _asset is XML )
			{
				if( !this._reader.hasEventListener(Event.COMPLETE) )
					this._reader.addEventListener(Event.COMPLETE, buildScene);
					
				this._reader.loadDocument(_asset);
			}
			else
			{
				doLoad( String(_asset) );
			}
		}
		
		/**
		 * 
		 * @param	url
		 * @return
		 */
		protected function doLoad( url:String ):void
		{
			this.filename = url;
			
			_reader.addEventListener( Event.COMPLETE, buildScene );
			_reader.addEventListener( ProgressEvent.PROGRESS, loadProgressHandler );
			_reader.addEventListener( IOErrorEvent.IO_ERROR, handleIOError,false, 0, true );
			_reader.read(filename);
		}
		
		/**
		 * Gets a child by name recursively.
		 * 
		 * @param	name
		 * @return
		 */
		override public function getChildByName( name:String ):DisplayObject3D
		{
			return findChildByName(this, name);
		}
		
		/**
		 * Replaces a material by its name.
		 * 
		 * @param	material
		 * @param	name
		 * @return
		 */
		public function replaceMaterialByName( material:MaterialObject3D, name:String ):void
		{
			if( !this.materials )
			{
				return;
			}	
			
			var existingMaterial:MaterialObject3D = this.materials.getMaterialByName(name);
			if( existingMaterial )
			{
				if( this.material === existingMaterial )
					this.material = material;
				existingMaterial = this.materials.removeMaterial(existingMaterial);
				existingMaterial.unregisterObject(this);
				
				material = this.materials.addMaterial(material, name);
				
				updateMaterials(this, existingMaterial, material);
			}
		}
		
		/**
		 * Sets the material for a child DisplayObject3D.
		 * 
		 * @param child		A child DisplayObject3D of this DAE.
		 * @param material	The new material for the child.
		 * 
		 * @return A Boolean value indicating success.
		 */
		public function setChildMaterial( child : DisplayObject3D, material : MaterialObject3D ) : Boolean {
			
			if( !child ) {
				Papervision3D.log( "Object with name: '" + child.name + "' is not a child of this DAE!");
				return false;
			}
			
			var maxRecurse:uint = 10;
			var cnt:uint = 0;
			var target:DisplayObject3D = child;
			var geom:GeometryObject3D = null;
			
			while( !geom && ++cnt < maxRecurse ) {
				if( target.geometry && target.geometry.faces && target.geometry.faces.length ) {
					geom = target.geometry;
				} else {
					for each( var c:DisplayObject3D in target.children ) {
						target = c;
						break;
					}
				}
			}
			
			if( !geom ) {
				Papervision3D.log( "Couldn't find any geometry!" );
				return false;
			}
			
			target.material = material
			for each( var triangle:Triangle3D in geom.faces ) {
				triangle.material = material;
			}

			return true;
		}
		
		/**
		 * Sets the material for a child DisplayObject3D by the child's name.
		 * 
		 * @param childName The name of the DisplayObject3D.
		 * @param material	The new material for the child.
		 * 
		 * @return A Boolean value indicating success.
		 */
		public function setChildMaterialByName( childName : String, material : MaterialObject3D ) : Boolean {
			return this.setChildMaterial( getChildByName(childName), material );
		}
		
		/**
		 * Bakes all transforms of a joint into single matrices.
		 * 
		 * @param	joint
		 * @param	channels
		 * @return
		 */
		private function bakeJointMatrices( joint:Node3D, keys:Array, channels:Array ):Array
		{
			var matrices:Array = new Array();
						
			for( var i:int = 0; i < keys.length; i++ )
			{
				var matrix:Matrix3D = Matrix3D.IDENTITY;
				
				for( var j:int = 0; j < joint.transforms.length; j++ )
				{
					var transform:DaeTransform = joint.transforms[j];
					
					// check for a key at this time
					var m:Matrix3D = findChannelMatrix(channels, transform.sid, keys[i]);
					
					if( m )
						matrix = Matrix3D.multiply(matrix, m);
					else
						matrix = Matrix3D.multiply(matrix, new Matrix3D(transform.matrix));
				}
							
				matrices.push(matrix);
			}

			return matrices;
		}
		
		/**
		 * 
		 * @param	joint
		 * @return
		 */
		private function buildAnimations( node:DisplayObject3D ):void
		{				
			var joint:Node3D = node as Node3D;
			
			var channels:Array = null;
			if( joint )
			{
				channels = findAnimationChannelsByID(joint.daeSID);
				if( !channels.length )
					channels = findAnimationChannelsByID(joint.daeID);
			}

			if( channels && channels.length )
			{
				var keys:Array = buildAnimationKeys(channels);
				var baked:Boolean = false;
				
				for( var i:int = 0; i < channels.length; i++ )
				{
					var channel:DaeChannel = channels[i];
					
					// fetch the transform this channel is targeting
					var transform:DaeTransform = findTransformBySID(joint, channel.syntax.targetSID);
				
					if( !transform )
						throw new Error( "no transform targeted by channel : " + channel.syntax.targetSID );
					
					// build animation matrices (Array) from channel outputs
					var matrices:Array = transform.buildAnimatedMatrices(channel);
						
					// #keys and #matrices *should* be equal
					if( matrices.length != channel.input.length )
						continue;
						//throw new Error( "matrices.length != channel.input.length" );

					channel.output = matrices;		
					
					if( channels.length == 1 && transform.type == ASCollada.DAE_MATRIX_ELEMENT )
					{
						// dealing with a matrix node, no need to bake!
						try
						{
							buildAnimationController(joint, keys, matrices);
						}
						catch( e:Error )
						{
							Logger.error( "[ERROR] " + joint.name + "\n" + channel.syntax  );
						}
						baked = true;
						break;
					}
				}
				
				if( !baked )
				{
					// need to bake matrices
					var ms:Array = bakeJointMatrices(joint, keys, channels);
					
					joint.copyTransform(ms[0]);
					
					buildAnimationController(joint, keys, ms);
				}
			}
			
			for each( var child:DisplayObject3D in node.children )
				buildAnimations( child );
		}
		
		/**
		 * 
		 * @param	joint
		 * @param	keys
		 * @param	matrices
		 * @return
		 */
		private function buildAnimationController( joint:Node3D, keys:Array, matrices:Array ):void
		{
			var mats:Array = new Array(matrices.length);
			
			var ctl:SimpleController = new SimpleController(joint, SimpleController.TRANSFORM);
			
			for(var i:int = 0; i < matrices.length; i++)
			{
				var j:int = (i+1) % matrices.length;
				
				mats[i] = matrices[i] is Matrix3D ? matrices[i] : new Matrix3D(matrices[i]);
				
				var keyframe0:int = AnimationEngine.secondsToFrame(keys[i]);
				var keyframe1:int = AnimationEngine.secondsToFrame(keys[j]);
				var duration:uint = j > 0 ? keyframe1 - keyframe0 : 10;
				
				var frame:AnimationFrame = new AnimationFrame(keyframe0, duration, [mats[i]]);
				
				ctl.addFrame(frame);
			}
			
			joint.addController(ctl);
		}
		
		/**
		 * 
		 * @param	channels
		 * @return
		 */
		private function buildAnimationKeys( channels:Array ):Array
		{
			var keys:Array = new Array();
			var tmp:Array = new Array();
			var obj:Object = new Object();
			var i:int, j:int;
			
			for( i = 0; i < channels.length; i++ )
			{
				var channel:DaeChannel = channels[i];
				for( j = 0; j < channel.input.length; j++ )
				{
					if( !(obj[ channel.input[j] ]) )
					{
						obj[ channel.input[j] ] = true;
						tmp.push( {time:channel.input[j]} );
					}
				}
			}
			
			tmp.sortOn("time", Array.NUMERIC);
			
			for( i = 0; i < tmp.length; i++ )
				keys.push( tmp[i].time );
				
			return keys;
		}
		
		/**
		 * 
		 * @return
		 */
		private function buildColor( daeColor:Array ):uint
		{
			var r:uint = daeColor[0] * 0xff;
			var g:uint = daeColor[1] * 0xff;
			var b:uint = daeColor[2] * 0xff;
			return (r<<16|g<<8|b);
		}
		
		/**
		 * 
		 * @param	primitive
		 * @param	geometry
		 * @param	instance
		 * @param	material
		 * 
		 * @return
		 */
		private function buildFaces( primitive:DaePrimitive, geometry:GeometryObject3D, instance:DisplayObject3D, material:MaterialObject3D = null ):void
		{
			var i:int, j:int, k:int;
			
			material = _materialInstances[primitive.material] || material;
			
			material = material || MaterialObject3D.DEFAULT;
			/*
			if( !instance.materials )
				instance.materials = new MaterialsList();
				
			if( !instance.materials.getMaterialByName(primitive.material) )
			{
				instance.materials.addMaterial(material, primitive.material);
			}
			*/
			var texcoords:Array = new Array();
			
			// retreive correct texcoord-set for the material.
			var obj:DaeBindVertexInput = _materialTextureSets[primitive.material] is DaeBindVertexInput ? _materialTextureSets[primitive.material] : null;
			var setID:int = (obj is DaeBindVertexInput) ? obj.input_set : 0;
			var texCoordSet:Array = primitive.getTexCoords(setID); 
			
			// texture coords
			for( i = 0; i < texCoordSet.length; i++ ) 
			{
				var t:Array = texCoordSet[i];
				texcoords.push( new NumberUV( t[0], t[1] ) );
			}
			
			var hasUV:Boolean = (texcoords.length == primitive.vertices.length);

			var idx:Array = new Array();
			var v:Array = new Array();
			var uv:Array = new Array();
			
			switch( primitive.type ) 
			{
				// Each line described by the mesh has two vertices. The first line is formed 
				// from first and second vertices. The second line is formed from the third and fourth 
				// vertices and so on.
				case ASCollada.DAE_LINES_ELEMENT:
					for( i = 0; i < primitive.vertices.length; i += 2 ) 
					{
						v[0] = geometry.vertices[ primitive.vertices[i] ];
						v[1] = geometry.vertices[ primitive.vertices[i+1] ];
						uv[0] = hasUV ? texcoords[  i  ] : new NumberUV();
						uv[1] = hasUV ? texcoords[ i+1 ] : new NumberUV();
						//geometry.faces.push( new Triangle3D(instance, [v[0], v[1], v[1]], material, [uv[0], uv[1], uv[1]]) );
					}
					break;
					
				// Each line-strip described by the mesh has an arbitrary number of vertices. Each line 
				// segment within the line-strip is formed from the current vertex and the preceding 
				// vertex.
				case ASCollada.DAE_LINESTRIPS_ELEMENT:
					for( i = 1; i < primitive.vertices.length; i++ ) 
					{
						v[0] = geometry.vertices[ primitive.vertices[i-1] ];
						v[1] = geometry.vertices[ primitive.vertices[i] ];
						uv[0] = hasUV ? texcoords[i-1] : new NumberUV();
						uv[1] = hasUV ? texcoords[i] : new NumberUV();
						//geometry.faces.push( new Triangle3D(instance, [v[0], v[1], v[1]], material, [uv[0], uv[1], uv[1]]) );
					}
					break;
					
				// simple triangles
				case ASCollada.DAE_TRIANGLES_ELEMENT:
					for( i = 0, j = 0; i < primitive.vertices.length; i += 3, j++ ) 
					{
						idx[0] = primitive.vertices[i];
						idx[1] = primitive.vertices[i+1];
						idx[2] = primitive.vertices[i+2];
						
						v[0] = geometry.vertices[ idx[0] ];
						v[1] = geometry.vertices[ idx[1] ];
						v[2] = geometry.vertices[ idx[2] ];
						
						uv[0] = hasUV ? texcoords[ i+0 ] : new NumberUV();
						uv[1] = hasUV ? texcoords[ i+1 ] : new NumberUV();
						uv[2] = hasUV ? texcoords[ i+2 ] : new NumberUV();
						
						geometry.faces.push( new Triangle3D(instance, [v[0], v[1], v[2]], material, [uv[0], uv[1], uv[2]]) );
					}
					break;
				
				// Each triangle described by the mesh has three vertices. 
				// The first triangle is formed from the first, second, and third vertices. 
				// Each subsequent triangle is formed from the current vertex, reusing the 
				// first and the previous vertices.
				case ASCollada.DAE_TRIFANS_ELEMENT:
					v[0] = geometry.vertices[ primitive.vertices[0] ];
					v[1] = geometry.vertices[ primitive.vertices[1] ];
					v[2] = geometry.vertices[ primitive.vertices[2] ];
					uv[0] = hasUV ? texcoords[0] : new NumberUV();
					uv[1] = hasUV ? texcoords[1] : new NumberUV();
					uv[2] = hasUV ? texcoords[2] : new NumberUV();
					
					geometry.faces.push( new Triangle3D(instance, [v[0], v[1], v[2]], material, [uv[0], uv[1], uv[2]]) );
					
					for( i = 3; i < primitive.vertices.length; i++ ) 
					{
						v[1] = geometry.vertices[ primitive.vertices[i-1] ];
						v[2] = geometry.vertices[ primitive.vertices[i] ];
						uv[1] = hasUV ? texcoords[i-1] : new NumberUV();
						uv[2] = hasUV ? texcoords[i] : new NumberUV();
						
						geometry.faces.push( new Triangle3D(instance, [v[0], v[1], v[2]], material, [uv[0], uv[1], uv[2]]) );
					}
					break;
				
				// Each triangle described by the mesh has three vertices. The first triangle 
				// is formed from the first, second, and third vertices. Each subsequent triangle 
				// is formed from the current vertex, reusing the previous two vertices.
				case ASCollada.DAE_TRISTRIPS_ELEMENT:
					v[0] = geometry.vertices[ primitive.vertices[0] ];
					v[1] = geometry.vertices[ primitive.vertices[1] ];
					v[2] = geometry.vertices[ primitive.vertices[2] ];
					uv[0] = hasUV ? texcoords[0] : new NumberUV();
					uv[1] = hasUV ? texcoords[1] : new NumberUV();
					uv[2] = hasUV ? texcoords[2] : new NumberUV();
					
					geometry.faces.push( new Triangle3D(instance, [v[0], v[1], v[2]], material, [uv[0], uv[1], uv[2]]) );
					
					for( i = 3; i < primitive.vertices.length; i++ ) 
					{
						v[0] = geometry.vertices[ primitive.vertices[i-2] ];
						v[1] = geometry.vertices[ primitive.vertices[i-1] ];
						v[2] = geometry.vertices[ primitive.vertices[i] ];
						uv[0] = hasUV ? texcoords[i-2] : new NumberUV();
						uv[1] = hasUV ? texcoords[i-1] : new NumberUV();
						uv[2] = hasUV ? texcoords[i] : new NumberUV();
						
						geometry.faces.push( new Triangle3D(instance, [v[0], v[1], v[2]], material, [uv[0], uv[1], uv[2]]) );
					}
					break;
					
				// polygon with *no* holes
				case ASCollada.DAE_POLYLIST_ELEMENT:
					for( i = 0, k = 0; i < primitive.vcount.length; i++ ) 
					{
						var poly:Array = new Array();
						var uvs:Array = new Array();
						for( j = 0; j < primitive.vcount[i]; j++ ) 
						{
							uvs.push( (hasUV ? texcoords[ k ] : new NumberUV()) );
							poly.push( geometry.vertices[primitive.vertices[k++]] );
						}
						
						if( !geometry || !geometry.faces || !geometry.vertices )
							throw new Error( "no geomotry" );
						if( !instance )
							throw new Error( "no instance" );
							
						v[0] = poly[0];
						uv[0] = uvs[0];
						
						for( j = 1; j < poly.length - 1; j++ )
						{
							v[1] = poly[j];
							v[2] = poly[j+1];
							uv[1] = uvs[j];
							uv[2] = uvs[j+1];
							geometry.faces.push( new Triangle3D( instance, [v[0], v[1], v[2]], material, [uv[0], uv[1], uv[2]]) );
						}
					}
					break;
				
				// polygon with holes...
				case ASCollada.DAE_POLYGONS_ELEMENT:
					break;
					
				default:
					break;
			}
		}
		
		/**
		 * 
		 * @param	asset
		 * @return
		 */
		private function buildFileInfo( asset:* ):void
		{
			this.filename = asset is String ? String(asset) : "./meshes/rawdata_dae";
			
			// make sure we've got forward slashes!
			this.filename = this.filename.split("\\").join("/");
				
			if( this.filename.indexOf("/") != -1 )
			{
				// dae is located in a sub-directory of the swf.
				var parts:Array = this.filename.split("/");
				this.fileTitle = String( parts.pop() );
				this.baseUrl = parts.join("/");
			}
			else
			{
				// dae is located in root directory of swf.
				this.fileTitle = this.filename;
				this.baseUrl = "";
			}
		}
		
		/**
		 * 
		 * @param	daeId
		 * @param	instance
		 * @return
		 */
		private function buildGeometry( daeId:String, instance:DisplayObject3D, material:MaterialObject3D = null ):Boolean
		{
			var geom:DaeGeometry = document.geometries[ daeId ];
			
			if( !geom )
				return false;
				
			if( geom.mesh )
			{
				instance.geometry = instance.geometry ? instance.geometry : new GeometryObject3D();
				
				var geometry:GeometryObject3D = instance.geometry;
					
				geometry.vertices = buildVertices(geom.mesh);
				geometry.faces = new Array();
				
				for( var i:int = 0; i < geom.mesh.primitives.length; i++ )
					buildFaces(geom.mesh.primitives[i], geometry, instance, material);
					
				geometry.ready = true;
				
				Logger.trace( "created geometry v:" + geometry.vertices.length + " f:" + geometry.faces.length );
				
				return true;
			}
			
			return false;
		}
		
		/**
		 *
		 * @return
		 */
		private function buildImagePath( meshFolderPath:String, imgPath:String ):String
		{
			var baseParts:Array = meshFolderPath.split("/");
			var imgParts:Array = imgPath.split("/");
			
			while( baseParts[0] == "." )
				baseParts.shift();
				
			while( imgParts[0] == "." )
				imgParts.shift();
				
			while( imgParts[0] == ".." )
			{
				imgParts.shift();
				baseParts.pop();
			}
						
			var imgUrl:String = baseParts.length > 1 ? baseParts.join("/") : (baseParts.length?baseParts[0]:"");
						
			imgUrl = imgUrl != "" ? imgUrl + "/" + imgParts.join("/") : imgParts.join("/");
			
			return imgUrl;
		}
		
		/**
		 * 
		 * @return
		 */
		private function buildMaterials():void
		{
			var symbol2target:Object = document.materialSymbolToTarget;
				
			for( var materialId:String in document.materials )
			{
				var mat:DaeMaterial = document.materials[ materialId ];
				var exists:Boolean = false;
				
				for ( var name:String in this.materials.materialsByName )
				{
					if( symbol2target[name] == mat.id )
					{
						exists = true;
						break;
					}
				}
				
				if( exists )
					continue;
				
				var effect:DaeEffect = document.effects[ mat.effect ];
				
				var lambert:DaeLambert = effect.color as DaeLambert;
				
				if(lambert && lambert.diffuse.texture)
				{
					_materialTextureSets[mat.id] = lambert.diffuse.texture.texcoord;
				}
				
				var material:MaterialObject3D;
				
				if( effect && effect.texture_url )
				{				
					var img:DaeImage = document.images[effect.texture_url];
					if( img )
					{
						var path:String = buildImagePath(this.baseUrl, img.init_from);
						material = new BitmapFileMaterial( path );
						material.tiled = true;
						material.addEventListener( FileLoadEvent.LOAD_COMPLETE, materialCompleteHandler );
						material.addEventListener( FileLoadEvent.LOAD_ERROR, materialErrorHandler );
						this.materials.addMaterial(material, mat.id );
						continue;
					}
				}					
				
				if( lambert && lambert.diffuse.color )
				{
					material = new ColorMaterial( buildColor(lambert.diffuse.color)/*, lambert.transparency*/ );
				}
				else
				{
					material = MaterialObject3D.DEFAULT;
				}
				
				this.materials.addMaterial(material, mat.id );
			}
		}
		
		/**
		 * builds material instances from loaded materials.
		 * 
		 * @param 	instances	Array of DaeInstanceMaterial. @see org.ascollada.fx.DaeInstanceMaterial
		 * @return
		 */
		private function buildMaterialInstances(instances:Array):MaterialObject3D
		{
			var firstMaterial:MaterialObject3D;
			
			for each( var instance_material:DaeInstanceMaterial in instances )
			{
				var material:MaterialObject3D = this.materials.getMaterialByName(instance_material.symbol);
					
				if( !material )
					material = this.materials.getMaterialByName(instance_material.target);
				
				if( !material )
					continue;
					
				_materialInstances[instance_material.symbol] = material;
				
				if( !firstMaterial )
					firstMaterial = material;
					
				// setup texcoord-set for the material.
				if(	_materialTextureSets[instance_material.target] )
				{
					var semantic:String = _materialTextureSets[instance_material.target];			
					var obj:DaeBindVertexInput = instance_material.findBindVertexInput(semantic);	
					if( obj )
						_materialTextureSets[instance_material.symbol] = obj;
				}
			}
			
			return firstMaterial;
		}
		
		/**
		 * builds a papervision Matrix3D from a node's matrices array. @see org.ascollada.core.DaeNode#transforms
		 * 
		 * @param	node
		 * 
		 * @return
		 */
		private function buildMatrix( node:DaeNode ):Matrix3D 
		{
			var matrix:Matrix3D = Matrix3D.IDENTITY;
			for( var i:int = 0; i < node.transforms.length; i++ ) 
			{
				var transform:DaeTransform = node.transforms[i];
				
				matrix = Matrix3D.multiply( matrix, new Matrix3D(transform.matrix) );
			}	
			return matrix;
		}
		
		/**
		 * 
		 * @param	node
		 * @return
		 */
		private function buildMatrixStack( node:DaeNode ):Array
		{
			var stack:Array = new Array();
			for( var i:int = 0; i < node.transforms.length; i++ ) 
			{
				var transform:DaeTransform = node.transforms[i];				
				var matrix:Matrix3D = new Matrix3D(transform.matrix);
				stack.push(matrix);
			}
			return stack;
		}
		
		/**
		 * 
		 * @param	instance_controller
		 * @param	instance
		 * @return
		 */
		private function buildMorph( instance_controller:DaeInstanceController, instance:AnimatedMesh3D ):void
		{
			var controller:DaeController = document.controllers[instance_controller.url];
			var morph:DaeMorph = controller.morph;
		
			var success:Boolean = buildGeometry(morph.source, instance);
			
			if( !success )
			{
				Logger.error("[ERROR] could not find geometry for morph!");
				throw new Error("could not find geometry for morph!");
			}

			var ctl:MorphController = new MorphController(instance.geometry);
			
			var target0:DisplayObject3D = new DisplayObject3D();
			buildGeometry(morph.source, target0);
			
			var frame:uint = 0;
			var duration:uint = AnimationEngine.NUM_FRAMES / morph.targets.length;
			
			// use a copy of the original vertices!
			ctl.addFrame(new AnimationFrame(frame, duration, target0.geometry.vertices, "start"));
			
			frame += duration;
			
			for( var i:int = 0; i < morph.targets.length; i++ )
			{
				var obj:DisplayObject3D = new DisplayObject3D();
							
				var target:String = morph.targets[i];
				var weight:Number = morph.weights[i];
				
				buildGeometry(target, obj);
				
				ctl.addFrame(new AnimationFrame(frame, duration, obj.geometry.vertices, target));
				frame += duration;
			}
			
			instance.addController(ctl);
			
			_morphs[ instance ] = true;
		}
		
		/**
		 * 
		 * @param	node
		 * @return
		 */
		private function buildNode( node:DaeNode, parent:DisplayObject3D ):void
		{				
			var instance_controller :DaeInstanceController = findSkinController(node);
			var instance_ctl_morph :DaeInstanceController = findMorphController(node);
			
			var newNode:DisplayObject3D;
			var instance:DisplayObject3D;
			var material:MaterialObject3D;
						
			if( instance_controller )
			{
				buildMaterialInstances(instance_controller.materials);
				newNode = buildSkin(instance_controller, material);
				
				if( newNode )
				{
					instance = parent.addChild(newNode);
				}
			}
			else if( instance_ctl_morph ) 
			{
				buildMaterialInstances(instance_ctl_morph.materials);
				
				newNode = new AnimatedMesh3D(material, new Array(), new Array(), node.id);
					
				buildMorph(instance_ctl_morph, newNode as AnimatedMesh3D);
	
				instance = parent.addChild(newNode);
			}
			else if( node.geometries.length )
			{
				newNode = new Node3D(node.name, node.id, node.sid);

				for each( var geomInst:DaeInstanceGeometry in node.geometries )
				{
					material = buildMaterialInstances(geomInst.materials);
					
					var inst:TriangleMesh3D = new TriangleMesh3D(material, new Array(), new Array());
					
					buildGeometry(geomInst.url, inst, material);
					
					newNode.addChild(inst);
				}
				
				instance = parent.addChild(newNode);
				Node3D(instance).matrixStack = buildMatrixStack(node);
				Node3D(instance).transforms = node.transforms;
			}
			else
			{
				instance = parent.addChild(new Node3D(node.name, node.id, node.sid));
				Node3D(instance).matrixStack = buildMatrixStack(node);
				Node3D(instance).transforms = node.transforms;
			}
			
			for( var j:int = 0; j < node.instance_nodes.length; j++ )
			{
				var instance_node:DaeInstanceNode = node.instance_nodes[j];
				var dae_node:DaeNode = document.getDaeNodeById(instance_node.url);
				buildNode(dae_node, instance);
			}
			
			for( var i:int = 0; i < node.nodes.length; i++ )
				buildNode(node.nodes[i], instance);
				
			var matrix:Matrix3D = buildMatrix(node);
						
			instance.copyTransform( matrix );
		}
		
		/**
		 * 
		 * @param	event
		 * @return
		 */
		private function buildScene( event:Event ):void
		{
			if( _reader.hasEventListener(Event.COMPLETE) )
				_reader.removeEventListener(Event.COMPLETE, buildScene);
				
			this.document = _reader.document;
			
			_yUp = (this.document.asset.yUp == ASCollada.DAE_Y_UP);
			_materialInstances = new Object();
			_materialTextureSets = new Object();
			_skins = new Dictionary();
			_morphs = new Dictionary();
			
			buildMaterials();
			
			buildVisualScene();
			
			linkSkins(this._rootNode);
			
			readySkins(this);
			readyMorphs(this);
			
			if( !_loadScaleSet )
				this.scale = DEFAULT_SCALE;
			
			// there may be animations left to parse...
			if( document.numQueuedAnimations )
			{
				hasAnimations = true;
				_reader.addEventListener( Event.COMPLETE, animationCompleteHandler );
				_reader.addEventListener( ProgressEvent.PROGRESS, animationProgressHandler );
				
				_reader.readAnimations();
			}
			else
				hasAnimations = false;
			
			// done with geometry
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * 
		 * @param	instance_controller
		 * @return
		 */
		private function buildSkin( instance_controller:DaeInstanceController, material:MaterialObject3D = null ):TriangleMesh3D
		{
			var controller:DaeController = document.controllers[ instance_controller.url ];
			
			if( !controller || !controller.skin )
			{
				Logger.trace( "[WARNING] no skin controller!" );
				return null;
			}
			
			var skin:DaeSkin = controller.skin;
			
			var obj:Skin3D = new Skin3D(material, new Array(), new Array(), skin.source, (document.yUp == DaeDocument.Y_UP));
			
			obj.bindPose = new Matrix3D(skin.bind_shape_matrix);	

			obj.joints = new Array();
			
			var success:Boolean = buildGeometry(skin.source, obj);
				
			// geometry could reside in a morph controller
			if( !success && document.controllers[skin.source] )
			{
				var morph_controller:DaeController = document.controllers[skin.source];
				if( morph_controller.morph )
				{
					success = buildGeometry(morph_controller.morph.source, obj);
					
					if( success )
					{
						var ctl:MorphController = new MorphController(obj.geometry);
						
						var method:String = morph_controller.morph.method;
						var duration:int = AnimationEngine.NUM_FRAMES / morph_controller.morph.targets.length;
						var frame:uint = 0;
						
						for( var i:int = 0; i < morph_controller.morph.targets.length; i++ )
						{
							var morph:DisplayObject3D = new DisplayObject3D();
							
							var target:String = morph_controller.morph.targets[i];
							var weight:Number = morph_controller.morph.weights[i];
							
							var morph_succes:Boolean = buildGeometry(target, morph);
							
							if( morph_succes )
							{
								ctl.addFrame(new AnimationFrame(frame, duration, morph.geometry.vertices, target));
								frame += duration;
								//obj.morph_targets.push( morph.geometry );
								//obj.morph_weights.push( weight );
							}
						}
						
						obj.addController(ctl);
					}
				}
			}
			
			if( !success )
			{
				Logger.error( "[ERROR] could not find geometry for skin!" );
				throw new Error( "could not find geometry for skin!" );
			}
			
			obj.geometry.ready = true;
			
			_skins[ obj ] = instance_controller;
			
			if( !this.skin )
				this.skin = obj;
			
			return obj;
		}
				
		/**
		 * 
		 * @param	spline
		 * @return
		 */
		private function buildSpline( spline:DaeSpline ):DisplayObject3D
		{
			var lines:Lines3D = new Lines3D(new LineMaterial(0xffff00, 0.5));
					
			for( var i:int = 0; i < spline.vertices.length; i++ )
			{
				var v0:Array = spline.vertices[i];
				var v1:Array = spline.vertices[(i+1) % spline.vertices.length];
				lines.addNewLine(0, v0[0], v0[1], v0[2], v1[0], v1[1], v1[2]);
			}
			
			return lines;
		}
		
		/**
		 * 
		 * @param	mesh
		 * @return
		 */
		private function buildVertices( mesh:DaeMesh ):Array
		{
			var vertices:Array = new Array();
			
			for( var i:int = 0; i < mesh.vertices.length; i++ )
			{
				var v:Array = mesh.vertices[i];
				
				vertices.push(new Vertex3D(v[0], v[1], v[2]));
			}
			
			return vertices;
		}

		/**
		 * Builds the visual scene (scenegraph).
		 */
		private function buildVisualScene():void
		{
			this._rootNode = addChild(new DisplayObject3D("COLLADA_root"));
			
			for( var i:int = 0; i < document.vscene.nodes.length; i++ )
				buildNode(document.vscene.nodes[i], this._rootNode);
		}
		
		
		/**
		 * Clones the source and append the clone to target. Then recurse...
		 * 
		 * @param	target
		 * @param	source
		 */
		private function cloneObj( target:DisplayObject3D, source:DisplayObject3D ):void
		{
			var o:DisplayObject3D;
			
			if( source === _rootNode )
			{
				o = new DisplayObject3D( source.name + "-" + _numClones );
				o.copyTransform( source.transform );
				target = target.addChild(o);
			}
			else if( source is TriangleMesh3D )
			{
				o = new TriangleMesh3D(source.material, new Array(), new Array(), source.name + "-" + _numClones);
				o.geometry = cloneGeometry(o, source.geometry);
				o.geometry.ready = true;
				target = target.addChild(o);
			}
			else if( source is Node3D )
			{
				var n:Node3D = source as Node3D;
				
				o = new Node3D(n.name + "-" + _numClones, n.daeID, n.daeSID);
				o.copyTransform(n.transform);
				target = target.addChild(o);
			}
			else if( source is DisplayObject3D )
			{
				o = new DisplayObject3D(source.name + "-" + _numClones);
				o.copyTransform(source.transform);
				target = target.addChild(o);
			}
			
			for each( var child:DisplayObject3D in source.children )
			{
				cloneObj(target, child);
			}
		}
		
		/**
		 * Clones a GeometryObject3D an sets up the faces for target.
		 * 
		 * @param	target	The target for the cloned faces and vertices.
		 * @param	source	The source GeometryObject3D.
		 * 
		 * @return	GeometryObject3D
		 */
		private function cloneGeometry( target:DisplayObject3D, source:GeometryObject3D ):GeometryObject3D
		{			
			var geom:GeometryObject3D = new GeometryObject3D();
			
			var vertices:Array = source.vertices;
			var faces:Array = source.faces;
			var i:int;
			var newVerts:Dictionary = new Dictionary();
			
			geom.vertices = new Array();
			geom.faces = new Array();
			
			for( i = 0; i < vertices.length; i++ )
			{
				var v:Vertex3D = vertices[i];
				newVerts[ v ] = v.clone();
				geom.vertices.push( newVerts[ v ] );
			}
			
			for( i = 0; i < faces.length; i++ )
			{
				var f:Triangle3D = faces[i];
				
				var v0:Vertex3D = newVerts[ f.v0 ];
				var v1:Vertex3D = newVerts[ f.v1 ];
				var v2:Vertex3D = newVerts[ f.v2 ];
				
				var uv0:NumberUV = f.uv[0].clone();
				var uv1:NumberUV = f.uv[1].clone();
				var uv2:NumberUV = f.uv[2].clone();
				
				var newTri:Triangle3D = new Triangle3D(target, [v0, v1, v2], f.material, [uv0, uv1, uv2]);
				
				geom.faces.push( newTri );
			}
			
			return geom;
		}
		
		/**
		 * 
		 * @param	id
		 * @return
		 */
		private function findAnimationChannelsByID( id:String ):Array
		{
			var channels:Array = new Array();
		
			try
			{
				for each( var animation:DaeAnimation in document.animations )
				{
					for each( var channel:DaeChannel in animation.channels )
					{
						var target:String = channel.target.split("/").shift() as String;
						if( target == id )
							channels.push(channel);
					}
				}
			}
			catch( e:Error )
			{
				
			}
			return channels;
		}
		
		/**
		 * 
		 * @param	channels
		 * @param	sid
		 * @param	time
		 * @return
		 */
		private function findChannelMatrix( channels:Array, sid:String, time:Number = 0 ):Matrix3D
		{
			try
			{
				for( var i:int = 0; i < channels.length; i++ )
				{
					var channel:DaeChannel = channels[i];
					if( channel.syntax.targetSID == sid )
					{
						for( var j:int = 0; j < channel.input.length; j++ )
						{
							var t:Number = channel.input[j];
													
							if( t == time )
								return new Matrix3D(channel.output[j]);
								
							if( t > time )
								break;
						}
					}
				}
			}
			catch( e:Error )
			{
				Papervision3D.log( "[WARNING] Could not find channel matrix for SID=" + sid );
			}
			return null;
		}
		
		/**
		 * Finds a child by dae-ID or dae-SID.
		 * 
		 * @param	node
		 * @param	daeID
		 * @param	bySID
		 * @return
		 */
		private function findChildByID(node:DisplayObject3D, daeID:String, bySID:Boolean = false):DisplayObject3D
		{	
			if( node is Node3D )
			{
				if( bySID && Node3D(node).daeSID == daeID )
					return node;
				else if( !bySID && Node3D(node).daeID == daeID )
					return node;
			}
			for each(var child:DisplayObject3D in node.children ) 
			{
				var n:DisplayObject3D = findChildByID(child, daeID, bySID);
				if( n )
					return n;
			}
			
			return null;			
		}
		
		/**
		 * Finds a child by name.
		 * 
		 * @param	node
		 * @param	name
		 * @return
		 */
		private function findChildByName(node:DisplayObject3D, name:String):DisplayObject3D
		{
			if( node.name == name )
				return node;

			for each(var child:DisplayObject3D in node.children ) 
			{
				var n:DisplayObject3D = findChildByName(child, name);
				if( n )
					return n;
			}
			
			return null;
		}
		
		/**
		 * Finds the top-most Node3D in the scenegraph.
		 * 
		 * @param	node The node to start searching.
		 * 
		 * @return The found Node3D or null on failure.
		 */
		private function findRootNode(node:DisplayObject3D):Node3D
		{
			if( node is Node3D )
				return Node3D(node);
				
			for each(var child:DisplayObject3D in node.children ) 
			{
				var n:DisplayObject3D = findRootNode(child);
				if( n is Node3D )
					return Node3D(n);
			}
			
			return null;
		}
		
		/**
		 * 
		 * @param	node
		 * @param	sid
		 * @return
		 */
		private function findTransformBySID( node:Node3D, sid:String ):DaeTransform
		{
			for each( var transform:DaeTransform in node.transforms )
			{
				if( transform.sid == sid )
					return transform;
			}
			return null;
		}
		
		/**
		 * Attempts to find a morph-controller for a node.
		 * 
		 * @param	node	The DaeNode. @see org.ascollada.core.DaeNode
		 * 
		 * @return The controller found, or null if not found. @see org.ascollada.core.DaeInstanceController
		 */
		private function findMorphController( node:DaeNode ):DaeInstanceController
		{
			for each( var controller:DaeInstanceController in node.controllers )
			{
				var control:DaeController = document.controllers[controller.url];
				if( control.morph )
					return controller;
			}
			return null;
		}
		
		/**
		 * Attempts to find a skin-controller for a node.
		 * 
		 * @param	node	The DaeNode. @see org.ascollada.core.DaeNode
		 * 
		 * @return The controller found, or null if not found. @see org.ascollada.core.DaeInstanceController
		 */
		private function findSkinController( node:DaeNode ):DaeInstanceController
		{
			for each( var controller:DaeInstanceController in node.controllers )
			{
				var control:DaeController = document.controllers[controller.url];
				if( control.skin )
					return controller;
			}
			return null;
		}
			
		/**
		 * Links a skin to its bones.
		 * 
		 * @param	skin	The Skin3D to link.
		 * @param	instance_controller
		 * @return
		 */
		private function linkSkin(skin:Skin3D, instance_controller:DaeInstanceController):void
		{
			var controller:DaeController = document.controllers[ instance_controller.url ];
			
			var daeSkin:DaeSkin = controller.skin;

			var found:Object = new Object();
			
			skin.joints = new Array();
			skin.skeletons = new Array();

			// <instance_controller> node can have 0 <skeleton> nodes...
			// so we simply push the 'top' node ID into the skeletons array.
			if( !instance_controller.skeletons.length )
			{
				var node:Node3D = findRootNode(this);
				
				if( node )
					instance_controller.skeletons.push(node.daeID);
				else
					throw new Error( "instance_controller doesn't have a skeleton node, and no _rootNode could be found!" );
			}
			
			// the skeletons array contains the ID of nodes to start searching for our bones.
			for(var i:int = 0; i < instance_controller.skeletons.length; i++ )
			{				
				var skeletonId:String = instance_controller.skeletons[i];
				var skeletonNode:DisplayObject3D;
				
				// there should be a DO3D in our scenegraph
				skeletonNode = findChildByID(this, skeletonId);
				if( !skeletonNode )
				{
					Papervision3D.log( "[ERROR] could not find skeleton: " + skeletonId );
					throw new Error( "could not find skeleton: " + skeletonId);
				}		
				
				// save a reference of the skeleton to Skin3D
				skin.skeletons.push(skeletonNode);

				// loop over all bones for this skin
				for( var j:int = 0; j < daeSkin.joints.length; j++ )
				{
					var jointId:String = daeSkin.joints[j];
					
					// make sure we don't add this bone twice
					if( found[jointId] )
						continue;
						
					// the bone *should* be a child of the skeleton
					var joint:Node3D = findChildByID(skeletonNode, jointId) as Node3D;
					if( !joint )
						joint = findChildByID(skeletonNode, jointId, true) as Node3D;
					if( !joint )
						joint = findChildByID(this, jointId, true) as Node3D;
					if( !joint )
					{
						Papervision3D.log( "[ERROR] could not find joint: " + jointId + " " + skeletonId);
						throw new Error( "could not find joint: " + jointId + " " + skeletonId);
					}
					
					// the bone *should* have a bindmatrix
					var bindMatrix:Array = daeSkin.findJointBindMatrix2(jointId);
					if( !bindMatrix )
					{
						Papervision3D.log( "[ERROR] could not find bindmatrix for joint: " + jointId);
						throw new Error( "could not find bindmatrix for joint: " + jointId );
					}	
					joint.bindMatrix = new Matrix3D(bindMatrix);
					
					// the bone *should* have vertex weights
					joint.blendVerts = daeSkin.findJointVertexWeightsByIDOrSID(jointId);
					if( !joint.blendVerts )
					{
						Papervision3D.log( "[ERROR] could not find influences for joint: " + jointId );
						throw new Error( "could not find influences for joint: " + jointId );
					}	
					
					skin.joints.push(joint);
					
					found[jointId] = joint;
				}
			}
			
			var ctl:SkinController = new SkinController(skin, _yUp);
			
			skin.addController(ctl);
		}
		
		/**
		 * Links all skins with its bones etc.
		 * 
		 * @param	do3d
		 * @return
		 */
		private function linkSkins( do3d:DisplayObject3D ):void
		{
			if( _skins[ do3d ] is DaeInstanceController && do3d is Skin3D )
				linkSkin(do3d as Skin3D, _skins[do3d]);
				
			for each( var child:DisplayObject3D in do3d.children )
				linkSkins(child);
		}
		
		
		
		/**
		 * 
		 * @param	do3d
		 * @return
		 */
		private function readyMorphs( do3d:DisplayObject3D ):void
		{
			//if( do3d is AnimatedMesh3D )
			//	AnimatedMesh3D(do3d).play();
			//for each( var child:DisplayObject3D in do3d.children )
			//	readyMorphs(child);
		}
		
		/**
		 * 
		 * @param	do3d
		 * @return
		 */
		private function readySkins( do3d:DisplayObject3D ):void
		{
		//	if( do3d is Skin3D )
		//		Skin3D(do3d).animate = true;
		//	for each( var child:DisplayObject3D in do3d.children )
		//		readySkins(child);
		}
				
		/**
		 * 
		 * @param	do3d
		 * @param	existingMaterial
		 * @param	newMaterial
		 * @return
		 */
		private function updateMaterials( do3d:DisplayObject3D, existingMaterial:MaterialObject3D, newMaterial:MaterialObject3D ):void
		{
			existingMaterial.unregisterObject(do3d);
			
			if( do3d.material === existingMaterial )
				do3d.material = newMaterial;
					
			if( do3d.geometry && do3d.geometry.faces && do3d.geometry.faces.length )
			{
				for each( var triangle:Triangle3D in do3d.geometry.faces )
				{
					if( triangle.material === existingMaterial )
						triangle.material = newMaterial;
				}
			}
			
			for each( var child:DisplayObject3D in do3d.children )
				updateMaterials( child, existingMaterial, newMaterial );
		}
		
		/**
		 * 
		 * @param	event
		 * @return
		 */
		private function animationCompleteHandler( event:Event ):void
		{
			buildAnimations(this);
			
			//this.controller.frameTime = 10;
			
			//this.controller.play();
		}
		
		/**
		 * Fired when an animation was loaded.
		 * 
		 * @param	event
		 */
		private function animationProgressHandler( event:ProgressEvent ):void
		{
			dispatchEvent(event);
		}
		
		/**
		 * Fired on collada file load progress.
		 * 
		 * @param	event
		 */
		private function loadProgressHandler( event:ProgressEvent ):void
		{
			dispatchEvent(event);
		}
		
		/**
		 * Fired when a material was succesfully loaded.
		 * 
		 * @param	event
		 */
		private function materialCompleteHandler( event:FileLoadEvent ):void
		{
			dispatchEvent(event);
		}
		
		/**
		 * Fired when an IOErrorEvent occured.
		 * 
		 * @param	event
		 */
		private function handleIOError( event:IOErrorEvent ):void
		{
			dispatchEvent(event);
		}
		
		/**
		 * Fired when a material failed to load.
		 * 
		 * @param	event
		 */
		private function materialErrorHandler( event:FileLoadEvent ):void
		{
			Logger.error( "[ERROR] a texture failed to load: " + event.file );
			dispatchEvent( event );
		}
		
		/** Parses the Collada file. @see org.ascollada.io.DaeReader. */
		private var _reader:DaeReader;
		
		/** Morphs. */
		private var _morphs:Dictionary;
		
		/** Skins. */
		private var _skins:Dictionary;
		
		/** */
		private var _materialInstances:Object;
		
		/** */
		private var _materialTextureSets:Object;
		
		/** Boolean indicating the Collada file's UP-axis is Y-up or not. */
		private var _yUp:Boolean;
		
		/** The asset passed to load. @see #load */
		private var _asset:*;
		
		/** */
		private var _rootNode:DisplayObject3D;
		
		/** Boolean indicating the DAE's scale was set before load. */
		private var _loadScaleSet:Boolean = false;
		
		private static var _numClones:uint = 0;
	}
}
