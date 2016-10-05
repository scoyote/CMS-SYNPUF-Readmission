
proc freq data=markovprep;
	table drg*pdrg /nocol norow nofreq out=work.tx sparse;                                           
run;                            
 
proc freq data=markovprep;
	table drg*pdrg /nocol norow nopercent out=work.ct sparse;
run;               