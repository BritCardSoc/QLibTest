/*
 * Copyright 2010 ClinRisk Ltd.
 *
 * This file is part of QRISK-lifetime-2011 (http://qrisk.org/lifetime).
 *
 * QRISK-lifetime-2011 is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * QRISK-lifetime-2011 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with QRISK-lifetime-2011.  If not, see <http://www.gnu.org/licenses/>.
 *
 * The initial version of this file, to be found at http://qrisk.org/lifetime, faithfully implements QRISK-lifetime-2011.
 * We have released this code under the GNU Lesser General Public License to enable others to implement the algorithm faithfully.
 * However, the nature of the GNU Lesser General Public License is such that we cannot prevent, for example, someone randomly permuting the coefficients.
 * We stress, therefore, that it is the responsibility of the end user to check that the source that they receive produces the same results as the original code posted at http://qrisk.org/lifetime.
 * Inaccurate implementations of risk scores can lead to wrong patients being given the wrong treatment.
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "lifetimeRisk.h"

#define SIZE_OF_TIME_FILE 24000

unsigned long arrayNumberOfRowsFemale;
double *timeTableFemale;

unsigned long arrayNumberOfRowsMale;
double *timeTableMale;

double *resultArray;

void loadTables(void) {

	unsigned long timeTableSize = sizeof(double)*SIZE_OF_TIME_FILE*3;
	unsigned long resultTableSize = sizeof(double)*SIZE_OF_TIME_FILE*2;
	double a,b,c;
	double *index;
	FILE *in;
	char tmp[512];
	int ret;

	timeTableFemale = malloc(timeTableSize);
	if (timeTableFemale==NULL) {
		printf("alloc of %lu bytes failed\n", timeTableSize);
		exit(1);
	}
	timeTableMale = malloc(timeTableSize);
	if (timeTableMale==NULL) {
		printf("alloc of %lu bytes failed\n", timeTableSize);
		exit(1);
	}
	resultArray = malloc(resultTableSize);
	if (resultArray==NULL) {
		printf("alloc of %lu bytes failed\n", resultTableSize);
		exit(1);
	}

	index=timeTableFemale;
	in=fopen("Q65_derivation_cvd_time_40_0.csv","r");
	if (in==NULL) {
		printf("Q65_derivation_cvd_time_40_0.csv not found!\n");
		return;
	}
	arrayNumberOfRowsFemale=0;
	while ( (ret=fscanf(in, "#%[^\n]\n",tmp)) > 0);
	fscanf(in,"%*s\r\n");
	while (!feof(in)) {
		fscanf(in, "%*d,%lf,%lf,%lf,%*d\r\n", &a, &b, &c);
		*(index++)=a;
		*(index++)=b;
		*(index++)=c;
		arrayNumberOfRowsFemale++;
		if (arrayNumberOfRowsFemale >= SIZE_OF_TIME_FILE) {
			printf("Time file too big: need to recompile!\n");
			exit(1);
		}
	}
	fclose(in);

	index=timeTableMale;
	in=fopen("Q65_derivation_cvd_time_40_1.csv","r");
	if (in==NULL) {
		printf("Q65_derivation_cvd_time_40_1.csv not found!\n");
		return;
	}
	arrayNumberOfRowsMale=0;
	while ( (ret=fscanf(in, "#%[^\n]\n", tmp)) > 0);
	fscanf(in,"%*s\r\n");
	while (!feof(in)) {
		fscanf(in, "%*d,%lf,%lf,%lf,%*d\r\n", &a, &b, &c);
		*(index++)=a;
		*(index++)=b;
		*(index++)=c;
		arrayNumberOfRowsMale++;
		if (arrayNumberOfRowsMale >= SIZE_OF_TIME_FILE) {
			printf("Time file too big: need to recompile!\n");
			exit(1);
		}
	}
	fclose(in);
}

int find_biggest_t_below_number_in_array(int number, double *array, int arrayNumberOfRows) {
	double *index=array;
	int i;
	int found=0;
	// First check the first number in the table
	// If that's bigger than the number we seek, return -2
	if (*index >= number) {
		return -2;
	}
	for (i=0; i< arrayNumberOfRows; i++) {
		if (*index >= number) {
			found=1;
			break;
		}
		index+=3;
	}
	if (found) {
		i--;
	}
	else {
		i=-1;
	}
	return i;
}

// Create new array
// & form the product and sum as we go
// return the array
// NB need to multiply cif by 100 to get percentage

double *produceLifetimeRiskTable(double *timeTable, int from, int to, double a_cvd, double a_death) {
	int i;
	// S_1, sum(S_1[n-1] * basehaz_cvd_1) 
	double *lifetimeRiskTable = resultArray;
	double *lifetimeRiskIndex = lifetimeRiskTable;

	// do the first S_1, cif_cvd_1
	double *timeTableIndex = timeTable + from*3;
	double basehaz_cvd_0 = *(timeTableIndex+2);
	double basehaz_death_0 = *(timeTableIndex+1);
	double basehaz_cvd_1 = basehaz_cvd_0 * exp(a_cvd);
	double basehaz_death_1 = basehaz_death_0 * exp(a_death);
	double a = 1 - basehaz_cvd_1 - basehaz_death_1; 
	// S_1
	*(lifetimeRiskIndex++)=a; 
	// cif_cvd_1
	*(lifetimeRiskIndex++)=0;
	// next index
	timeTableIndex+=3;
	// do the rest
//	printf("from = %d, to=%d\n", from, to);
	for (i=1; i < (to-from+1); i++, timeTableIndex+=3, lifetimeRiskIndex+=2) {
		basehaz_cvd_0 = *(timeTableIndex+2);
		basehaz_death_0 = *(timeTableIndex+1);
		basehaz_cvd_1 = basehaz_cvd_0 * exp(a_cvd);
		basehaz_death_1 = basehaz_death_0 * exp(a_death);
		a = 1 - basehaz_cvd_1 - basehaz_death_1; 
		// S_1
		*lifetimeRiskIndex=*(lifetimeRiskIndex-2)*a;
		// cif_cvd
		*(lifetimeRiskIndex+1) = *(lifetimeRiskIndex-1) + *(lifetimeRiskIndex-2) * basehaz_cvd_1;
//		printf("S1=%g, cif_cvd=%g, cif_dth=%g\n", a, *lifetimeRiskIndex, *(lifetimeRiskIndex+1));
	}

	return lifetimeRiskTable;
}

void lifetimeRiskInit(void) {
	loadTables();
}

void lifetimeRiskClose(void) {
	free(resultArray);
	free(timeTableFemale);
	free(timeTableMale);
}

void lifetimeRisk(int cage, int sex, double a_cvd, double a_death, int noOfFollowupYears, double *result) {
	int sage=30;
	int lage=95;
	int startRow;
	int finishRow;
	int resultArraySize;
	double lifetimeRisk;
	int followupIndex;
	double nYearRisk;

	double *timeTable;
	int arrayNumberOfRows;
	if (sex==0) {
		timeTable = timeTableFemale;
		arrayNumberOfRows=arrayNumberOfRowsFemale;
	}
	else {
		timeTable = timeTableMale;
		arrayNumberOfRows=arrayNumberOfRowsMale;
	}

	// start row is the one with the first _t >= cage-sage
	startRow=find_biggest_t_below_number_in_array(cage-sage, timeTable, arrayNumberOfRows)+1;
	// last row in table has index arrayNumberOfRows -1
	finishRow=arrayNumberOfRows-1;
	resultArraySize = finishRow-startRow+1;

	resultArray = produceLifetimeRiskTable(timeTable, startRow, finishRow, a_cvd, a_death);

	// get lifetime risk
	// this is the last entry in the table!
	lifetimeRisk = *(resultArray + 2*(resultArraySize-1) + 1);	

	// get n-year risk
	followupIndex = cage-sage+noOfFollowupYears;

	// if too big, use lifetime risk instead!
	if (followupIndex >= lage-sage) {
		nYearRisk = lifetimeRisk;
	}
	else {
		int followupRow = find_biggest_t_below_number_in_array(followupIndex, timeTable, arrayNumberOfRows);
		nYearRisk = *(resultArray + 2*(followupRow-startRow) + 1);	
	}

	*result = nYearRisk;
	*(result+1) = lifetimeRisk;

	return; 
}

