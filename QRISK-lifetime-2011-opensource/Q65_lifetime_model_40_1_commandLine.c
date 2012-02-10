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
 * This file has been auto-generated.
 * XML source: Q65_lifetime_model_40_cvd_1.xml
 * STATA dta time stamp: 27 Jul 2010 17:56
 * C file create date: Tue 27 Jul 2010 22:26:38 BST
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Q65_lifetime_model_40_cvd_1.h"
#include "Q65_lifetime_model_40_death_1.h"
#include "lifetimeRisk.h"

static char errorBuf[1024];
static int error;

void usage(void) {
	printf(" * (c) 2010 ClinRisk Ltd.  All rights reserved.\n");
	printf(" * The C source for part of this program has been auto-generated.\n");
	printf(" * XML: Q65_lifetime_model_40_{cvd,death}_1.xml\n");
	printf(" * STATA dta time stamp: 27 Jul 2010 17:56\n");
	printf(" * C file create date: Tue 27 Jul 2010 22:26:38 BST\n");
	printf(" *\n");
	printf("Usage:\n");
	printf("  Q65_lifetime_model_40_1_commandLine b_AF b_ra b_renal b_treatedhyp b_type2 bmi ethrisk fh_cvd rati sbp smoke_cat town age noOfFollowupYears\n");
}

void processFile(char *filename) {
	int b_AF; int b_ra; int b_renal; int b_treatedhyp; int b_type2; double bmi; int ethrisk; int fh_cvd; double rati; double sbp; int smoke_cat; double town; int age; int noOfFollowupYears;
	int qr_patid; int row_id;

	FILE *in=fopen(filename, "r");
	double a_cvd, a_death;
	double result[2];
	int sex=1;
	char firstLine[255];
	fscanf(in, "%s\n", firstLine);
	printf("%s,nYearRisk,lifeRisk\n", firstLine);
	while (!feof(in)) {
		fscanf(in, "%d, %d, %d, %d, %d, %d, %d, %lf, %d, %d, %lf, %lf, %d, %lf, %d, %d\n", 
			&row_id, &qr_patid, &b_AF, &b_ra, &b_renal, &b_treatedhyp, &b_type2, &bmi, &ethrisk, &fh_cvd,  &rati,  &sbp, &smoke_cat, &town, &age, &noOfFollowupYears);
		printf("%d, %d, %d, %d, %d, %d, %d, %lf, %d, %d, %lf, %lf, %d, %lf, %d, %d,", 
			row_id, qr_patid, b_AF, b_ra, b_renal, b_treatedhyp, b_type2, bmi, ethrisk, fh_cvd, rati,  sbp, smoke_cat, town, age, noOfFollowupYears);

		a_cvd = cvd_male(b_AF,b_ra,b_renal,b_treatedhyp,b_type2,bmi,ethrisk,fh_cvd,rati,sbp,smoke_cat,town,&error,errorBuf,sizeof(errorBuf));
		if (error) {
			printf("%s", errorBuf);
			exit(1);
		}
		a_death = death_male(b_AF,b_ra,b_renal,b_treatedhyp,b_type2,bmi,ethrisk,fh_cvd,rati,sbp,smoke_cat,town,&error,errorBuf,sizeof(errorBuf));
		if (error) {
			printf("%s", errorBuf);
			exit(1);
		}
		
		// printf("a_cvd :%e, a_death :%e\n", a_cvd, a_death);

		lifetimeRisk(age, sex, a_cvd, a_death, noOfFollowupYears, &result[0]);
		printf(" %f, %f\n", result[0] * 100, result[1] * 100);
	}
	fclose(in);
}

int main (int argc, char *argv[]) {
	int b_AF; 
	int b_ra;
	int b_renal;
	int b_treatedhyp;
	int b_type2;
	double bmi;
	int ethrisk;
	int fh_cvd;
	double rati;
	double sbp;
	int smoke_cat;
	double town; 
	int age;
	int noOfFollowupYears;
	double a_cvd;
	double a_death;
	double result[2];

	int sex=1;

	if (argc!=15) {
		usage();
		exit(1);
	}

	lifetimeRiskInit();

	b_AF = atoi(argv[1]);
	b_ra = atoi(argv[2]);
	b_renal = atoi(argv[3]);
	b_treatedhyp = atoi(argv[4]);
	b_type2 = atoi(argv[5]);
	bmi = atof(argv[6]);
	ethrisk = atoi(argv[7]);
	fh_cvd = atoi(argv[8]);
	rati = atof(argv[9]);
	sbp = atof(argv[10]);
	smoke_cat = atoi(argv[11]);
	town = atof(argv[12]);
	age = atoi(argv[13]);
	noOfFollowupYears = atoi(argv[14]);

	a_cvd = cvd_male(b_AF,b_ra,b_renal,b_treatedhyp,b_type2,bmi,ethrisk,fh_cvd,rati,sbp,smoke_cat,town,&error,errorBuf,sizeof(errorBuf));
	if (error) {
		printf("%s", errorBuf);
		exit(1);
	}
	a_death = death_male(b_AF,b_ra,b_renal,b_treatedhyp,b_type2,bmi,ethrisk,fh_cvd,rati,sbp,smoke_cat,town,&error,errorBuf,sizeof(errorBuf));
	if (error) {
		printf("%s", errorBuf);
		exit(1);
	}
	
	lifetimeRisk(age, sex, a_cvd, a_death, noOfFollowupYears, &result[0]);

	printf("%f, %f\n", result[0] * 100, result[1] * 100);

	lifetimeRiskClose();
}
