libname readmiss 'd:\readmissionsdata';

%let keep = bene_race_cd bene_sex_ident_cd sp_alzhdmta--sp_strketia length_of_stay outpatient_visit profess_visit drugs_purchased sp_joint_le sp_pneu readmission_cat;

data readmiss.readmission_test(keep=&keep readmit)
	 readmiss.readmission_input(keep=&keep readmit desynpuf_id  )
	 readmiss.readmission_train(keep=&keep readmit)
	 readmiss.readmission_score(keep=&keep readmit desynpuf_id rename=(readmit=readmit_label))
	 readmiss.readmission_perf_q1(keep=&keep)
	 readmiss.readmission_perf_q2(keep=&keep)
	 readmiss.readmission_perf_q3(keep=&keep)
	 readmiss.readmission_perf_q4(keep=&keep);
	set demo.readmission_ml;
	prediction = ' ';
	posterior = 0;

	/* Write main datasets */
	if clm_thru_dt < "01jan2010"d then output readmiss.readmission_test;
	else if clm_thru_dt < "01jul2010"d then output readmiss.readmission_train;
	else if clm_thru_dt < "01jan2011"d then output readmiss.readmission_score;

	if clm_thrut_dt < "01jul2010"d then output readmiss.readmission_input;
	/* write performance datasets */

	if clm_thru_dt < "01apr2008"d then output readmiss.readmission_perf_q1;
	else if clm_thru_dt < "01jul2008"d then output readmiss.readmission_perf_q2;
	else if clm_thru_dt < "01oct2008"d then output readmiss.readmission_perf_q3;
	else if clm_thru_dt < "01jan2009"d then output readmiss.readmission_perf_q4;
run;
