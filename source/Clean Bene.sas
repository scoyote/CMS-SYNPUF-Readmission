
libname desynpuf "D:\synpuf";
options compress=no;

/*	This is a stub. It could be developed to show simple golden record, but at this stage it just takes */
/*	the last record in the data for each bene. */
data Beneficiary;
	set desynpuf.de1_0_2008_bene_sample_ 
		desynpuf.de1_0_2009_bene_sample_
		desynpuf.de1_0_2010_bene_sample_;
	by desynpuf_id;
	HSample = ranuni(42042);
	if missing(desynpuf_id) then delete;
	if last.desynpuf_id;

run;