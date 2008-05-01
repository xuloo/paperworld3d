/*
 * Copyright 2007 (c) Tim Knip, suite75.com.
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
 
package com.suite75.papervision3d.quake1
{
	import com.paperworld.logging.LoggerFactory;	
	import com.paperworld.logging.ILogger;	
	import com.suite75.quake1.io.*;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	import org.papervision3d.Papervision3D;
	import org.papervision3d.cameras.*;
	import org.papervision3d.core.geom.*;
	import org.papervision3d.core.geom.renderables.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.special.CompositeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	public class QuakeEngine extends Sprite
	{
		/** Papervision scene. */
		public var scene:Scene3D;
		
		/** Papervision camera. */
		public var camera:FrustumCamera3D;
		
		/** Papervision viewport */
		public var viewport:Viewport3D;
		
		/** Papervision renderer */
		public var renderer:BasicRenderEngine
		
		/** The Quake BSP map. */
		public var map:TriangleMesh3D;
		
		private var logger : ILogger;

		/**
		 * Constructor.
		 */
		public function QuakeEngine()
		{
			logger = LoggerFactory.getLogger(this);
			
			init();
		}
		
		/**
		 * Initialize.
		 */ 
		protected function init():void
		{
			Papervision3D.log( "" );
			Papervision3D.log( "Quake Engine v0.1" );
			
			this.viewport = new Viewport3D(800, 600);
			
			addChild(this.viewport);
			
			this.renderer = new BasicRenderEngine();
			this.scene = new Scene3D();
			
			this.camera = new FrustumCamera3D(this.viewport, 90, 1, 8000);	
			
			_camPos = new Vertex3D();
			
			_createdFaces = new Dictionary(true);
			
			//addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		
		/**
		 * Loads a BSP map from disk.
		 * 
		 * @param	mapName
		 */
		public function loadMap(mapName:String):void
		{
			_reader = new BspReader();
			_reader.addEventListener(Event.COMPLETE, onBspComplete);
			_reader.addEventListener(ProgressEvent.PROGRESS, onBspProgress);
			_reader.load(mapName);
		}
		
		/**
		 * 
		 * @param	event
		 */
		public function render( ):void
		{
			if(this.map)
			{
				_camPos.x = this.camera.x;
				_camPos.y = this.camera.y;
				_camPos.z = this.camera.z;
				
				showVisibleMeshes();
			}
			
			this.renderer.renderScene(scene, camera, viewport);
			
			//dispatchEvent(event.clone());
		}
		
		/**
		 * Build a mesh for a leaf. 
		 * 
		 * @param	leaf
		 * @param	index
		 * 
		 * @return	The created mesh. @see org.papervision3d.core.geom.TriangleMesh3D
		 */ 
		private function buildLeafMesh(leaf:BspLeaf, index:int):TriangleMesh3D
		{
			var mesh:TriangleMesh3D = new TriangleMesh3D(null, [], [], "leaf_" + index);
			var model:BspModel = this._reader.models[0] as BspModel;
			
			for(var i:int = 0; i < leaf.nummarksurfaces; i++ )
			{
				var faceIndex:int = _reader.marksurfaces[leaf.firstmarksurface + i];
				var surface:BspFace = _reader.faces[model.firstface + faceIndex];
				var material:MaterialObject3D;
				var polygon:Array = new Array();
				var uvs:Dictionary = new Dictionary(true);
				
				// prevent creation of duplicate triangles!
				if(_createdFaces[ surface ])
					continue;	
				_createdFaces[ surface ] = true;
				
				// get texture info	
				var texInfo:BspTexInfo = this._reader.tex_info[surface.texture_info];
				
				// texture axis
				var u:Number3D = new Number3D(texInfo.u_axis[0], texInfo.u_axis[1], texInfo.u_axis[2]);
				var v:Number3D = new Number3D(texInfo.v_axis[0], texInfo.v_axis[1], texInfo.v_axis[2]);
				
				// loop over the edges
				for(var j:int = 0; j < surface.num_edges; j++)
				{
					var idx:int = this._reader.surfedges[surface.first_edge + j];
					
					var edge_idx:int = idx < 0 ? -idx : idx;
					var edge:BspEdge = this._reader.edges[edge_idx];
					var coord:int = idx < 0 ? edge.endvertex : edge.startvertex;
					
					// get the Quake-vertex
					var pt:Array = this._reader.vertices[coord];

					// create PV3D vertex
					var vertex:Vertex3D = new Vertex3D(pt[0], pt[1], pt[2]);

					// create PV3D texcoord
					uvs[vertex] = buildTexCoord(vertex, texInfo);
					
					// save vertex for triangulation
					polygon.push(vertex);
					
					// setup the polygon's material
					material = _bitmapMaterials[texInfo.miptex];
				}
				
				// fix uvs
				fixUV(surface, uvs);
				
				// need to triangulate...
				var triangles:Array = triangulate(polygon);
				
				for(var k:int = 0; k < triangles.length; k++ )
				{
					var p0:Vertex3D = triangles[k][0] as Vertex3D;
					var p1:Vertex3D = triangles[k][1] as Vertex3D;
					var p2:Vertex3D = triangles[k][2] as Vertex3D;
					
					mesh.geometry.vertices.push(p0, p1, p2);
					 
					var t0:NumberUV = uvs[ p0 ];
					var t1:NumberUV = uvs[ p1 ];
					var t2:NumberUV = uvs[ p2 ];
					/*
					var bbox:Object = faceBoundingBox(p0, p1, p2);
					
					if(surface.lightmap_offset >= 0 && material && material.bitmap)
					{
						// got a lightmap!
						//var cmat:CompositeMaterial = new CompositeMaterial();
						//cmat.addMaterial(new BitmapMaterial(material.bitmap.clone()));
						//cmat.addMaterial(new BitmapMaterial(buildLightMap(surface, bbox, material.bitmap)));
						var bm:BitmapData = buildLightMap(surface, bbox, material.bitmap);
						
						material = new BitmapMaterial(bm);
					}
					*/
					var triangle:Triangle3D = new Triangle3D(mesh, [p0, p1, p2], material, [t0, t1, t2]);
					
					mesh.geometry.faces.push(triangle);
				}
			}
			
			mesh.mergeVertices();
			mesh.geometry.ready = true;
			
			_leafMeshes[ index ] = this.map.addChild(mesh);
			
			return mesh;
		}
		
		private function buildLightMap(surface:BspFace, bbox:Object, bitmap:BitmapData):BitmapData
		{
			var plane:BspPlane = _reader.planes[ surface.plane ];
			
			var sizes:Array = [];
			if(plane.type == 0 || plane.type == 3)
				sizes = [bbox.size.y, bbox.size.z];
			else if(plane.type == 1 || plane.type == 4)
				sizes = [bbox.size.x, bbox.size.z];
			else
				sizes = [bbox.size.x, bbox.size.y];
					
			var lightmaps:Array = _reader.lightmaps;
			var i:int = surface.lightmap_offset;
			var w:int = (sizes[0] >> 4) + 1;
			var h:int = (sizes[1] >> 4) + 1;
			var lightmap:BitmapData = new BitmapData(w, h, true, 0xff000000);
			
			for(var y:int = 0; y < h; y++)
			{
				for(var x:int = 0; x < w; x++)
				{
					var c:int = lightmaps[i];
					var color:uint = c << 24 | c << 16 | c << 8 | c;
					lightmap.setPixel32(x, y, color);
				}
			}
			
			var bm:BitmapData = bitmap.clone();
			var matrix:Matrix = new Matrix();
			
			matrix.scale(16, 16);
		
			bm.draw(lightmap, matrix, null, BlendMode.OVERLAY);
			
			return bm;
		}
		
		/**
		 * Builds materials.
		 * 
		 * @param	instance The DisplayObject3D to create the materials for.
		 */ 
		private function buildMaterials(instance:DisplayObject3D):void
		{
			if(!this._reader || !this._reader.textures)
				return;
				
			_bitmapMaterials = new Array();
			instance.materials = instance.materials || new MaterialsList();
			
			for(var i:int = 0; i < this._reader.textures.length; i++)
			{
				var texture:BspTexture = this._reader.textures[i];
				if(!texture || !texture.bitmap)
					continue;
					
				var name:String = texture.name;
				var material:BitmapMaterial = new BitmapMaterial(texture.bitmap);

				if(name.indexOf("+") != -1 || name.indexOf("*") != -1)
					name = name.substr(1);
				
				material.name = name;
					
				_bitmapMaterials.push(instance.materials.addMaterial(material, name));
			}
		}
		
		/**
		 * 
		 * @param	vertex
		 * @param	tex		Texture info. @see com.suite75.quake1.io.BspTexInfo
		 */ 
		private function buildTexCoord(vertex:Vertex3D, tex:BspTexInfo):NumberUV
		{
			var n:Number3D = vertex.toNumber3D(),
				u:Number3D = new Number3D(tex.u_axis[0], tex.u_axis[1], tex.u_axis[2]),
				v:Number3D = new Number3D(tex.v_axis[0], tex.v_axis[1], tex.v_axis[2]),
				uv:NumberUV = new NumberUV();
			
			uv.u = Number3D.dot(n, u) + tex.u_offset;
			uv.v = -(Number3D.dot(n, v) + tex.v_offset);
			
			return uv;
		}
		
		/**
		 * 
		 */ 
		private function calcSurfaceExtents(face:BspFace, uvs:Array):void
		{
			// get texture info	
			var tex:BspTexInfo = this._reader.tex_info[ face.texture_info ],
				ns:Number3D = new Number3D(tex.u_axis[0], tex.u_axis[1], tex.u_axis[2]),
				nt:Number3D = new Number3D(tex.v_axis[0], tex.v_axis[1], tex.v_axis[2]),
				uv:NumberUV;
				
			face.min_s = face.min_t = Number.MAX_VALUE;
	        face.max_s = face.max_t = Number.MIN_VALUE;
	            
            for each(uv in uvs)
            {
                face.min_s = Math.min(face.min_s, uv.u);
                face.min_t = Math.min(face.min_t, uv.v);
                face.max_s = Math.max(face.max_s, uv.u);
                face.max_t = Math.max(face.max_t, uv.v);
            }
            
            face.size_s = face.max_s - face.min_s;
            face.size_t = face.max_t - face.min_t;
		}
		
		/**
		 * Finds the leaf containing the the player.
		 * 
		 * @param	playerPosition
		 * 
		 * @return	Index into the leaves Array.
		 */
		private function findLeaf(playerPosition:Vertex3D):int
		{
			var idx:int = BspModel( this._reader.models[0] ).headnode[0];
			var pt:Number3D = playerPosition.toNumber3D();	
			while( idx >= 0 )
			{
				var node:BspNode = this._reader.nodes[idx] as BspNode;
				var plane:BspPlane = this._reader.planes[node.planenum];	
				var normal:Number3D = new Number3D(plane.a, plane.b, plane.c);
				var dot:Number = Number3D.dot(normal, pt) - plane.d;
				idx = dot >= 0 ? node.children[0] : node.children[1];
			}
			return -(idx+1);
		}
		
		/**
		 * Shows or hides meshes depending on current player (=camera) position.
		 */
		private function showVisibleMeshes():void
		{
			var idx:int = findLeaf(_camPos);
			
			if(idx == _curLeaf || !idx)
				return;
				
			_curLeaf = idx;

			trace("player is now in leaf #" + _curLeaf);
			
			if(!_curLeaf)
				return;
				
			for(var i:int = 0; i < _reader.leaves.length; i++)
			{
				if(_leafMeshes[i])
					_leafMeshes[i].visible = false;
			}
			
			showVisibleLeaves(_curLeaf);
		}
		
		/**
		 * Renders a leaf, and all leaves that are visible 
		 * from that leaf. Uses Quake's Possible Visible Set (PVS).
		 * @see com.suite75.quake1.io.BspReader#visibility
		 * 
		 * @param	leafIndex
		 */
		private function showVisibleLeaves(leafIndex:int):void
		{
			var leaf:BspLeaf = _reader.leaves[leafIndex];
			var numleafs:int = _reader.leaves.length;
			var visisz:Array = _reader.visibility;
			var v:int = leaf.visofs;
			var i:int, bit:int;
			
			if(!_leafMeshes[leafIndex])
				buildLeafMesh(leaf, leafIndex);
			
			var playerZ:Number = leaf.mins[2] + 60;
			
			this.camera.z = playerZ;
			
			_leafMeshes[leafIndex].visible = true;
			
			for(i = 1; i < numleafs; v++)
			{
				if(visisz[v] == 0)
				{
					// value 0, leaves invisible: skip some leaves
					i += 8 * visisz[v + 1];    	
					v++;
				}
				else
				{
					// tag 8 leaves if needed, examine bits right to left
					for(bit = 1; bit < 0xff && i < numleafs; bit = bit * 2, i++)
					{
						if(visisz[v] & bit)
						{
							_reader.leaves[i].visible = true;
							if(!_leafMeshes[i])
								buildLeafMesh(_reader.leaves[i], i);
							_leafMeshes[i].visible = true;
						}
					}
				}
			}
		}
        
		/**
		 * Fired when the BSP map is loaded.
		 * 
		 * @param	event
		 */
		protected function onBspComplete( event:Event ):void
		{
			// allocate space for meshes, a mesh for each leaf.
			_leafMeshes = new Array(_reader.leaves.length);
			
			var ent:BspEntity = this._reader.entities.findEntityByClassName("info_player_start");
			
			_camPos = new Vertex3D(ent.origin[0], ent.origin[1], ent.origin[2]);
			
			camera.x = _camPos.x;
			camera.y = _camPos.y;
			camera.z = _camPos.z;
			camera.rotationX = -90;
			
			logger.info( "info_player_start: " + _camPos.x + "," + _camPos.y + "," + _camPos.z  );
			
			this.map = new TriangleMesh3D(null, [], [], "q1-map");
			
			buildMaterials(this.map);
			
			this.scene.addChild(map);
			
			this.camera.yaw(0);
			
			dispatchEvent(event.clone());
		}
		
		/**
		 * Fired on BSP map loading progress.
		 * 
		 * @param	event
		 */
		protected function onBspProgress( event:ProgressEvent ):void
		{
		}
		
		/**
         * Create a bounding box for a triangle.
         * 
         * @param	triangle
         */
        private function faceBoundingBox(v0:Vertex3D, v1:Vertex3D, v2:Vertex3D):Object
        {
        	var bbox:Object = new Object();
        	bbox.min = new Number3D(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
        	bbox.max = new Number3D(Number.MIN_VALUE, Number.MIN_VALUE, Number.MIN_VALUE);
  			bbox.size = new Number3D();
  			
        	bbox.min.x = Math.min(Math.min(v0.x, v1.x), v2.x);
        	bbox.min.y = Math.min(Math.min(v0.y, v1.y), v2.y);
        	bbox.min.z = Math.min(Math.min(v0.z, v1.z), v2.z);
        	bbox.max.x = Math.max(Math.max(v0.x, v1.x), v2.x);
        	bbox.max.y = Math.max(Math.max(v0.y, v1.y), v2.y);
        	bbox.max.z = Math.max(Math.max(v0.z, v1.z), v2.z);
        	
        	bbox.size.x = bbox.max.x - bbox.min.x;
        	bbox.size.y = bbox.max.y - bbox.min.y;
        	bbox.size.z = bbox.max.z - bbox.min.z;
        	
        	return bbox;
        }
        
		/**
         * Fixes texture coordinates.
         * 
         * @param       face
         * @param       uvs
         */
        private function fixUV(face:BspFace, uvs:Dictionary):void
        {
        	var uv:NumberUV;
        	
            face.min_s = face.min_t = Number.MAX_VALUE;
            face.max_s = face.max_t = Number.MIN_VALUE;
            
            for each(uv in uvs)
            {
                face.min_s = Math.min(face.min_s, uv.u);
                face.min_t = Math.min(face.min_t, uv.v);
                face.max_s = Math.max(face.max_s, uv.u);
                face.max_t = Math.max(face.max_t, uv.v);
            }
            
            face.size_s = face.max_s - face.min_s;
            face.size_t = face.max_t - face.min_t;

            for each(uv in uvs)
            {
                uv.u -= face.min_s;
                uv.v -= face.min_t;
                
                uv.u /= face.size_s;
                uv.v /= face.size_t;
                
               // uv.v = 1 - uv.v;
            }
        }
        
		/**
		 * Triangulates a polygon.
		 * 
		 * @param	points	Array of Vertex3D or Number3D
		 * 
		 * @return	Array of triangles, each triangle an Array of three points.
		 */
		private function triangulate(points:Array):Array
		{
			var result:Array = new Array();
			result.push([points[0], points[1], points[2]]);
			for( var i:int = 2; i < points.length; i++ )
				result.push( [points[0], points[i], points[(i+1) % points.length]] );
			return result;			
		}
		
		private var _reader:BspReader;
		
		private var _curLeaf:int;
		
		private var _bitmapMaterials:Array;
		
		private var _camPos:Vertex3D;
		
		private var _leafMeshes:Array;
		
		private var _createdFaces:Dictionary;
	}
}