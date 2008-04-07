package org.papervision3d.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import org.papervision3d.core.culling.DefaultParticleCuller;
	import org.papervision3d.core.culling.DefaultTriangleCuller;
	import org.papervision3d.core.culling.IParticleCuller;
	import org.papervision3d.core.culling.ITriangleCuller;
	import org.papervision3d.core.culling.RectangleParticleCuller;
	import org.papervision3d.core.culling.RectangleTriangleCuller;
	import org.papervision3d.core.culling.ViewportObjectFilter;
	import org.papervision3d.core.layers.RenderLayer;
	import org.papervision3d.core.layers.utils.RenderLayerManager;
	import org.papervision3d.core.render.IRenderEngine;
	import org.papervision3d.core.render.command.IRenderListItem;
	import org.papervision3d.core.render.command.RenderableListItem;
	import org.papervision3d.core.render.data.RenderHitData;
	import org.papervision3d.core.utils.InteractiveSceneManager;
	import org.papervision3d.events.RendererEvent;
	import org.papervision3d.render.BasicRenderEngine;
	
	/**
	 * @Author Ralph Hauwert
	 */
	 
	/* Changed to protected methods on 11/27/2007 by John */
	
	public class Viewport3D extends Sprite implements IViewport3D
	{
		//use namespace org.papervision3d.core.ns.pv3dview;
		protected var _width:Number;
		protected var _hWidth:Number;
		protected var _height:Number;
		protected var _hHeight:Number;
		
		protected var _autoClipping:Boolean;
		protected var _autoCulling:Boolean;
		protected var _autoScaleToStage:Boolean;
		protected var _interactive:Boolean;
		protected var _lastRenderer:IRenderEngine;
		protected var _viewportObjectFilter:ViewportObjectFilter;
		
		public var sizeRectangle:Rectangle;
		public var cullingRectangle:Rectangle;
		protected var _containerSprite:Sprite;
		
		public var triangleCuller:ITriangleCuller;
		public var particleCuller:IParticleCuller;
		public var lastRenderList:Array;
		public var interactiveSceneManager:InteractiveSceneManager;
		
		public var containers:Dictionary;
		
		public var renderLayerManager:RenderLayerManager;
		
		public function Viewport3D(viewportWidth:Number = 640, viewportHeight:Number = 480, autoScaleToStage:Boolean = false, interactive:Boolean = false, autoClipping:Boolean = true, autoCulling:Boolean = true)
		{
			super();
			
			this.interactive = interactive;
			init();
			
			this.viewportWidth = viewportWidth;
			this.viewportHeight = viewportHeight;
			
			this.autoClipping = autoClipping;
			this.autoCulling = autoCulling;
			
			this.autoScaleToStage = autoScaleToStage;
			
			
		}
		
		protected function init():void
		{
			containers = new Dictionary();
			lastRenderList = new Array();
			sizeRectangle = new Rectangle();
			cullingRectangle = new Rectangle();
			
			_containerSprite = new Sprite();
			
			addChild(_containerSprite);
			
			//SETUP THE RLM
			renderLayerManager = new RenderLayerManager();
			var def:RenderLayer = new RenderLayer();
			_containerSprite.addChild(def);
			renderLayerManager.addDefaultLayer(def);
			
			// ISM must be created AFTER adding containerSprite to the stage
			if( interactive ) interactiveSceneManager = new InteractiveSceneManager(this);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
				
		public function hitTestMouse():RenderHitData
		{
			var p:Point = new Point(containerSprite.mouseX, containerSprite.mouseY);
			return hitTestPoint2D(p);
		}
		
		public function hitTestPoint2D(point:Point):RenderHitData
		{
			if(interactive){
				var rli:RenderableListItem;
				var rhd:RenderHitData = new RenderHitData();
				var rc:IRenderListItem;
				for(var i:uint = lastRenderList.length; rc = lastRenderList[--i]; )
				{
					if(rc is RenderableListItem)
					{
						rli = rc as RenderableListItem;
						rhd = rli.hitTestPoint2D(point, rhd);
						
						if(rhd.hasHit)
						{				
							return rhd;
						}
					}
				}
			}
			
			return new RenderHitData();
		}
		
		protected function onAddedToStage(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize();
		}
		
		protected function onRemovedFromStage(event:Event):void
		{
			stage.removeEventListener(Event.RESIZE, onStageResize);
		}
		
		protected function onStageResize(event:Event = null):void
		{
			if(_autoScaleToStage){
				viewportWidth = stage.stageWidth;
				viewportHeight = stage.stageHeight;
			}
		}
		
		protected function handleRenderDone(e:RendererEvent):void
		{
			interactiveSceneManager.updateRenderHitData();
		}
		
		public function set lastRenderer(value:BasicRenderEngine):void
		{
			if( !interactive ) return;
			value.removeEventListener(RendererEvent.RENDER_DONE, handleRenderDone);
			value.addEventListener(RendererEvent.RENDER_DONE, handleRenderDone);
		}
		
		public function set viewportWidth(width:Number):void
		{
			_width = width;
			_hWidth = width/2;
			containerSprite.x = _hWidth;
			
			
			sizeRectangle.width = width;
			
			cullingRectangle.x = -_hWidth;
			cullingRectangle.width = width;
			
			scrollRect = sizeRectangle;
		}
		
		public function get viewportWidth():Number
		{
			return _width;
		}
		
		public function set viewportHeight(height:Number):void
		{
			_height = height;
			_hHeight = height/2;
			containerSprite.y = _hHeight;
			
			sizeRectangle.height = height;
			
			cullingRectangle.y = -_hHeight;
			cullingRectangle.height = height;
			
			scrollRect = sizeRectangle;
		}
		
		public function get viewportHeight():Number
		{
			return _height;
		}
		
		public function get containerSprite():Sprite
		{
			return _containerSprite;	
		}
		
		public function set autoClipping(clip:Boolean):void
		{
			if(clip){
				scrollRect = sizeRectangle;
			}else{
				scrollRect = null;
			}
			_autoClipping = clip;
		}
		
		public function get autoClipping():Boolean
		{
			return _autoClipping;	
		}
		
		public function set autoCulling(culling:Boolean):void
		{
			if(culling){
				triangleCuller = new RectangleTriangleCuller(cullingRectangle);
				particleCuller = new RectangleParticleCuller(cullingRectangle);
			}else if(!culling){
				triangleCuller = new DefaultTriangleCuller();
				particleCuller = new DefaultParticleCuller();
			}
			_autoCulling = culling;	
		}
		
		public function get autoCulling():Boolean
		{
			return _autoCulling;
		}
		
		public function set autoScaleToStage(scale:Boolean):void
		{
			_autoScaleToStage = scale;
			if(scale && stage != null){
				onStageResize();
			}
		}
		
		public function get autoScaleToStage():Boolean
		{
			return _autoScaleToStage;
		}
		
		public function set interactive(b:Boolean):void
		{
			_interactive = b;
		}
		
		public function get interactive():Boolean
		{
			return _interactive;
		}
		
		public function set viewportObjectFilter(vof:ViewportObjectFilter):void
		{
			_viewportObjectFilter = vof;
		}
		
		public function get viewportObjectFilter():ViewportObjectFilter
		{
			return _viewportObjectFilter;
		}
		
		public function updateBeforeRender():void
		{
			
			renderLayerManager.resetLayers();
			renderLayerManager.updateBeforeRender();
			
			lastRenderList.length = 0;
			_containerSprite.graphics.clear();
		
		}
		
		public function updateAfterRender():void
		{
			renderLayerManager.sortlayers(_containerSprite);
			renderLayerManager.updateAfterRender();
			
		}
		
		
		//EFFECT LAYER STUFF
		public function addRenderLayer(layer:RenderLayer):void{
			_containerSprite.addChild(layer);
			renderLayerManager.addRenderLayer(layer);
		}
		
		public function removeRenderLayer(layer:RenderLayer):void{
			_containerSprite.removeChild(layer);
			renderLayerManager.removeRenderLayer(layer);
			
		}

		
	}
}