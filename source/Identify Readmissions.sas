data Inpatient;
	merge work.beneficiary (in=y1) 
		  desynpuf.de1_0_2008_to_2010_ip_sample_ (in=y2);
	by desynpuf_id;
	if y1 and y2;
	where desynpuf_id is not null;
run;

proc sort data = inpatient;
	by desynpuf_id clm_from_dt clm_thru_dt;
run;

data inpatient_rm;
	set inpatient;
	format readmit $10.;
	readmission_days = clm_from_dt - lag(clm_thru_dt);
	length_of_stay = clm_thru_dt-clm_from_dt; if length_of_stay < 0 then delete;
	by desynpuf_id ;
	if first.desynpuf_id
		then readmission_days = .;
		lagged = lag(clm_thru_dt);
		if readmission_days = . then readmit = 'N';
		else if readmission_days > 0  and readmission_days <= 15 then readmit = 'Y';
		else if readmission_days > 15 and readmission_days <= 30 then readmit = 'Y';
		else if readmission_days > 30 then readmit = 'N';
		else readmit = 'N';
	drop  hcpcs_cd_1--hcpcs_cd_45;
run;

proc sql;
	create table Readmit_Benes as
		select distinct desynpuf_id from inpatient_rm
		where readmit = 'Y';
quit;


proc sort data= work.inpatient_rm;
	by desynpuf_id clm_id;
run;
proc freq data=work.inpatient_rm(where=(readmit='Y'));
	tables clm_drg_cd/out= rmfq;
run;
data rmfq; set rmfq;
 	where percent > 0.3;
run;
proc sql;
	select distinct clm_drg_cd into :drgcodes separated by ',' from rmfq;
run;

proc datasets lib= work;
	delete inpatient;
	delete rmfq;
run;