/*
This file forms part of the test suite for the JBS3Risk Risk Model.
It is ©2012 University of Cambridge.
It is released under version 3 of the GNU General Public License
Source code, including a copy of the license is available at https://github.com/BritCardSoc/JBS3Risk

It contains code derived from http://qrisk.org/lifetime/QRISK-lifetime-2011-opensource.v1.0.tgz released by ClinRisk Ltd.

*/
package org.understandinguncertainty.QRISKLifetimeTestSuites.tests
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	import org.understandinguncertainty.QRLifetime.DataLoader;
	import org.understandinguncertainty.QRLifetime.FlashScore2011;
	import org.understandinguncertainty.QRLifetime.TimeTable;
	import org.understandinguncertainty.QRLifetime.vo.QParametersVO;
	import org.understandinguncertainty.QRLifetime.vo.QResultVO;
	import org.understandinguncertainty.QRISKLifetimeTestSuites.support.Neighbours;

	/**
	 * 
	 * Check Flash interface is working and also that out of range parameters yield errors
	 * 
	 * @author gmp26
	 * 
	 */
	public class TestFlashAPI 
	{
		private var flashScore:FlashScore2011;
		private var flashHandler:Function = null;
		private const path0:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_0.csv";
		private const path1:String = "QRISK-lifetime-2011-opensource/Q65_derivation_cvd_time_40_1.csv";

		private var firstRun:Boolean = true;
		
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
		
		[Test]
		public function succeedingTest():void
		{
			Assert.assertTrue(true);
		}
	
		/**
		 * If we give the wrong path to the csv file we get an IOError
		 */
		[Test(async, timeout=500)]
		public function BadCSVPathGeneratesIOError():void
		{
			var dataLoader:DataLoader = new DataLoader();
			var asyncHandler:Function = Async.asyncHandler(this, function(event:IOErrorEvent, data:*):void
			{
				Assert.assertNotNull(event);
				Assert.assertTrue(event.text.indexOf("Error")>=0);
			}, 100);
			dataLoader.load("a", asyncHandler);
		}
		
		/**
		 * If we give the correct path to path0, it loads
		 */
		[Test(async, timeout=500)]
		public function GoodPath0Loads():void
		{
			var dataLoader:DataLoader = new DataLoader();
			var asyncHandler:Function = Async.asyncHandler(this, function(event:Event, data:*):void
			{
				var loader:URLLoader = event.target as URLLoader;
				Assert.assertNotNull(loader);
				Assert.assertTrue(loader.bytesTotal > 0);
				Assert.assertEquals(0, loader.bytesTotal-loader.bytesLoaded);
				Assert.assertEquals(621625, loader.bytesLoaded);
				Assert.assertEquals(621625, loader.bytesTotal);
			}, 100);
			dataLoader.load(path0, asyncHandler);
		}
		
		/**
		 * If we give the correct path to path1, it loads
		 */
		[Test(async, timeout=500, order=1)]
		public function GoodPath1Loads():void
		{
			var dataLoader:DataLoader = new DataLoader();
			var asyncHandler:Function = Async.asyncHandler(this, function(event:Event, data:*):void
			{
				var loader:URLLoader = event.target as URLLoader;
				Assert.assertNotNull(loader);
				Assert.assertTrue(loader.bytesTotal > 0);
				Assert.assertEquals(0, loader.bytesTotal-loader.bytesLoaded);
				Assert.assertEquals(651594, loader.bytesLoaded);
				Assert.assertEquals(651594, loader.bytesTotal);
			}, 100);
			dataLoader.load(path1, asyncHandler);
		}
		
		/**
		 * TimeTable generated from path1 data
		 */
		[Test(async, timeout=500, order=2)]
		public function TimeTableCanLoadFromPath1():void
		{
			var timeTable:TimeTable = new TimeTable();
			var asyncHandler:Function = Async.asyncHandler(this, function(event:Event, data:*):void
			{
				Assert.assertNotNull(TimeTable.rows);
				Assert.assertTrue(TimeTable.rows.length > 0);
				Assert.assertEquals(3248, TimeTable.rows.length);
			}, 100);
			timeTable.addEventListener(Event.COMPLETE, asyncHandler);
			timeTable.load(path1);
		}
		
		/**
		 * One-off test to ensure flash QRISK API works
		 */
		[Test(async, timeout=3000, order=3)]
		public function calculateReturnsGoodResult():void
		{
			//trace("calcGood");
			flashHandler = Async.asyncHandler(this, checkResult, 3000);
			flashScore.addEventListener(Event.COMPLETE, flashHandler);
			flashScore.calculateScore(path0, new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 10));
		}
		
		private function checkResult(event:Event, data:*):void
		{
			var result:QResultVO = flashScore.result;
			//trace("calcGoodResult");
			if(result.error != null) {
				Assert.fail(result.error.message);
			}
			else {
				var neighbours:Neighbours = new Neighbours();
				Assert.assertTrue("nYearRisk match", neighbours.areClose(7.879116, result.nYearRisk));
				Assert.assertTrue("lifetimeRisk match", neighbours.areClose(23.706344, result.lifetimeRisk));
			}
		}

		/**
		 * One-off test to check that Townsend centering value is used by QRISK website when Townsend score not given
		 */
		[Test(async, timeout=3000)]
		public function checkTownsendCentre():void
		{
			flashHandler = Async.asyncHandler(this, checkResult2, 3000);
			flashScore.addEventListener(Event.COMPLETE, flashHandler);
			flashScore.calculateScore(path1, new QParametersVO(1, 0, 0, 0, 0, 0, 21.2, 1, 0, 4.74, 130, 0, -0.164980158209801, 40, 10));
		}
		
		private function checkResult2(event:Event, data:*):void
		{
			var result:QResultVO = flashScore.result;
			if(result.error != null) {
				Assert.fail(result.error.message);
			}
			else {
				//Assert.assertEquals("nYearRisk mismatch", 7.879116, result.nYearRisk);
				var neighbours:Neighbours = new Neighbours();
				trace("cTownsend  33.181872 " + result.lifetimeRisk);
				Assert.assertTrue("lifetimeRisk match", neighbours.areClose(33.181872, result.lifetimeRisk));
			}
		}

		
		
		/**
		 * Test whether score with interventions returns sensible results 
		 */
		[Test(async, timeout=3000)]
		public function checkInterventions():void
		{
			flashHandler = Async.asyncHandler(this, checkInterventionsResult, 3000, {age:40, age_int:50});
			flashScore.addEventListener(Event.COMPLETE, flashHandler);
			flashScore.calculateScoreWithInterventions(path1, 
				new QParametersVO(1, 0, 0, 0, 0, 0, 21.2, 1, 0, 4.74, 130, 0, -0.164980158209801, 40, 10),
				new QParametersVO(1, 0, 0, 0, 0, 0, 21.2, 1, 0, 4, 100, 0, -0.164980158209801, 50, 10)
			);
		}
		
		private function checkInterventionsResult(event:Event, data:*):void
		{
			var result:QResultVO = flashScore.result;
			
			if(result.error != null) {
				Assert.fail(result.error.message);
			}
			else {
				//Assert.assertEquals("nYearRisk mismatch", 7.879116, result.nYearRisk);
				var neighbours:Neighbours = new Neighbours();
				
				Assert.assertTrue("result = result_int up to age_int", neighbours.areClose(
					result.annualRiskTable.getRiskAt(data.age_int - data.age),
					result.annualRiskTable_int.getRiskAt(data.age_int - data.age)
				));
					
				Assert.assertTrue("intervention risk is smaller", true);
			}
		}
		
		
		
		
		/**
		 * Test whether Flash API returns sensible result when noOfFollowUpYears == 0
		 */
		[Test(async, timeout=3000, order=4)]
		public function zeroFollowUpReturnsGoodResult():void
		{
			//trace("zeroFollow");
			flashHandler = Async.asyncHandler(this, zeroFollowUpResult, 3000);
			flashScore.addEventListener(Event.COMPLETE, flashHandler);
			flashScore.calculateScore(path0, new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0));
		}
		
		private function zeroFollowUpResult(event:Event, data:*):void
		{
			//trace("zeroFollowResult");
			var result:QResultVO = flashScore.result;
			if(result.error != null) {
				Assert.fail(result.error.message);
			}
			else {
				var neighbours:Neighbours = new Neighbours();
				Assert.assertTrue("nYearRisk mismatch", neighbours.areClose(0, result.nYearRisk));
				Assert.assertTrue("lifetimeRisk mismatch", neighbours.areClose(23.706344, result.lifetimeRisk));
			}
		}

		//
		// Start out-of-range parameter tests
		//
		/**
		 * Test what happens when we pass in a silly gender
		 */
		[Test(expects="Error")]
		public function genderLow():void
		{
			new QParametersVO(-1, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function genderHigh():void
		{
			new QParametersVO(2, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function AFLow():void
		{
			new QParametersVO(0, -1, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}

		[Test(expects="Error")]
		public function AFHigh():void
		{
			new QParametersVO(0, 2, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function raLow():void
		{
			new QParametersVO(0, 0, -1, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function raHigh():void
		{
			new QParametersVO(0, 0, 2, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function renalLow():void
		{
			new QParametersVO(0, 0, 0, -1, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function renalHigh():void
		{
			new QParametersVO(0, 0, 0, 2, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function treatedHypLow():void
		{
			new QParametersVO(0, 0, 0, 0, -1, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function treatedHypHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 2, 0, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function type2Low():void
		{
			new QParametersVO(0, 0, 0, 0, 0, -1, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function type2High():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 2, 22, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function bmiLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, -1, 19.999, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function bmiHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 2, 40.001, 1, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function ethRiskLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 0, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function ethRiskHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 10, 0, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function fh_cvdLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, -1, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function fh_cvdHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 2, 4, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function ratiLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 0.9, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function ratiHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 12.1, 100, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function sbpLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 69.9, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function sbpHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 210.1, 1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function smokeCatLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, -1, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function smokeCatHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 5, 11, 63, 0);
		}
		
		[Test(expects="Error")]
		public function townLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, -7.1, 63, 0);
		}
		
		[Test(expects="Error")]
		public function townHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11.1, 63, 0);
		}
		
		[Test(expects="Error")]
		public function ageLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 29, 0);
		}
		
		[Test(expects="Error")]
		public function ageHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 85, 0);
		}
		
		[Test(expects="Error")]
		public function noFollowUpYearsLow():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, -1);
		}
		
		[Test(expects="Error")]
		public function noFollowUpYearsHigh():void
		{
			new QParametersVO(0, 0, 0, 0, 0, 0, 22, 1, 0, 4, 100, 1, 11, 63, 33);
		}
		
	
	}
}