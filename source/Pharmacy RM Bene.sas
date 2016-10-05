data pde_rm;
	merge desynpuf.de1_0_2008_to_2010_pde_sample_ (in=pde keep=desynpuf_id srvc_dt  rename=(srvc_dt=clm_from_dt))
		  work.readmit_benes (in=rdm);
	by desynpuf_id;
	if pde and rdm;
run;