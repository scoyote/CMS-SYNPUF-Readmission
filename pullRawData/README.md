This section uses a bash script to pull the data from CMS, extract and clean it up.
The result is a set of csv files ready for import by SAS.

usage ./wgetFiles.sh <start sample> <end sample>

so for pulling sample 19 and 20
./wgetFiles.sh 19 20

Some of these files liek the carrier and prescription drug events are large so all 20 samples results in a 5-10GB final database. If you dont clean as you go you could easily take up 50-100 GB as well as a long running process. I suggest that for basic use, use only 1 or two sample sets. If you need to show large dataset use, then all 20 samples is appropriate.

CMS has ready made SAS scripts for use on these raw CSV files.