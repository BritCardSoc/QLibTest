/*
This file forms part of the test suite for the JBS3Risk Risk Model.
It is ©2012 University of Cambridge.
It is released under version 3 of the GNU General Public License
Source code, including a copy of the license is available at https://github.com/BritCardSoc/JBS3Risk

It contains code derived from http://qrisk.org/lifetime/QRISK-lifetime-2011-opensource.v1.0.tgz released by ClinRisk Ltd.

*/
package org.understandinguncertainty.QRISKLifetimeTestSuites.support
{
	public class RandomGenerator
	{
		private var rangeMsg:String = "param2 must be bigger than param 1";
		
		public function intIn(a:int, b:int):int
		{
			if(b < a) throw new Error(rangeMsg);
			return Math.round(a + (b-a)*Math.random());
		}
		
		public function numberIn(a:Number, b:Number):Number
		{
			if(b < a) throw new Error(rangeMsg);
			return a + (b-a)*Math.random();
		}
	}
}