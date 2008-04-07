﻿/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org • blog.papervision3d.org • osflash.org/papervision3d
 */

/*
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

// ______________________________________________________________________
//                                               DisplayObjectContainer3D

package org.papervision3d.core.proto
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.Matrix3D;

/**
* The GeometryObject3D class contains the mesh definition of an object.
*/
	public class GeometryObject3D extends EventDispatcher
	{
		
		/**
		* Radius square of the mesh bounding sphere
		*/
		public function get boundingSphere2():Number
		{
			if( _boundingSphereDirty )
				return getBoundingSphere2();
			else
				return _boundingSphere2;
		}
	
		/**
		 * 
		 */
		public var dirty:Boolean;
		
		/**
		* An array of Face3D objects for the faces of the mesh.
		*/
		public var faces    :Array;
	
		/**
		* An array of vertices.
		*/
		public var vertices :Array;
		public var _ready:Boolean = false;
		
		public function transformVertices( transformation:Matrix3D ):void {}
	
		// ___________________________________________________________________________________________________
		//                                                                                               N E W
		// NN  NN EEEEEE WW    WW
		// NNN NN EE     WW WW WW
		// NNNNNN EEEE   WWWWWWWW
		// NN NNN EE     WWW  WWW
		// NN  NN EEEEEE WW    WW
	
		public function GeometryObject3D( initObject:Object=null ):void
		{
	
			this.dirty = true;
		}
	
	
		/**
		* Returns a string value representing the three-dimensional values in the specified Number3D object.
		*
		* @return	A string.
		*/
		//public function toString():String
		//{
			//return 'x:' + Math.floor(this.x) + ' y:' + Math.floor(this.y) + ' z:' + Math.floor(this.z);
		//}
	
		public function transformUV( material:MaterialObject3D ):void
		{
			if( material.bitmap )
				for( var i:String in this.faces )
					faces[i].transformUV( material );
		}
	
		public function getBoundingSphere2():Number
		{
			var max :Number = 0;
			var d   :Number;
	
			for each( var v:Vertex3D in this.vertices )
			{
				d = v.x*v.x + v.y*v.y + v.z*v.z;
	
				max = (d > max)? d : max;
			}
	
			this._boundingSphereDirty = false;
	
			return _boundingSphere2 = max;
		}
		
		private function createVertexNormals():void
		{
			var tempVertices:Dictionary = new Dictionary(true);
			var face:Triangle3D;
			var vertex3D:Vertex3D;
			for each(face in faces){
				face.v0.connectedFaces[face] = face;
				face.v1.connectedFaces[face] = face;
				face.v2.connectedFaces[face] = face;
				tempVertices[face.v0] = face.v0;
				tempVertices[face.v1] = face.v1;
				tempVertices[face.v2] = face.v2;
			}	
			for each (vertex3D in tempVertices){
				vertex3D.calculateNormal();
			}
		}
		
		public function set ready(b:Boolean):void
		{
			if(b){
				createVertexNormals();
				this.dirty = false;
			}
			_ready = b;
		}
	
		public function get ready():Boolean
		{
			return _ready;
		}
	
		// ___________________________________________________________________________________________________
		//                                                                                       P R I V A T E
		protected var _boundingSphere2     :Number;
		protected var _boundingSphereDirty :Boolean = true;
	}
}