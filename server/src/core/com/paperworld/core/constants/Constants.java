/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Influxis [http://www.influxis.com]
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
package com.paperworld.core.constants;

/**
 * Holds constant values that are used throughout the application.
 * 
 * @author Trevor
 * 
 */
public class Constants {

	/**
	 * Config Keys.
	 */
	public static String RED5_CONFIG_ROOT_KEY = "red5.config_root";

	/**
	 * Database Connection Keys.
	 */
	public static String JDBC_DRIVERS_KEY = "jdbc.drivers";
	public static String JDBC_URL_KEY = "jdbc.url";
	public static String JDBC_USERNAME_KEY = "jdbc.username";
	public static String JDBC_PASSWORD_KEY = "jdbc.password";

	/**
	 * Connection Method Keys.
	 */
	public static String SET_UID_METHOD_KEY = "setUID";
	
	// Numerical Constants
	public static Double EPSILON = 0.000001;
	public static Double DEGTORAD = (Math.PI/180.0);
	public static Double RADTODEG = (180.0/Math.PI);
}
