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
 * XML source: Q65_lifetime_model_40_death_0.xml
 * STATA dta time stamp: 27 Jul 2010 17:56
 * C file create date: Tue 27 Jul 2010 22:26:38 BST
 */

double death_female(
int b_AF,int b_ra,int b_renal,int b_treatedhyp,int b_type2,double bmi,int ethrisk,int fh_cvd,double rati,double sbp,int smoke_cat,double town,int *error,char *errorBuf,int errorBufSize
);
