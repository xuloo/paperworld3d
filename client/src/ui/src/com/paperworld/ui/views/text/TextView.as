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
package com.paperworld.ui.views.text 
{
	import com.paperworld.util.lang.LanguageChangeEvent;	

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import com.paperworld.util.lang.LanguageListener;
	import com.paperworld.util.lang.LanguageManager;
	import com.paperworld.util.style.StyleManager;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class TextView extends TextField implements LanguageListener
	{
		public static const DEFAULT_ALIGNMENT : String = TextFieldAutoSize.LEFT;

		/**
		 * The style name from the CSS to be applied to this text field.
		 */
		protected var _fontStyle : String;	

		/**
		 * The language key.
		 */
		protected var _langKey : String;

		/**
		 *  Array of parameter key & value pairs used to replace ${key} in any message from a language file. 
		 *  [0] = parameter key
		 *  [1] = value 
		 *  etc....
		 */
		protected var _parameters : Array;

		
		/**
		 * Constructor.
		 */
		public function TextView(fontStyle : String, target : Sprite, x : Number, y : Number )
		{			
			_fontStyle = fontStyle;
			
			_parameters = new Array( );
		}

		/**
		 * Destroy all variables and associated movieclips.
		 */
		public function destroy() : void
		{
			if (hasLanguage( ))
			{
				LanguageManager.getInstance( ).removeListener( this );
				_langKey = null;
			}

			_fontStyle = null;
		}	

		/**
		 * Create the text view.
		 */
		protected function createTextView(width : Number, height : Number, wrap : Boolean, auto : String, multiline : Boolean = false) : void
		{
			width = width;
			height = height;
			autoSize = auto;
			wordWrap = wrap;
			
			this.multiline = multiline;
			
			//viewText.border = true;
			selectable = false;	
			embedFonts = true;
			styleSheet = StyleManager.getInstance( ).styleSheet;
			
			// Automatically set alignment from the style sheet.				
			//setAlignment(getAlignment());	
		}	

		/**
		 * Render the supplied text as HTML.
		 */
		private function renderHTMLText(t : String) : String
		{
			return '<p class="' + fontStyle + '">' + t + '</p>';
		}	

		/**
		 * Set the alignment automatically based on the style sheet entry.
		 */
		public function setAlignment(alignValue : String) : void
		{
			autoSize = alignValue;
		}	

		/**
		 * Return the text alignment property.
		 *//*
		public function getAlignment():String
		{
		var styleObject:Object = StyleManager.getInstance().getStyleSheet().getStyle("." + fontStyle);

		return styleObject[TEXT_ALIGN_PROPERTY] || DEFAULT_ALIGNMENT;	
		}	*/

		/**
		 * Set the text.
		 */
		override public function set text(t : String) : void
		{
			htmlText = renderHTMLText( t );
		}

		/**
		 * Add text to the existing text.
		 */
		public function addText(t : String) : void
		{
			var text : String = htmlText;
			text += t;			
			htmlText = "";
			htmlText += renderHTMLText( text );
		}	

		/**
		 * Set the language key.
		 * Check the language key was valid and defined.
		 * Make this instance a language listener.
		 */	
		public function setLangKey(langKey : String, parameters : Array = null) : void
		{
			_langKey = langKey;
			_parameters = parameters;
			
			if (hasLanguage( ))
			{
				LanguageManager.getInstance( ).addListener( this );
			}
		}

		/**
		 * Return the langauage key if it exits.
		 */
		public function get langKey() : String
		{
			return _langKey;
		}

		/**
		 * Does this text field contain a language key?
		 */
		public function hasLanguage() : Boolean
		{
			return (_langKey != null && _langKey.length > 0) ? true : false;
		}

		/**
		 * Return the current font style.
		 */
		public function get fontStyle() : String
		{
			return _fontStyle;
		}

		/**
		 * Set a new font style.
		 * Refresh the text.
		 */
		public function setFontStyle(fontStyle : String) : void
		{
			_fontStyle = fontStyle;
			this.text = text;
		}	

		/**
		 * Listen for language changes.
		 * Update the text field.
		 */
		public function onLanguageChange(event : LanguageChangeEvent) : void
		{	
			text = event.languageManager.getString( _langKey, _parameters );	
		}

		public function enableHyperLinks(enabled : Boolean) : void 
		{
			mouseEnabled = enabled;
		}

		/**
		 * Add a parameter key and value.
		 * The value will be used to replace its ${key} in the text.
		 */
		public function addParameter(key : String, value : String) : void
		{
			_parameters.push( key );
			_parameters.push( value );
			
			updateText( );
		}

		/**
		 * Update a parameter value ad rerender the text
		 */
		public function updateParameter(key : String, value : String) : void
		{
			for (var i : Number = 0; i < _parameters.length - 1 ; i += 2)
			{
				if (_parameters[i] == key)
				{
					_parameters[i + 1] = value;
					updateText( );
					break;
				}
			}
		}

		
		
		/**
		 * Update the textual content of the text field.
		 */
		public function updateText() : void
		{
			text = LanguageManager.getInstance( ).getString( _langKey, _parameters );
		}

		/**
		 * toString.
		 */
		override public function toString() : String
		{
			// Initialise the toString.
			var propString : String = "TextView with style: " + fontStyle;
			
			// Get the correct style from the style sheet.
			var styleObject : Object = StyleManager.getInstance( ).styleSheet.getStyle( "." + fontStyle );
			for (var propName:String in styleObject)
			{
				var propValue : String = String( styleObject[propName] );
				propString += "\n" + propName + ": " + propValue;
			}
			
			// Finally return the content.
			return propString;
		}
	}
}