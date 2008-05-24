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
package com.paperworld.rpc.objects
{
	import org.papervision3d.events.InteractiveScene3DEvent;	
	
	import flash.net.NetConnection;
	
	import org.papervision3d.objects.primitives.Plane;
	
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	import com.paperworld.rpc.weapons.ITargetedWeapon;
	import com.paperworld.rpc.weapons.IWeapon;
	
	import de.polygonal.ds.HashMap;	
	public class Vehicle extends Avatar
	{
		public var connection : NetConnection;

		public var maxHealth : Number = 100;

		public var health : Number = maxHealth;

		public var $healthBar : Plane;

		public var healthVisible : Boolean = false;

		public var interactionArea : Plane;

		public var weapons : HashMap;

		public var selectedWeapon : IWeapon;

		public var isDestroyed : Boolean = false;

		public function set firing(value : Boolean) : void 
		{
			if (value)
				fireWeapon( );
			else
				selectedWeapon.stopFiring( );	
		}

		override protected function createDisplayObject(key : String) : void 
		{
		}

		public function Vehicle()
		{
			super( );	
			
			weapons = new HashMap( );
			initialise( );
			
			start();
		}

		override public function update(event : IntegrationEvent) : void 
		{
			if (registered)
			{
				super.update( event );
			
				if (character.input.firing)
				{
					fireWeapon( );	
				}
			}
		}

		public function start() : void
		{
			GameTimer.getInstance( ).addEventListener( IntegrationEvent.INTEGRATION_EVENT, update );
		}
/*
		protected function initialise() : void 
		{
			createWeapons( );
			
			addEventListener( InteractiveScene3DEvent.OBJECT_CLICK, handleClick);
		}*/
		
		private function handleClick(event:InteractiveScene3DEvent):void 
		{
		}

		private function createWeapons() : void 
		{
		}

		public function get weaponTarget() : Vehicle
		{
			return (weapons.find( "Missile" ) as ITargetedWeapon).getTarget( );
		}

		public function setWeaponTarget(target : Vehicle) : void 
		{
			var missileWeapon : ITargetedWeapon = weapons.find( "Missile" ) as ITargetedWeapon;
			missileWeapon.setTarget( target );
		}

		public function addWeapon(key : String, weapon : IWeapon) : void 
		{
			weapons.insert( key, weapon );

			selectedWeapon = weapon;
			selectedWeapon.active = true;
		}

		public function fireWeapon() : void
		{
			//PaperWorld.log("Firing weapon " + selectedWeapon);
			//selectedWeapon.fire(this);
		}

		public function stopFiring() : void
		{
			selectedWeapon.stopFiring( );	
		}

		public function fireWeaponByName(key : String) : void 
		{			
			var weapon : IWeapon = weapons.find( key ) as IWeapon;
	
			weapon.fire( this );
		}

		public function stopFiringWeaponByName(key : String) : void 
		{
			var weapon : IWeapon = weapons.find( key ) as IWeapon;
			weapon.stopFiring( );
		}
	}
}