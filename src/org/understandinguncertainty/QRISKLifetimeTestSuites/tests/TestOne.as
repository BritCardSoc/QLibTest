/*
This file forms part of the test suite for the JBS3Risk Risk Model.
It is ©2012 University of Cambridge.
It is released under version 3 of the GNU General Public License
Source code, including a copy of the license is available at https://github.com/BritCardSoc/JBS3Risk

It contains code derived from http://qrisk.org/lifetime/QRISK-lifetime-2011-opensource.v1.0.tgz released by ClinRisk Ltd.

*/
package org.understandinguncertainty.QRISKLifetimeTestSuites.tests
{	
	import flash.desktop.NativeProcess;
	import flash.events.Event;
	import flash.events.NativeProcessExitEvent;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.understandinguncertainty.QRLifetime.FlashScore2011;
	import org.understandinguncertainty.QRLifetime.vo.QParametersVO;
	import org.understandinguncertainty.QRLifetime.vo.QResultVO;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.support.Neighbours;
	import org.understandinguncertainty.QRiskLifetime.NativeScore2011;

	public class TestOne
	{
		private var nativeScore:NativeScore2011;
		private var flashScore:FlashScore2011;
		private var nativeHandler:Function = null;
		private var flashHandler:Function = null;
		private const path0:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_0.csv";
		private const path1:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_1.csv";
		private var neighbours:Neighbours = new Neighbours();
		
		[Before]
		public function runBeforeEveryTest():void 
		{   
			nativeScore = new NativeScore2011();
			flashScore = new FlashScore2011();
		}  
		
		[After]
		public function runAfterEveryTest():void
		{
			// cleanup event handlers
			if(nativeHandler != null && nativeScore) {
				nativeScore.removeEventListener(Event.COMPLETE, nativeHandler);
				nativeHandler = null;
			}
			if(flashHandler != null && flashScore) {
				flashScore.removeEventListener(Event.COMPLETE, flashHandler);
				flashHandler = null;
			}
		}
				
		/**
		 * Check that we can call both APIs in one test.
		 * The parameters here are chosen to ensure we have the same strange initialisation code that is used in
		 * the QRISK model. 
		 */
		[Test(async, timeout=3000)]
		public function nativeMatchesFlashOnce():void
		{
			flashHandler = Async.asyncHandler(this, nativeMatchesFlashDone, 3000);
			
			// Enable the slowest interface (usually the native one!)
			//flashScore.addEventListener(Event.COMPLETE, flashHandler);
			nativeScore.addEventListener(Event.COMPLETE, flashHandler);
			
			var p:QParametersVO = new QParametersVO(1, 0, 1, 0, 1, 1, 31.443219585344195, 4, 1, 9.393430596683714, 195.8744810614735, 3, 7.6712042689323425, 40, 30);
			flashScore.calculateScore(path1, p);
			nativeScore.calculateScore(p);
		}
		
		private function nativeMatchesFlashDone(event:Event, data:*):void
		{
			// We're assuming that both tests have completed here since flash is slower than C
			if(flashScore.result.error != null) {
				Assert.fail(flashScore.result.error.message);
			}
			else {
//				trace("flash = "+flashScore.result.nYearRisk, "native = "+ nativeScore.result.nYearRisk);
				Assert.assertTrue("nYearRisk match", neighbours.areClose(flashScore.result.nYearRisk, nativeScore.result.nYearRisk));
				Assert.assertTrue("lifetimeRisk match", neighbours.areClose(flashScore.result.lifetimeRisk, nativeScore.result.lifetimeRisk));
			}
		}
		
	}
}