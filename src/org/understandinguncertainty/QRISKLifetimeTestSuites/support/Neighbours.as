/*
This file forms part of the test suite for the JBS3Risk Risk Model.
It is ©2012 University of Cambridge.
It is released under version 3 of the GNU General Public License
Source code, including a copy of the license is available at https://github.com/BritCardSoc/JBS3Risk

It contains code derived from http://qrisk.org/lifetime/QRISK-lifetime-2011-opensource.v1.0.tgz released by ClinRisk Ltd.

*/
package org.understandinguncertainty.QRISKLifetimeTestSuites.support
{
	public class Neighbours
	{
		private var epsilon:Number;
		
		function Neighbours(epsilon:Number = 1.0)
		{
			this.epsilon = epsilon;
		}
		
		public function areClose(a:Number, b:Number):Boolean
		{
			return Math.abs(a-b) < epsilon;
		}
		
	}
}