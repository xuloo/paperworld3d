package com.paperworld.games.quake 
{
	import com.paperworld.PaperWorld;	
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	import com.suite75.papervision3d.quake1.QuakeEngine;
	import com.suite75.papervision3d.quake1.objects.MDL;		
	/**
	 * @author Trevor
	 */
	public class Quake extends AbstractModule 
	{
		private var engine : QuakeEngine;
		
		private var $logger : ILogger;

		public function Quake()
		{
			super( );
			
			$logger = LoggerFactory.getLogger(this);
		}

		override public function initialise(target:Sprite):void 
		{
			super.initialise(target);
			
			$logger.info("Initialising Quake");
			
			engine = new QuakeEngine( );
			GameTimer.getInstance().addEventListener( IntegrationEvent.INTEGRATION_EVENT, render);
			
			this.target.addChild(engine);
			
			loadBSP();
		}
		
		private function loadBSP(map:String = "games/Quake/locale/en_US/maps/e1m2.bsp"):void
		{
			$logger.info("loading bsp");
			
			var stage:Stage = PaperWorld.getInstance().stage;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			engine.addEventListener(Event.COMPLETE, onBspComplete);
			engine.loadMap(map);
		}
		
		private function onBspComplete(event:Event):void 
		{
			//GameTimer.getInstance().start();
			createModels();
		}
		
		private function createModels():void 
		{
			var dog:MDL = new MDL(true, 2, "dog");
			//dog.addEventListener(FileLoadEvent.ANIMATIONS_COMPLETE, onModelAnimationsComplete);
			//dog.addEventListener(ProgressEvent.PROGRESS, onModelProgress);
			//dog.load(new dogModel());
			dog.load("games/Quake/locale/en_US/models/dog.mdl");
			engine.scene.addChild(dog);
			dog.rotationZ = 90;
			dog.x = 1600;
			dog.y = 1300;
			dog.z = 220;
		}
		
		public function render(event : IntegrationEvent) : void
		{
			if(_moveForward)
				engine.camera.moveForward(15);
			if(_moveBackward)
				engine.camera.moveBackward(15);
			if(_turnLeft)
				engine.camera.yaw(-5);
			if(_turnRight)
				engine.camera.yaw(5);
				
			engine.render();
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			$logger.info("KeyDown::" + event.keyCode);
			switch(event.keyCode)
			{
				case "W".charCodeAt():
					_moveForward = true;
					break;
				case "S".charCodeAt():
					_moveBackward = true;
					break;
				case "A".charCodeAt():
					_turnLeft = true;
					break;
				case "D".charCodeAt():
					_turnRight = true;
					break;
				default:
					break;
			}
			
			return;
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			_moveForward = _moveBackward = _turnLeft = _turnRight = false;
		}
		
		private var _moveBackward:Boolean = false;
		private var _moveForward:Boolean = false;
		private var _turnLeft:Boolean = false;
		private var _turnRight:Boolean = false;
		private var _loopSound:Boolean = true;
/*
		protected override function init():void
		{
			super.init();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;
			
			status = new TextField();
			status.x = status.y = 5;
			status.width = 400;
			status.height = 300;
			status.selectable = false;
			status.multiline = true;
			status.defaultTextFormat = new TextFormat("Arial", 12, 0xffff00);
			addChild(status);
			
			scene.addChild(new UCS());

			initSounds();
			
			testBSP();
		}
	
		private function initSounds():void
		{
			this.sounds = [
				new pain1Sound(),
				new pain2Sound(),
				new pain3Sound(),
				new pain4Sound(),
				new pain5Sound(),
				new pain6Sound(),
				new death1Sound(),
				new death2Sound(),
				new death3Sound(),
				new death4Sound(),
				new death5Sound(),
				new gasp1Sound(),
				new gasp2Sound(),
				new drown1Sound(),
				new drown2Sound(),
				new tornoff2Sound()
			];		
		}
		
		private function testBSP(map:String = "maps/e1m2.bsp"):void
		{
			//map = "maps/bsdm7.bsp";
			this.mapFile = map;
			
			loadMap(map);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			onRenderTick(null);	
		}
		
		protected override function onBspComplete(event:Event):void
		{
			status.text = "WSAD to move.";
			super.onBspComplete(event);
			
			try
			{
				var wav:WavFormat = WavFormat.decode(new ambientSound());
			}
			catch(e:Error)
			{
				trace(e.message+"\n"+e.getStackTrace());
			}
			
			SoundFactory.fromArray(wav.samples, wav.channels, wav.bits, wav.rate, onSoundComplete);	
				
			testMDL();
		}
		
		protected override function onBspProgress(event:ProgressEvent):void
		{
			var perc:Number = (event.bytesLoaded / event.bytesTotal) * 100;
			var total:Number = event.bytesTotal / 1024 / 1024;
			var loaded:Number = event.bytesLoaded / 1024 / 1024;
			
			status.text = "loading map '" + this.mapFile + "' " + perc.toFixed(2) + " %done (" + loaded.toFixed(1) +" of " + total.toFixed(1) +" Mb)";
			super.onBspProgress(event);
		}
		
		private function testMDL():void
		{
			var dog:MDL = new MDL(true, 2, "dog");
			dog.addEventListener(FileLoadEvent.ANIMATIONS_COMPLETE, onModelAnimationsComplete);
			dog.addEventListener(ProgressEvent.PROGRESS, onModelProgress);
			dog.load(new dogModel());
			this.scene.addChild(dog);
			dog.rotationZ = 90;
			dog.x = 1600;
			dog.y = 1300;
			dog.z = 220;
			
			var ogre:MDL = new MDL(true, 2, "ogre");
			ogre.addEventListener(FileLoadEvent.ANIMATIONS_COMPLETE, onModelAnimationsComplete);
			ogre.addEventListener(ProgressEvent.PROGRESS, onModelProgress);
			ogre.load(new ogreModel());
			scene.addChild(ogre);
			ogre.rotationZ = 120;

			ogre.x = 1500;
			ogre.y = 1300;
			ogre.z = 260;
			
			var model:MDL = new MDL(true, 2, "enforcer");
			model.addEventListener(FileLoadEvent.ANIMATIONS_COMPLETE, onModelAnimationsComplete);
			model.addEventListener(ProgressEvent.PROGRESS, onModelProgress);
			model.load(new enforcerModel());
			scene.addChild(model);
			model.rotationZ = 90;
			
			model.x = 1400;
			model.y = 1300;
			model.z = 220;
		}
		
		private function testPAK():void
		{
			var pak:PAKReader = new PAKReader();
			pak.addEventListener(Event.COMPLETE, onPAKComplete);
			pak.load("PAK0.PAK");
		}
		
		private function onModelAnimationsComplete(event:FileLoadEvent):void
		{
			status.text = "WSAD to move.";
		}
		
		private function onModelProgress(event:ProgressEvent):void
		{
			var perc:Number = (event.bytesLoaded / event.bytesTotal) * 100;
			status.text = "loading monsters " + perc.toFixed(2) + "% done. Please wait.";
		}
		
		public override function onRenderTick(event:Event):void
		{
			if(_moveForward)
				this.camera.moveForward(15);
			if(_moveBackward)
				this.camera.moveBackward(15);
			if(_turnLeft)
				this.camera.yaw(-5);
			if(_turnRight)
				this.camera.yaw(5);
				
			super.onRenderTick(event);
		}
		
		private function onPAKComplete(event:Event):void
		{
			var pak:PAKReader = event.target as PAKReader;
			//return;

			var sight:ByteArray = pak.getEntryByName("sound/ambience/hum1.wav");
			if(sight)
			{
				sight.position = 0;
				try
				{
					var wav:WavFormat = WavFormat.decode(sight);
				}
				catch(e:Error)
				{
					trace(e.message+"\n"+e.getStackTrace());
				}
				
				SoundFactory.fromArray(wav.samples, wav.channels, wav.bits, wav.rate, onSoundComplete);
			}
		}
		
		private function onSoundComplete(sound:Sound):void
		{
			sound.play(0, (_loopSound?1000:1));
			_loopSound = false;
		}

		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case "W".charCodeAt():
					_moveForward = true;
					break;
				case "S".charCodeAt():
					_moveBackward = true;
					break;
				case "A".charCodeAt():
					_turnLeft = true;
					break;
				case "D".charCodeAt():
					_turnRight = true;
					break;
				default:
					break;
			}
			return;
			var snd:ByteArray = this.sounds[int(Math.random()*this.sounds.length)];
			
			var wav:WavFormat = WavFormat.decode(snd);
			SoundFactory.fromArray(wav.samples, wav.channels, wav.bits, wav.rate, onSoundComplete);
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			_moveForward = _moveBackward = _turnLeft = _turnRight = false;
		}

		private function onMouseDown(event:MouseEvent):void
		{
			
		}

		private function onMouseMove(event:MouseEvent):void
		{
			
		}

		private function onMouseUp(event:MouseEvent):void
		{
			
		}
		
		private var _moveBackward:Boolean = false;
		private var _moveForward:Boolean = false;
		private var _turnLeft:Boolean = false;
		private var _turnRight:Boolean = false;
		private var _loopSound:Boolean = true;*/
	}
}
/*
		[Embed (source="../bin-debug/progs/armor.mdl", mimeType="application/octet-stream")]
		public var armorModel:Class;
		
		[Embed (source="../bin-debug/progs/enforcer.mdl", mimeType="application/octet-stream")]
		public var enforcerModel:Class;
		
		[Embed (source="../bin-debug/progs/dog.mdl", mimeType="application/octet-stream")]
		public var dogModel:Class;
		
		[Embed (source="../bin-debug/progs/ogre.mdl", mimeType="application/octet-stream")]
		public var ogreModel:Class;
		
		[Embed (source="../bin-debug/sound/ambience/comp1.wav", mimeType="application/octet-stream")]
		public var ambientSound:Class;
		
		[Embed (source="../bin-debug/sound/player/pain1.wav", mimeType="application/octet-stream")]
		public var pain1Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/pain2.wav", mimeType="application/octet-stream")]
		public var pain2Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/pain3.wav", mimeType="application/octet-stream")]
		public var pain3Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/pain4.wav", mimeType="application/octet-stream")]
		public var pain4Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/pain5.wav", mimeType="application/octet-stream")]
		public var pain5Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/pain6.wav", mimeType="application/octet-stream")]
		public var pain6Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/death1.wav", mimeType="application/octet-stream")]
		public var death1Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/death2.wav", mimeType="application/octet-stream")]
		public var death2Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/death3.wav", mimeType="application/octet-stream")]
		public var death3Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/death4.wav", mimeType="application/octet-stream")]
		public var death4Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/death5.wav", mimeType="application/octet-stream")]
		public var death5Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/gasp1.wav", mimeType="application/octet-stream")]
		public var gasp1Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/gasp2.wav", mimeType="application/octet-stream")]
		public var gasp2Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/drown1.wav", mimeType="application/octet-stream")]
		public var drown1Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/drown2.wav", mimeType="application/octet-stream")]
		public var drown2Sound:Class;
		
		[Embed (source="../bin-debug/sound/player/tornoff2.wav", mimeType="application/octet-stream")]
		public var tornoff2Sound:Class;

*/
