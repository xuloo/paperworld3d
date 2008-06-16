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
	
	static private Matrix3D temp = new Matrix3D(); 
	
	static private Vector3D n3Di = new Vector3D(); 
	static private Vector3D n3Dj = new Vector3D(); 
	static private Vector3D n3Dk = new Vector3D();
	
	static private double toDEGREES = 180/Math.PI;
	static private double toRADIANS = Math.PI/180;
	
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
	
	public static Matrix3D multiply( Matrix3D a, Matrix3D b )
	{
		//trace("matrix.multiply"); 
		Matrix3D m = new Matrix3D();
		
		m.calculateMultiply( a, b );
		
		return m;
	}
	
	public void calculateMultiply( Matrix3D a, Matrix3D b )
	{
		double a11 = a.n11; double b11 = b.n11;
		double a21 = a.n21; double b21 = b.n21;
		double a31 = a.n31; double b31 = b.n31;
		double a12 = a.n12; double b12 = b.n12;
		double a22 = a.n22; double b22 = b.n22;
		double a32 = a.n32; double b32 = b.n32;
		double a13 = a.n13; double b13 = b.n13;
		double a23 = a.n23; double b23 = b.n23;
		double a33 = a.n33; double b33 = b.n33;
		double a14 = a.n14; double b14 = b.n14;
		double a24 = a.n24; double b24 = b.n24;
		double a34 = a.n34; double b34 = b.n34;

		this.n11 = a11 * b11 + a12 * b21 + a13 * b31;
		this.n12 = a11 * b12 + a12 * b22 + a13 * b32;
		this.n13 = a11 * b13 + a12 * b23 + a13 * b33;
		this.n14 = a11 * b14 + a12 * b24 + a13 * b34 + a14;

		this.n21 = a21 * b11 + a22 * b21 + a23 * b31;
		this.n22 = a21 * b12 + a22 * b22 + a23 * b32;
		this.n23 = a21 * b13 + a22 * b23 + a23 * b33;
		this.n24 = a21 * b14 + a22 * b24 + a23 * b34 + a24;

		this.n31 = a31 * b11 + a32 * b21 + a33 * b31;
		this.n32 = a31 * b12 + a32 * b22 + a33 * b32;
		this.n33 = a31 * b13 + a32 * b23 + a33 * b33;
		this.n34 = a31 * b14 + a32 * b24 + a33 * b34 + a34;
	}
	
	public static Vector3D matrix2euler( Matrix3D t, Vector3D rot )
	{
		if(rot == null) rot = new Vector3D(); 

		// Normalize the local x, y and z axes to remove scaling.
		n3Di.reset( t.n11, t.n21, t.n31 );
		n3Dj.reset( t.n12, t.n22, t.n32 );
		n3Dk.reset( t.n13, t.n23, t.n33 );

		n3Di.normalise();
		n3Dj.normalise();
		n3Dk.normalise();

		temp.reset(new double[]{
			n3Di.x, n3Dj.x, n3Dk.x, 0,
			n3Di.y, n3Dj.y, n3Dk.y, 0,
			n3Di.z, n3Dj.z, n3Dk.z, 0
		});

		Matrix3D m = temp;

	    // Extract the first angle, rot.x
		rot.x = Math.atan2( m.n23, m.n33 ); // rot.x = Math<T>::atan2 (M[1][2], M[2][2]);
	
		// Remove the rot.x rotation from M, so that the remaining
		// rotation, N, is only around two axes, and gimbal lock
		// cannot occur.
		Matrix3D rx = Matrix3D.rotationX( -rot.x );
		Matrix3D n = Matrix3D.multiply( rx, m );

		// Extract the other two angles, rot.y and rot.z, from N.
		double cy = Math.sqrt( n.n11 * n.n11 + n.n21 * n.n21); // T cy = Math<T>::sqrt (N[0][0]*N[0][0] + N[0][1]*N[0][1]);
		rot.y = Math.atan2( -n.n31, cy ); // rot.y = Math<T>::atan2 (-N[0][2], cy);
		rot.z = Math.atan2( -n.n12, n.n11 ); //rot.z = Math<T>::atan2 (-N[1][0], N[1][1]);

		// Fix angles
		if( rot.x == Math.PI )
		{
			if( rot.y > 0 )
				rot.y -= Math.PI;
			else
				rot.y += Math.PI;

			rot.x = 0;
			rot.z += Math.PI;
		}

		// Convert to degrees if needed 
		// Shouldn't this have a check for Papervision3D.useDEGREES? 
		
		rot.x *= toDEGREES;
		rot.y *= toDEGREES;
		rot.z *= toDEGREES;
		
		return rot;
	}
	
	public static Quaternion euler2quaternion( double ax, double ay, double az, Quaternion targetquat  )
    {
		double fSinPitch        = Math.sin( ax * 0.5 );
		double fCosPitch        = Math.cos( ax * 0.5 );
		double fSinYaw          = Math.sin( ay * 0.5 );
		double fCosYaw          = Math.cos( ay * 0.5 );
		double fSinRoll         = Math.sin( az * 0.5 );
		double fCosRoll         = Math.cos( az * 0.5 );
		double fCosPitchCosYaw  = fCosPitch * fCosYaw;
		double fSinPitchSinYaw  = fSinPitch * fSinYaw;

		Quaternion q;
		if(targetquat == null) q = new Quaternion();
		else q = targetquat; 

		q.x = fSinRoll * fCosPitchCosYaw     - fCosRoll * fSinPitchSinYaw;
		q.y = fCosRoll * fSinPitch * fCosYaw + fSinRoll * fCosPitch * fSinYaw;
		q.z = fCosRoll * fCosPitch * fSinYaw - fSinRoll * fSinPitch * fCosYaw;
		q.w = fCosRoll * fCosPitchCosYaw     + fSinRoll * fSinPitchSinYaw;

		return q;
    }
	
	public static Matrix3D quaternion2matrix( double x, double y, double z, double w, Matrix3D targetmatrix )
	{
		double xx = x * x;
		double xy = x * y;
		double xz = x * z;
		double xw = x * w;

		double yy = y * y;
		double yz = y * z;
		double yw = y * w;

		double zz = z * z;
		double zw = z * w;
		
		Matrix3D m;
		
		if(targetmatrix == null) 
		{
			//trace("quat to matrix"); 
			m  = getIDENTITY();
		}
		else 
		{
			m = targetmatrix ;
		}
		m.n11 = 1 - 2 * ( yy + zz );
		m.n12 =     2 * ( xy - zw );
		m.n13 =     2 * ( xz + yw );

		m.n21 =     2 * ( xy + zw );
		m.n22 = 1 - 2 * ( xx + zz );
		m.n23 =     2 * ( yz - xw );

		m.n31 =     2 * ( xz - yw );
		m.n32 =     2 * ( yz + xw );
		m.n33 = 1 - 2 * ( xx + yy );

		return m;
	}
	
	public static Matrix3D rotationX( double rad )
	{
		//trace("rotationX"); 
		Matrix3D m = new Matrix3D();
		
		double c = Math.cos( rad );
		double s = Math.sin( rad );

		m.n22 =  c;
		m.n23 = -s;
		m.n32 =  s;
		m.n33 =  c;

		return m;
	}

	public static Matrix3D rotationY( double rad )
	{
		//trace("rotationY"); 
		Matrix3D m = getIDENTITY();
		double c = Math.cos( rad );
		double s = Math.sin( rad );

		m.n11 =  c;
		m.n13 = -s;
		m.n31 =  s;
		m.n33 =  c;

		return m;
	}

	public static Matrix3D rotationZ( double rad )
	{
		//trace("rotationZ"); 
		Matrix3D m = getIDENTITY();
		double c = Math.cos( rad );
		double s = Math.sin( rad );

		m.n11 =  c;
		m.n12 = -s;
		m.n21 =  s;
		m.n22 =  c;

		return m;
	}
	
	public void reset( double[] args )
	{		
		if( args == null || args.length < 12 )
		{
			n11 = n22 = n33 = n44 = 1.0;
			n12 = n13 = n14 = n21 = n23 = n24 = n31 = n32 = n34 = n41 = n42 = n43 = 0.0;
		}
		else
		{
			n11 = args[0];  n12 = args[1];  n13 = args[2];  n14 = args[3];
			n21 = args[4];  n22 = args[5];  n23 = args[6];  n24 = args[7];
			n31 = args[8];  n32 = args[9];  n33 = args[10]; n34 = args[11];
			
			if( args.length == 16 )
			{
				n41 = args[12];	 n42 = args[13]; n43 = args[14]; n44 = args[15];
			} 
			else
			{
				n41 = n42 = n43 = 0.0;
				n44 = 1.0;
			}
		}		
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
