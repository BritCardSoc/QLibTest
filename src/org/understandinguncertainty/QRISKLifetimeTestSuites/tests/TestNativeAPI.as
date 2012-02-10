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
	import org.understandinguncertainty.QRLifetime.vo.QParametersVO;
	import org.understandinguncertainty.QRLifetime.vo.QResultVO;
	import org.understandinguncertainty.QRiskLifetime.NativeScore2011;

	public class TestNativeAPI
	{
		private var nativeScore:NativeScore2011;
		private var asyncHandler:Function = null;
		
		[Before]
		public function runBeforeEveryTest():void 
		{   
			nativeScore = new NativeScore2011();
		}  
		
		[After]
		public function runAfterEveryTest():void
		{
			// cleanup event handlers
			if(asyncHandler != null && nativeScore) {
				nativeScore.removeEventListener(Event.COMPLETE, asyncHandler);
				asyncHandler = null;
			}
		}
		
				
		/**
		 * Check we have a valid nativeScore instance
		 */
		[Test]  
		public function nativeScoreNotNull():void 
		{
			Assert.assertTrue(nativeScore is NativeScore2011);
		}
				
		/**
		 * One-off test to ensure native process API is calling the QRISK-lifetime-2011 C code properly
		 */
		[Test(async, timeout=500)]
		public function calculateReturnsGoodResult():void
		{
			asyncHandler = Async.asyncHandler(this, checkResult, 500);
			nativeScore.addEventListener(Event.COMPLETE, asyncHandler);
			nativeScore.calculateScore(new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 10));
		}
		
		private function checkResult(event:Event, data:*):void
		{
			var result:QResultVO = nativeScore.result;
			if(result.error != null) {
				Assert.fail(result.error.message);
			}
			else {
				Assert.assertEquals("nYearRisk mismatch", 7.879116, result.nYearRisk);
				Assert.assertEquals("lifetimeRisk mismatch", 23.706344, result.lifetimeRisk);
			}
		}

		/**
		 * One-off test to check that Townsend centering value is used by QRISK website when Townsend score not given
		 */
		[Test(async, timeout=500)]
		public function checkTownsendCentre():void
		{
			asyncHandler = Async.asyncHandler(this, checkResult2, 500);
			nativeScore.addEventListener(Event.COMPLETE, asyncHandler);
			nativeScore.calculateScore(new QParametersVO(1, 0, 0, 0, 0, 0, 21.2, 1, 0, 4.74, 130, 0, -0.164980158209801, 40, 10));
		}
		
		private function checkResult2(event:Event, data:*):void
		{
			var result:QResultVO = nativeScore.result;
			if(result.error != null) {
				Assert.fail(result.error.message);
			}
			else {
				//Assert.assertEquals("nYearRisk mismatch", 7.879116, result.nYearRisk);
				Assert.assertEquals("lifetimeRisk mismatch", 33.181872, result.lifetimeRisk);
			}
		}
		
		/**
		 * Test whether Native API returns sensible result when noOfFollowUpYears == 0
		 */
		[Test(async, timeout=500)]
		public function zeroFollowUpReturnsGoodResult():void
		{
			asyncHandler = Async.asyncHandler(this, zeroFollowUpResult, 500);
			nativeScore.addEventListener(Event.COMPLETE, asyncHandler);
			nativeScore.calculateScore(new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0));
		}
		
		private function zeroFollowUpResult(event:Event, data:*):void
		{
			var result:QResultVO = nativeScore.result;
			if(result.error != null) {
				Assert.fail(result.error.message);
			}
			else {
				Assert.assertEquals("nYearRisk mismatch", 0, result.nYearRisk);
				Assert.assertEquals("lifetimeRisk mismatch", 23.706344, result.lifetimeRisk);
			}
		}
		

	}
}