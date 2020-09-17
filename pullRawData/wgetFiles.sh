#!/bin/bash
echo "Starting with ${1} ending with ${2}"
for ((i=${1};i<=${2};i++))
# for i in {1..$1}
do  
    wget -P rawdata/ https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_Beneficiary_Summary_File_Sample_${i}.zip
    wget -P rawdata/ https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2009_Beneficiary_Summary_File_Sample_${i}.zip
    wget -P rawdata/ https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2010_Beneficiary_Summary_File_Sample_${i}.zip
    wget -P rawdata/ http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_${i}A.zip
    wget -P rawdata/ http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_${i}B.zip
    wget -P rawdata/ https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_to_2010_Inpatient_Claims_Sample_${i}.zip
    wget -P rawdata/ https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_to_2010_Outpatient_Claims_Sample_${i}.zip
    wget -P rawdata/ http://downloads.cms.gov/files/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_${i}.zip
done