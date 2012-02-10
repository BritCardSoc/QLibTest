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

	public class TestLifetime
	{
		private var flashScore:FlashScore2011;
		private var flashHandler:Function = null;
		private const path0:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_0.csv";
		private const path1:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_1.csv";
		private var neighbours:Neighbours = new Neighbours();
		
		[Before]
		public function runBeforeEveryTest():void 
		{   
			flashScore = new FlashScore2011();
		}  
		
		[After]
		public function runAfterEveryTest():void
		{
			// cleanup event handlers
			if(flashHandler != null && flashScore) {
				flashScore.removeEventListener(Event.COMPLETE, flashHandler);
				flashHandler = null;
			}
		}
				
		/**
		 * Check that annual table agrres with nYearRisks as returned by Q
		 */
		[Test(async, timeout=3000)]
		public function test1():void
		{
			doTest({age:63, nYears:2});
		}
		
		[Test(async, timeout=3000)]
		public function test2():void
		{
			doTest({age:35, nYears:20});
		}
		
		[Test(async, timeout=3000)]
		public function test3():void
		{
			doTest({age:50, nYears:40});
		}
		
		[Test(async, timeout=3000)]
		public function test4():void
		{
			doTest({age:84, nYears:11});
		}
		
		private function doTest(data:Object):void
		{
			flashHandler = Async.asyncHandler(this, checkOne, 3000, data);
			flashScore.addEventListener(Event.COMPLETE, flashHandler);
			
			var p:QParametersVO = new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, data.age, data.nYears);
			flashScore.calculateScore(path0, p);
			
		}
		
		private function checkOne(event:Event, data:*):void
		{
			// We're assuming that both tests have completed here since flash is slower than C
			if(flashScore.result.error != null) {
				Assert.fail(flashScore.result.error.message);
			}
			else {
//				trace("comparing "+flashScore.result.nYearRisk, flashScore.lifetimeRisk.annualRiskTable.getRiskAt(data.nYears));
				Assert.assertTrue("nYearRisk match", neighbours.areClose(flashScore.result.nYearRisk, 100*flashScore.result.annualRiskTable.getRiskAt(data.nYears)));
			}
		}
		
	}
}