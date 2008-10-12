/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
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
 * -------------------------------------------------------------------------------------- */
package com.paperworld.ui.controls.buttons 
{
	import flash.display.DisplayObject;	
	
	import com.blitzagency.xray.logger.XrayLog;	
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;

	import com.paperworld.ui.views.text.TextLineView;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractButton extends Sprite implements ButtonView 
	{
		/**
		 * Over/Down appends.
		 */
		protected static const OVER : String = "Over";

		protected static const DOWN : String = "Down";

		/**
		 * Button skins.
		 */
		protected var mouseDownSkin : DisplayObject;

		protected var mouseUpSkin : DisplayObject;

		protected var mouseOverSkin : DisplayObject;

		/**
		 * Label.
		 */
		protected var _label : TextLineView;
		
		private var logger : XrayLog = new XrayLog();

		/** 
		 * Constructor.
		 */
		public function AbstractButton(skinKey : *, buttonLabel : String, style : String)
		{			
			// Attach the skins.
			attachSkins( skinKey );
			attachLabel( buttonLabel, style );
	
			// Set the initial state
			onRollOut( );
			
			buttonMode = true;
	
			// Don't allow this movieclip to receive focus or have tab attributes.
			tabEnabled = false;
		}	

		/**
		 * Attach skins to this movie.
		 * Set the active mouse area to the size of the mouse up skin.
		 */
		protected function attachSkins(skinKey : *) : void
		{
			if (skinKey is String)
			{
				mouseUpSkin = attachSkin( skinKey );
				mouseDownSkin = attachSkin( skinKey, DOWN );
				mouseOverSkin = attachSkin( skinKey, OVER );
				
				if (mouseUpSkin != null)
				{		
					mouseUpSkin.addEventListener( MouseEvent.MOUSE_DOWN, onPress, false, 0, true );
					mouseUpSkin.addEventListener( MouseEvent.ROLL_OVER, onRollOver, false, 0, true );
					mouseUpSkin.addEventListener( MouseEvent.ROLL_OUT, onRollOut, false, 0, true );
					mouseUpSkin.addEventListener( MouseEvent.MOUSE_UP, onRelease, false, 0, true );
				}
			}
			else if (skinKey is Class)
			{
				logger.info("skin " + (skinKey as Class).toString());
				mouseUpSkin = new skinKey( );
				addChild( mouseUpSkin );
			}
		}

		/**
		 * Attach a skin.
		 * Test to see that this skin state exists, otherwise default to the standard skin.
		 */
		protected function attachSkin(skinKey : String, appender : String = "") : MovieClip
		{
			// Attempt to attach the supplied skin.
			var domain : ApplicationDomain = ApplicationDomain.currentDomain;
			//MovieManager.getInstance( ).getApplicationDomain( component );

			var SkinClass : Class;
			var tempSkin : MovieClip = null;
			
			if (domain.hasDefinition( skinKey + appender ))
			{
				SkinClass = domain.getDefinition( skinKey + appender ) as Class;
				
				if (SkinClass != null)
				{
					tempSkin = new SkinClass( ) as MovieClip;
					addChild( tempSkin );
					//tempSkin.cacheAsBitmap = true;
					tempSkin.mouseEnabled = false;
					tempSkin.mouseChildren = false;
					tempSkin.stop( );
				}
			}

			// If the skin does not exist use the standard up skin.
			return tempSkin;
		}

		/**
		 * Attach a button label.
		 */
		protected function attachLabel(buttonLabel : String, style : String) : void 
		{
			// Use the width & height of the standard skin to gauge size as any tool-tip will change these properties.
			_label = new TextLineView( style, 0, 0, this );
	
			_label.wordWrap = false;
			//textField.autoSize = TextFieldAutoSize.LEFT;

			_label.width = width;
			_label.height = height;
			_label.setLangKey( buttonLabel );
		}

		/**
		 * Set a skin visible
		 * The mouseUpSkin is under the down and over skins (if they exist)
		 * therefore we always leave the mouseUpSkin as visible, so that if the down/over
		 * do not exist, the mouseUpSkin will always be seen
		 */
		public function displaySkin(visible : Array) : void
		{
			if (mouseDownSkin != null)
			{
				mouseDownSkin.visible = visible[0];
			}
			
			if (mouseOverSkin != null)
			{
				mouseOverSkin.visible = visible[1];
			}
		}

		/**
		 * Destroy implementation.
		 */
		public function destroy() : void
		{		
			_label.destroy( );
			
			if (mouseDownSkin != null)
			{
				removeChild( mouseDownSkin );
				mouseDownSkin = null;
			}
			
			if (mouseOverSkin != null)
			{
				removeChild( mouseOverSkin );
				mouseOverSkin = null;
			}
			
			if (mouseUpSkin != null)
			{
				removeChild( mouseUpSkin );
				mouseUpSkin = null;
			}
			
			parent.removeChild( this );	
		}	

		/**
		 * On press.
		 * Default implementation.
		 */
		public function onPress(event : MouseEvent = null) : void
		{
			displaySkin( new Array( true, false ) );
			dispatchEvent( new MouseEvent( MouseEvent.MOUSE_DOWN ) );
		}		

		/**
		 * Handle a rollover event.
		 * Default implementation.
		 */
		public function onRollOver(event : MouseEvent = null) : void
		{
			displaySkin( new Array( false, true ) );
			dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
		}	

		/**
		 * Handle a rollout event.
		 * Default implementation.
		 */
		public function onRollOut(event : MouseEvent = null) : void
		{
			displaySkin( new Array( false, false ) );
			dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
		}	

		/**
		 * Handle a release on the movie.
		 * Default implementation.
		 */
		public function onRelease(event : MouseEvent = null) : void
		{
			onRollOver( );
			dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
		}	

		public function onClick(event : MouseEvent = null) : void
		{
			onRollOver( );
			dispatchEvent( new MouseEvent( MouseEvent.CLICK ) );
		}

		/**
		 * Set the label.
		 */
		public function set label(value : String) : void
		{
			_label.text = value;
		}

		/**
		 * Set the label as a language field.
		 */
		public function set labelLang(value : String) : void
		{
			_label.setLangKey( value );
		}

		/**
		 * Return the label title.
		 */
		public function get label() : String
		{
			return _label.text;
		}

		/**
		 * Return the width of the label.
		 */
		public function get labelWidth() : Number
		{
			return _label.width;
		}

		public function get textField() : TextLineView
		{
			return _label;
		}

		/**
		 * Set the position of the label.
		 * Adjust the width of the text field so it does not overlap the edge.
		 */
		public function setLabelPosition(x : Number, y : Number) : void
		{
			// Adjust the width of the text field
			if (x >= 0)
			{
				//customButtonView.getLabel().setTextFieldWidth(customButtonView.getWidth() - x);
			}
	
			_label.x = x;
			_label.y = y;
		}

		/**
		 * Override label width size which is set to fill the width of the button
		 * from the starting position.
		 */
		public function set labelWidth(value : Number) : void
		{
			_label.width = value;
		}

		/**
		 * Set enabled flag for this button.
		 */
		public function set enabled(enabled : Boolean) : void
		{
			buttonMode = enabled;
			useHandCursor = enabled;			
			mouseChildren = enabled;
		}

		/**
		 * Set alpha value for this button.
		 */
		override public function set alpha(value : Number) : void
		{
			displaySkin( new Array( false, false ) );
			
			super.alpha = value;
		}
	}
}