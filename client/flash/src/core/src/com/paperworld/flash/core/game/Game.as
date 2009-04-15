package com.paperworld.flash.core.game
{
	import com.joeberkovitz.moccasin.document.MoccasinDocument;
	import com.joeberkovitz.moccasin.editor.LoadingPopup;
	import com.joeberkovitz.moccasin.event.OperationFaultEvent;
	import com.joeberkovitz.moccasin.event.ProgressSourceEvent;
	import com.joeberkovitz.moccasin.service.IConfigurationService;
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.joeberkovitz.moccasin.service.MoccasinDocumentData;
	import com.paperworld.flash.core.controller.IPaperworldController;
	import com.paperworld.flash.core.persistence.GameDocumentDecoder;
	import com.paperworld.flash.core.service.HttpGameService;
	import com.paperworld.flash.core.service.IPaperworldGameService;
	
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	public class Game extends Canvas
	{
		public var configurationService:IConfigurationService;
		
		public var gameService:IPaperworldGameService = null;
		
		private var loadingPopup:LoadingPopup = null;
		
		[Bindable]
        public var documentData:MoccasinDocumentData = null;
        
        protected var _document:MoccasinDocument;
        
        private var _controller:IPaperworldController;
        
        public function get controller():IPaperworldController
        {
            return _controller;
        }
        
        private var viewLayer:Canvas;
        private var guiLayer:UIComponent;
        
		
		public function Game()
		{
			super();
		}
		
		public function initialise():void 
		{		
			trace("initialising game")
			gameService = createGameService();
			
			//if (configurationService.documentUri != null)
            //{
                loadDocument(configurationService.documentUri);
            //}
		}
		
		override protected function createChildren():void
        {
            super.createChildren();
            
			viewLayer = new Canvas();
			addChild(viewLayer);
			
			guiLayer = new UIComponent();
			addChild(guiLayer);
		}
		
		protected function createGameService():IPaperworldGameService
		{
			return new HttpGameService(new GameDocumentDecoder());
		}
		
		private function loadDocument(documentId:String):void 
		{
			var operation:IOperation = gameService.loadGame(documentId);
            operation.addEventListener(Event.COMPLETE, documentLoaded);
            operation.addEventListener(OperationFaultEvent.FAULT, documentFault);
            operation.addEventListener(ProgressSourceEvent.PROGRESS_START, handleProgressStart);
            operation.displayName = "Loading document... " + documentId;
            operation.execute();
		}
		
		protected function documentLoaded(e:Event):void
        {
        	trace("document loaded");
            documentData = MoccasinDocumentData(IOperation(e.target).result);
            
            _document = new MoccasinDocument(documentData.root);
            //_controller.document = _document;
            //updateLayout();
        }
        
        protected function documentFault(e:OperationFaultEvent):void
        {
        }
        
        private function handleProgressStart(e:ProgressSourceEvent):void
        {
            if (loadingPopup == null)
            {
                loadingPopup = PopUpManager.createPopUp(this, LoadingPopup, true) as LoadingPopup;
                PopUpManager.centerPopUp(loadingPopup);
            }
            loadingPopup.addEventListener(Event.REMOVED, handleLoadingPopupRemoved);
            loadingPopup.addProgressSource(e.source, e.sourceName);
        }
        
        private function handleLoadingPopupRemoved(e:Event):void
        {
            loadingPopup = null;
        }
	}
}