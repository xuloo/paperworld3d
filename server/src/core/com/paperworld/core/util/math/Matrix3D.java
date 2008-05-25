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
 */package com.paperworld.core.util.math;

import java.util.ArrayList;

public class Matrix3D 
{
	
	/**
	 * X O O O
	 * O O O O
	 * O O O O
	*/
	public Double n11;

	/**
	 * O X O O
	 * O O O O
	 * O O O O
	*/
	public Double n12;

	/**
	 * O O X O
	 * O O O O
	 * O O O O
	*/
	public Double n13;

	/**
	 * O O O X
	 * O O O O
	 * O O O O
	*/
	public Double n14;


	/**
	 * O O O O
	 * X O O O
	 * O O O O
	*/
	public Double n21;

	/**
	 * O O O O
	 * O X O O
	 * O O O O
	*/
	public Double n22;

	/**
	 * O O O O
	 * O O X O
	 * O O O O
	*/
	public Double n23;

	/**
	 * O O O O
	 * O O O X
	 * O O O O
	*/
	public Double n24;


	/**
	 * O O O O
	 * O O O O
	 * X O O O
	*/
	public Double n31;

	/**
	 * O O O O
	 * O O O O
	 * O X O O
	*/
	public Double n32;

	/**
	 * O O O O
	 * O O O O
	 * O O X O
	*/
	public Double n33;

	/**
	 * O O O O
	 * O O O O
	 * O O O X
	*/
	public Double n34;

	/**
	 * O O O O
	 * O O O O
	 * O O O O
	 * X O O O
	*/
	public Double n41;

	/**
	 * O O O O
	 * O O O O
	 * O O O O
	 * O X O O
	*/
	public Double n42;

	/**
	 * O O O O
	 * O O O O
	 * O O O O
	 * O O X O
	*/
	public Double n43;

	/**
	 * O O O O
	 * O O O O
	 * O O O O
	 * O O O X
	*/
	public Double n44;
	
	public Matrix3D( Double[] args )
	{
		n11 = args[0];  n12 = args[1];  n13 = args[2];  n14 = args[3];
		n21 = args[4];  n22 = args[5];  n23 = args[6];  n24 = args[7];
		n31 = args[8];  n32 = args[9];  n33 = args[10]; n34 = args[11];
			
		if( args.length == 16 )
		{
			n41 = args[12];	 n42 = args[13]; n43 = args[14]; n44 = args[15];
		}	
	}
	
	public Matrix3D() {
		
		n11 = n22 = n33 = n44 = 1.0;
		n12 = n13 = n14 = n21 = n23 = n24 = n31 = n32 = n34 = n41 = n42 = n43 = 0.0;
		
	}
	
	public static Matrix3D getIDENTITY()
	{
		Matrix3D m = new Matrix3D();
		
		m.n11 = 1.0;
		m.n12 = 0.0;
		m.n13 = 0.0;
		m.n14 = 0.0;
		m.n21 = 0.0;
		m.n22 = 1.0;
		m.n23 = 0.0;
		m.n24 = 0.0;
		m.n31 = 0.0;
		m.n32 = 0.0;
		m.n33 = 1.0;
		m.n34 = 0.0;
		m.n41 = 0.0;
		m.n42 = 0.0;
		m.n43 = 0.0;
		m.n44 = 1.0;
		
		return m;		
	}
	
	public static void rotateAxis( Matrix3D m, Vector3D v )
	{
		Double vx = v.x;
		Double vy = v.y;
		Double vz = v.z;

		v.x = vx * m.n11 + vy * m.n12 + vz * m.n13;
		v.y = vx * m.n21 + vy * m.n22 + vz * m.n23;
		v.z = vx * m.n31 + vy * m.n32 + vz * m.n33;

		v.normalise();
	}
	
	public static Matrix3D rotationMatrix( Double x, Double y, Double z, Double rad )
	{
		Matrix3D m = getIDENTITY();
		
		Double nCos	= Math.cos( rad );
		Double nSin	= Math.sin( rad );
		Double scos	= 1 - nCos;

		Double sxy	 = x * y * scos;
		Double syz	 = y * z * scos;
		Double sxz	 = x * z * scos;
		Double sz	 = nSin * z;
		Double sy	 = nSin * y;
		Double sx	 = nSin * x;

		m.n11 =  nCos + x * x * scos;
		m.n12 = -sz   + sxy;
		m.n13 =  sy   + sxz;

		m.n21 =  sz   + sxy;
		m.n22 =  nCos + y * y * scos;
		m.n23 = -sx   + syz;

		m.n31 = -sy   + sxz;
		m.n32 =  sx   + syz;
		m.n33 =  nCos + z * z * scos;

		return m;
	}
	
	public void calculateMultiply3x3( Matrix3D a, Matrix3D b )
	{
		Double a11 = a.n11; Double b11 = b.n11;
		Double a21 = a.n21; Double b21 = b.n21;
		Double a31 = a.n31; Double b31 = b.n31;
		Double a12 = a.n12; Double b12 = b.n12;
		Double a22 = a.n22; Double b22 = b.n22;
		Double a32 = a.n32; Double b32 = b.n32;
		Double a13 = a.n13; Double b13 = b.n13;
		Double a23 = a.n23; Double b23 = b.n23;
		Double a33 = a.n33; Double b33 = b.n33;

		this.n11 = a11 * b11 + a12 * b21 + a13 * b31;
		this.n12 = a11 * b12 + a12 * b22 + a13 * b32;
		this.n13 = a11 * b13 + a12 * b23 + a13 * b33;

		this.n21 = a21 * b11 + a22 * b21 + a23 * b31;
		this.n22 = a21 * b12 + a22 * b22 + a23 * b32;
		this.n23 = a21 * b13 + a22 * b23 + a23 * b33;

		this.n31 = a31 * b11 + a32 * b21 + a33 * b31;
		this.n32 = a31 * b12 + a32 * b22 + a33 * b32;
		this.n33 = a31 * b13 + a32 * b23 + a33 * b33;
	}
/*
	//@Override
	public void readExternal(IDataInput input) {
		
		n11 = input.readDouble();
		n12 = input.readDouble();
		n13 = input.readDouble();
		n14 = input.readDouble();
		n21 = input.readDouble();
		n22 = input.readDouble();
		n23 = input.readDouble();
		n24 = input.readDouble();
		n31 = input.readDouble();
		n32 = input.readDouble();
		n33 = input.readDouble();
		n34 = input.readDouble();
		n41 = input.readDouble();
		n42 = input.readDouble();
		n43 = input.readDouble();
		n44 = input.readDouble();
	}

	//@Override
	public void writeExternal(IDataOutput output) {
		output.writeDouble(n11);
		output.writeDouble(n12);
		output.writeDouble(n13);
		output.writeDouble(n14);
		output.writeDouble(n21);
		output.writeDouble(n22);
		output.writeDouble(n23);
		output.writeDouble(n24);
		output.writeDouble(n31);
		output.writeDouble(n32);
		output.writeDouble(n33);
		output.writeDouble(n34);
		output.writeDouble(n41);
		output.writeDouble(n42);
		output.writeDouble(n43);
		output.writeDouble(n44);		
	}*/
	
	public Matrix3D copy( Matrix3D m )
	{
		this.n11 = m.n11;	this.n12 = m.n12;
		this.n13 = m.n13;	this.n14 = m.n14;

		this.n21 = m.n21;	this.n22 = m.n22;
		this.n23 = m.n23;	this.n24 = m.n24;

		this.n31 = m.n31;	this.n32 = m.n32;
		this.n33 = m.n33;	this.n34 = m.n34;

		return this;
	}
	
	@Override
	public String toString()
	{
		String s = "";

		s += (int)(n11*1000)/1000 + "\t\t" + (int)(n12*1000)/1000 + "\t\t" + (int)(n13*1000)/1000 + "\t\t" + (int)(n14*1000)/1000 + "\n";
		s += (int)(n21*1000)/1000 + "\t\t" + (int)(n22*1000)/1000 + "\t\t" + (int)(n23*1000)/1000 + "\t\t" + (int)(n24*1000)/1000 + "\n";
		s += (int)(n31*1000)/1000 + "\t\t" + (int)(n32*1000)/1000 + "\t\t" + (int)(n33*1000)/1000 + "\t\t" + (int)(n34*1000)/1000 + "\n";
		s += (int)(n41*1000)/1000 + "\t\t" + (int)(n42*1000)/1000 + "\t\t" + (int)(n43*1000)/1000 + "\t\t" + (int)(n44*1000)/1000 + "\n";

		return s;
	}
}
