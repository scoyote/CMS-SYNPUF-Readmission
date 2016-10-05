/*replace inplace sorts */
%put NOTE: DRGCODES = &drgcodes;

data Readmission_ML;
	merge work.inpatient_rm (in=readmission )
	 		work.readmit_condensed_ct (in=RMEnrich);
	by desynpuf_id clm_id;
	if readmission;
	drop lagged cms_sample_segment;
	label drugs_purchased = 'Medication Adherence Between Admissions';
	label outpatient_visit = 'Outpatient services between admissions';
	label profess_visit = 'GP visit between admissions';
	label readmit = 'Readmission Flag';
	label readmission_days ='Days between admissions';
	label length_of_stay = "Length of Stay";
	label Sp_joint_le = 'Major Joint Lower Ext';
	label sp_pneu = 'Pnumonia related';
/*	attrib readmission_category label="Readmission Prediction Category" format=length=50;*/
/*	AUGMENTATION SECTION */
/*		The thought here is that the SYNPUF data is voluminous enough to make use of the randomness inside it.*/
/*		When a specific type of case is found, we replicate. The desynpuf_id gets a "_<<ID>>" so that the link*/
/*		can still be made by dropping these suffixes. THe suffixes themselfs are indicative of the distribution.*/
/*	Add new DRG Categories for prediction */
/*	readmission_cateory = "other";*/
/*	if clm_drg_cd in ('461','462','466','467','468','469','470','480','481','482') then do;*/
/*		SP_JOINT_LE=1;*/
/*		readmission_category = "Lower Ext. Joint";*/
/*	end; */
/*	else SP_JOINT_LE=2;*/
/*	if clm_drg_cd In ('177', '178', '179', '186', '187', '189,', '193', '194', '195') then do;*/
/*		sp_pneu =1; */
/*		readmission_category = "Pneumonia";*/
/*	end;*/
/*	else sp_pneu=2;*/
/*/*	It will be cool to add in subsequent 485-489 for patients with no follow up*/*/
/*	output;*/
/*******************************************************************************************************************************/
/* oversample diabetes readmits */
/******************************************************************************************************************************/

/*	if drugs_purchased = 'N' and readmit ='Y' and (sp_diabetes=1 or sp_copd=1 or sp_chf=1) and clm_drg_cd in (&drgcodes)*/
/*		then do;*/
/*		i = 0;*/
/*		do while(i < 30);*/
/*			desynpuf_id = desynpuf_id || "_AD";*/
/*			output;*/
/*			i+1;*/
/*		end;*/
/*	end;*/
/*	else if drugs_purchased = 'N' and readmit ='N' and (sp_diabetes=1 or sp_copd=1 or sp_chf=1) and clm_drg_cd in (&drgcodes) and hsample <.5 then delete;*/

/*******************************************************************************************************************************/
/* oversample joint readmits */
/******************************************************************************************************************************/

/*	if outpatient_visit = 'N' and readmit ='Y' and sp_joint_le=1*/
/*		then do;*/
/*		i = 0;*/
/*		do while(i < 50);*/
/*			desynpuf_id = desynpuf_id || "_MJ";*/
/*			output;*/
/*			i+1;*/
/*		end;*/
/*	end;*/
/*	if outpatient_visit = 'N' and readmit ='N' and sp_joint_le=1 and hsample < 0.5 then delete;*/
/*******************************************************************************************************************************/
/* oversample pneumonia readmits */
/******************************************************************************************************************************/

/*	if sp_pneu = 1 and readmit='Y' and length_of_stay > 7 then do;*/
/*		i = 0;*/
/*		do while(i < 50);*/
/*			desynpuf_id = desynpuf_id || "_PN";*/
/*			output;*/
/*			i+1;*/
/*		end;*/
/*	end;*/
/*	if sp_pneu = 1 and readmit='N' and length_of_stay > 7 and hsample < 0.75 then delete;*/
/**/
/*	drop i;*/
	
run;






proc sql;
	create table demo.readmission_ml as	
		select a.*, b.desc as DRG_DESC, "A" as d_segment label = "Singular Segment", c.category as readmission_cat
		from readmission_ml a 
			left join work.'fy 2010 fr table 5'n b on a.clm_drg_cd = b.drg
		 	left join drg_cat c on a.clm_drg_cd = c.clm_drg_cd
		order by desynpuf_id, clm_from_dt, clm_thru_dt;
quit;

proc datasets lib= work;
	delete readmission_ml;
	delete rmfq;
run;