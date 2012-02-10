/*
This file forms part of the test suite for the JBS3Risk Risk Model.
It is ©2012 University of Cambridge.
It is released under version 3 of the GNU General Public License
Source code, including a copy of the license is available at https://github.com/BritCardSoc/JBS3Risk

It contains code derived from http://qrisk.org/lifetime/QRISK-lifetime-2011-opensource.v1.0.tgz released by ClinRisk Ltd.

*/
package org.understandinguncertainty.QRISKLifetimeTestSuites
{
	import org.understandinguncertainty.QRISKLifetimeTestSuites.tests.CompareFlashNative;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.tests.RandomParameters;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.tests.TestBin;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.tests.TestFlashAPI;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.tests.TestLifetime;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.tests.TestNativeAPI;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.tests.TestOne;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class Suite {
		public var t0:TestNativeAPI;
		public var t1:TestFlashAPI;
		public var t2:TestOne;
		public var t3:CompareFlashNative;
		public var t4:RandomParameters;
		public var t5:TestLifetime;
		public var t6:TestBin;
	}

}