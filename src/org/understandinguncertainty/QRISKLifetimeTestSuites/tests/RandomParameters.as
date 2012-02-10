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
	import org.flexunit.runners.Parameterized;
	import org.understandinguncertainty.QRLifetime.FlashScore2011;
	import org.understandinguncertainty.QRLifetime.vo.QParametersVO;
	import org.understandinguncertainty.QRLifetime.vo.QResultVO;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.support.Neighbours;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.support.RandomGenerator;
	import org.understandinguncertainty.QRiskLifetime.NativeScore2011;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class RandomParameters
	{
		private var nativeScore:NativeScore2011;
		private var flashScore:FlashScore2011;
		private var nativeHandler:Function = null;
		private var flashHandler:Function = null;
		private const path0:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_0.csv";
		private const path1:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_1.csv";
		private var neighbours:Neighbours = new Neighbours();
		
		private var foo:Parameterized; // not sure if this is needed???
		
		private var params:QParametersVO;
		
		function RandomParameters(p:QParametersVO)
		{
			params = p;
		}
		
//		private static var calls:int = 0; 
		private static const rootCount:int = 3;
		
		[Parameters]
		public static function testData():Array {
			// generate test samples
			var rand:RandomGenerator = new RandomGenerator();
			var params:Array = [];
			
			// Note that for obscure flexunit reasons to do with how parameterised tests
			// are called, rootCount is the square root of the number of tests actually run
			
			for(var i:int = 0; i < rootCount; i++) {
				var age:int = rand.intIn(30, 84);
				
				params[i] = [new QParametersVO(
					rand.intIn(0,1), // b_gender
					rand.intIn(0,1), // b_AF
					rand.intIn(0,1), // b_ra
					rand.intIn(0,1), // b_renal
					rand.intIn(0,1), // b_treatedhyp
					rand.intIn(0,1), // b_type2
					rand.numberIn(20,40), // bmi
					rand.intIn(1, 9), // ethRisk
					rand.intIn(0,1), // fh_cvd
					rand.numberIn(1,12), // rati (cholesterol ratio)
					rand.numberIn(70,210), // sbp (systolic blood pressure)
					rand.intIn(0,4), // smoke_cat
					rand.numberIn(-7, 11), // townsend score
					age,
					rand.intIn(1, 95-age) // noOfFollowUpYears
				)];
			}
//			trace("calls = "+ ++calls);
			return params;
		}
		
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
		 * 100 random samples over whole in-range parameter space
		 */
		[Test(async, timeout=3000, dataProvider="testData")]
		public function nativeMatchesFlash(p:QParametersVO):void
		{		
//			trace(p);
			flashHandler = Async.asyncHandler(this, nativeMatchesFlashDone, 3000);
			
			// Enable the slowest interface 
			// ##adjust##
//			flashScore.addEventListener(Event.COMPLETE, flashHandler);
			nativeScore.addEventListener(Event.COMPLETE, flashHandler);
			
			flashScore.calculateScore(this["path"+p.b_gender], p);
			nativeScore.calculateScore(p);
			
		}
		
		private static var maxError:Number = 0;
		
		private function nativeMatchesFlashDone(event:Event, data:*):void
		{
			// We're assuming that both tests have completed here. If not, adjust which event triggers this
			// handler at ##adjust## above
			if(flashScore.result.error != null) {
				Assert.fail(flashScore.result.error.message);
			}
			else if(nativeScore.result.error != null) {
				Assert.fail(nativeScore.result.error.message);
			}
			else {
//				var error:Number = (flashScore.result.nYearRisk-nativeScore.result.nYearRisk);
//				maxError = Math.max(maxError, Math.abs(error));
				
				var nYearMatch:Boolean = neighbours.areClose(flashScore.result.nYearRisk, nativeScore.result.nYearRisk);
				var lifetimeMatch:Boolean = neighbours.areClose(flashScore.result.lifetimeRisk, nativeScore.result.lifetimeRisk);
				if(!(nYearMatch && lifetimeMatch)) {
					trace(params + " nyD:" 
						+ (flashScore.result.nYearRisk - nativeScore.result.nYearRisk).toPrecision(3)
						+ " lfD:" 
						+ (flashScore.result.lifetimeRisk - nativeScore.result.lifetimeRisk).toPrecision(3));
				}
				Assert.assertTrue("nYearRisk match" + flashScore.result.nYearRisk + "," + nativeScore.result.nYearRisk, neighbours.areClose(flashScore.result.nYearRisk, nativeScore.result.nYearRisk));
				Assert.assertTrue("lifetimeRisk match" + flashScore.result.lifetimeRisk + "," + nativeScore.result.lifetimeRisk, neighbours.areClose(flashScore.result.lifetimeRisk, nativeScore.result.lifetimeRisk));
			}
		}
	}
}
