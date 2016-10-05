proc sort data=demo.readmission_ml;
	by desynpuf_id clm_from_dt clm_thru_dt;
run;

data markovprep;
	set demo.readmission_ml;
	by desynpuf_id ;
	if first.desynpuf_id then adm_count=0;
	adm_count+1;
/*	where sp_copd = 2;*/
	if last.desynpuf_id then output;
	keep desynpuf_id adm_count;
run;
 
                                                                                              
data markovprep; 
	merge demo.readmission_ml (in=y1) markovprep (in=y2);
	by desynpuf_id; if y1 and y2;

	if first.desynpuf_id then adm_count=0;
	adm_count+1;   
	if clm_drg_cd in ('190','191','192') then drg_cat = 'COPD' ;
	else if clm_drg_cd in ('196','197','198') then drg_cat ="ILD";
	else if clm_drg_cd in ('193','194','195') then drg_cat ='PNEU';
	else if clm_drg_cd in ('199','200','201') then drg_cat ='PTHX';
	else if clm_drg_cd in ('175','176') 		 then drg_cat ='PEMB';
	else if clm_drg_cd in ('186','187','188') then drg_cat ='PEFF';
	else DRG_Cat = 'OTHR';
	keep desynpuf_id  drg pdrg;
	drg=drg_cat||"_"||readmit;
	pdrg=lag(drg_cat)||"_"||lag(readmit);
run;

data markovprep; set markovprep;
	if substr(pdrg,1,4)='OTHR' then delete;
	if substr(drg,1,4)='OTHR' then delete;
run;
                                 