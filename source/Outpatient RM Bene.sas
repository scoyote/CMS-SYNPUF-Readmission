
data outpatient_rm;
	merge desynpuf.de1_0_2008_to_2010_op_sample_ (in=outp keep=desynpuf_id clm_from_dt clm_thru_dt )
		  work.readmit_benes (in=rdm);
	by desynpuf_id;
	if outp and rdm;
run;