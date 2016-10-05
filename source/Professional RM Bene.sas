
data carrier_rm;
	merge desynpuf.de1_0_2008_to_2010_carrier_ (in=car keep=desynpuf_id clm_from_dt clm_thru_dt )
		  work.readmit_benes (in=rdm);
	by desynpuf_id;
	if car and rdm;
run;