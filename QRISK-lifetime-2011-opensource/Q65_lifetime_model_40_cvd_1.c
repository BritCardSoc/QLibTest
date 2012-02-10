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
 * C file create date: Tue 27 Jul 2010 22:26:44 BST
 */

#include <math.h>
#include <string.h>
#include "Q65_lifetime_model_40_cvd_1.h"
#include "util.h"

static double cvd_male_raw(
int b_AF,int b_ra,int b_renal,int b_treatedhyp,int b_type2,double bmi,int ethrisk,int fh_cvd,double rati,double sbp,int smoke_cat,double town
)
{
	double a;
	double bmi_1;

	/* The conditional arrays */

	double Iethrisk[10] = {
		0,
		0,
		0.4035656542786645300000000,
		0.7159343574607238700000000,
		0.7588068966921870400000000,
		0.2778257996405138500000000,
		-0.3383277413537653700000000,
		-0.3626891973109574500000000,
		-0.2406220118164148500000000,
		-0.1055741084408314400000000
	};
	double Ismoke[5] = {
		0,
		0.1655389770495527800000000,
		0.3227167436634277900000000,
		0.4393091679622852500000000,
		0.5830168090609184600000000
	};

	/* Applying the fractional polynomial transforms */
	/* (which includes scaling)                      */

	double dbmi = bmi;
	dbmi=dbmi/10;
	bmi_1 = log(dbmi);

	/* Centring the continuous variables */

	bmi_1 = bmi_1 - 0.967572152614594;
	rati = rati - 4.439734935760498;
	sbp = sbp - 133.265686035156250;
	town = town - -0.164980158209801;

	/* Start of Sum */
	a=0;

	/* The conditional sums */

	a += Iethrisk[ethrisk];
	a += Ismoke[smoke_cat];

	/* Sum from continuous values */

	a += bmi_1 * 0.4325953310683352500000000;
	a += rati * 0.1616093175199347100000000;
	a += sbp * 0.0051706475575211365000000;
	a += town * 0.0118372789415412600000000;

	/* Sum from boolean values */

	a += b_AF * 0.4871573476846625100000000;
	a += b_ra * 0.3165460738113234400000000;
	a += b_renal * 0.4665323499934942400000000;
	a += b_treatedhyp * 0.3146452536778831000000000;
	a += b_type2 * 0.4700445024972483300000000;
	a += fh_cvd * 0.6101222792348441900000000;

	/* Sum from interaction terms */


	/* Calculate the score itself */
	return a;
}

static int cvd_male_validation(
int b_AF,int b_ra,int b_renal,int b_treatedhyp,int b_type2,double bmi,int ethrisk,int fh_cvd,double rati,double sbp,int smoke_cat,double town,char *errorBuf,int errorBufSize
)
{
	int ok=1;
	*errorBuf=0;
	if (!is_boolean(b_AF)) {
		ok=0;
		strlcat(errorBuf,"error: b_AF must be in range (0,1)\n",errorBufSize);
	}
	if (!is_boolean(b_ra)) {
		ok=0;
		strlcat(errorBuf,"error: b_ra must be in range (0,1)\n",errorBufSize);
	}
	if (!is_boolean(b_renal)) {
		ok=0;
		strlcat(errorBuf,"error: b_renal must be in range (0,1)\n",errorBufSize);
	}
	if (!is_boolean(b_treatedhyp)) {
		ok=0;
		strlcat(errorBuf,"error: b_treatedhyp must be in range (0,1)\n",errorBufSize);
	}
	if (!is_boolean(b_type2)) {
		ok=0;
		strlcat(errorBuf,"error: b_type2 must be in range (0,1)\n",errorBufSize);
	}
	if (!d_in_range(bmi,20,40)) {
		ok=0;
		strlcat(errorBuf,"error: bmi must be in range (20,40)\n",errorBufSize);
	}
	if (!i_in_range(ethrisk,1,9)) {
		ok=0;
		strlcat(errorBuf,"error: ethrisk must be in range (1,9)\n",errorBufSize);
	}
	if (!is_boolean(fh_cvd)) {
		ok=0;
		strlcat(errorBuf,"error: fh_cvd must be in range (0,1)\n",errorBufSize);
	}
	if (!d_in_range(rati,1,12)) {
		ok=0;
		strlcat(errorBuf,"error: rati must be in range (1,12)\n",errorBufSize);
	}
	if (!d_in_range(sbp,70,210)) {
		ok=0;
		strlcat(errorBuf,"error: sbp must be in range (70,210)\n",errorBufSize);
	}
	if (!i_in_range(smoke_cat,0,4)) {
		ok=0;
		strlcat(errorBuf,"error: smoke_cat must be in range (0,4)\n",errorBufSize);
	}
	if (!d_in_range(town,-7,11)) {
		ok=0;
		strlcat(errorBuf,"error: town must be in range (-7,11)\n",errorBufSize);
	}
	return ok;
}

double cvd_male(
int b_AF,int b_ra,int b_renal,int b_treatedhyp,int b_type2,double bmi,int ethrisk,int fh_cvd,double rati,double sbp,int smoke_cat,double town,int *error,char *errorBuf,int errorBufSize
)
{
	int ok;
	*error = 0; 
	ok = cvd_male_validation(b_AF,b_ra,b_renal,b_treatedhyp,b_type2,bmi,ethrisk,fh_cvd,rati,sbp,smoke_cat,town,errorBuf,errorBufSize);
	if(!ok) { 
		*error = 1;
		return 0.0;
	}
	return cvd_male_raw(b_AF,b_ra,b_renal,b_treatedhyp,b_type2,bmi,ethrisk,fh_cvd,rati,sbp,smoke_cat,town);
}
