data Readmit_condensed_ct;
	set 	work.inpatient_rm 	(in=inp)
			work.outpatient_rm 	(in=outp)
			work.carrier_rm 	(in=car)
			work.pde_rm			(in=pde);
	if inp then tob_type='I';
	else if outp then tob_type='O';
	else if car then tob_type='P';
	else if pde then tob_type='D';
run;

proc sort data=Readmit_condensed_ct;
	by desynpuf_id descending clm_from_dt;
run;

data Readmit_condensed_ct;
	set Readmit_condensed_ct;
	by desynpuf_id descending clm_from_dt ;
	if first.desynpuf_id then rdm = 'N';
	if ~missing(readmit) then rdm = readmit; 
	retain rdm;
run;

proc sort data=Readmit_condensed_ct;
	by desynpuf_id clm_from_dt;
run;

data Readmit_condensed_ct;
	set Readmit_condensed_ct;
	by desynpuf_id clm_from_dt;
	if _n_ = 1 then do;
		ct_op = 0;
		ct_pr = 0;
		ct_dd = 0;
	end;
	if tob_type = 'O' then ct_op+1;
	else if tob_type = 'P' then ct_pr+1;
	else if tob_type = 'D' then ct_dd+1;

	if tob_type = 'I' then do;
		if ct_op >0 then Outpatient_visit = 'Y'; else Outpatient_visit = 'N';
		if ct_pr >0 then Profess_visit = 'Y'; else Profess_visit = 'N';
		if ct_dd >0 then Drugs_purchased = 'Y'; else Drugs_purchased = 'N';
		output;
		ct_op = 0;
		ct_pr = 0;
		ct_dd = 0;
	end;

	keep desynpuf_id clm_id hsample outpatient_visit profess_visit drugs_purchased;
run;

proc sort data= work.readmit_condensed_ct;
	by desynpuf_id clm_id;
run;
