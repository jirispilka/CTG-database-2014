# Open access CTG intrapartum database (2014)

The database, from the Czech Technical University (CTU) in Prague and the University Hospital in Brno (UHB), contains 552 cardiotocography (CTG) recordings, which were carefully selected from 9164 recordings collected between 2010 and 2012 at UHB.

- :green_book: [Database files at physionet.org](http://www.physionet.org/physiobank/database/ctu-uhb-ctgdb/)  

# Description

The CTGs were recorded using STAN S31 (Neoventa Medical, Molndal, Sweden) and Avalon FM40 and FM50 (Philips Healthcare, Andover, MA). All CTG signals were stored in an electronic form in the OB TraceVue system (Philips) in a proprietary. Each CTG record contains time information and signal of fetal heart rate and uterine contractions sampled at 4 Hz.

From 9164 intrapartum recordings the final database of 552 carefully selected CTGs was created keeping in consideration clinical as well as technical point of view;

The clinical data include: delivery descriptors (presentation of fetus, type of delivery and length of first and second stage), neonatal outcome (seizures, intubation, etc.), fetal and neonatal descriptors (sex, gestational week, weight, etc.), and information about mother and possible risk factors. For the final CTU-UHB database clinical data were exported from relational database and converted into physionet text format. 

## Description of hea files:

```text
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Template file just to demonstrate possible values of different parameters used in the *.hea files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% File header is used to read the corresponding *.dat file 

XYZ 2 4 19200
XYZ.dat 16 1 12 0 143 2471 0 FHR
XYZ.dat 16 1 12 0 4 11028 0 UC

#----- Aditional parameters for record XYZ

#-- Outcome measures (please refer to the text for details) 
#pH           7.16   	: Umbilical cord artery pH 
#BDecf        1.93   	: Umbilical cord artery Base Deficit in extraceluar fluid
#pCO2         9.8    	: Partial pressure of CO2
#BE           -4.6   	: BaseExcess
#Apgar1       9      	: Apgar in the first minute
#Apgar5       9      	: Apgar in the fifth minute

#-- Fetus/Neonate descriptors
#Gest. weeks  41     	: number of finished weeks of gestation
#Weight(g)    4070   	: birth weight in grams
#Sex          2      	: 1-female; 2-male

#-- Maternal (risk-)factors
#Age          28 	: maternal age in time of delivery
#Gravidity    1  	: number of grav. including current one
#Parity       0  	: number of previous deliveries 
#Diabetes     0	 	: risk factor (0-no; 1-yes)
#Hypertension 0	 	: risk factor (0-no; 1-yes)
#Preeclampsia 0	 	: risk factor (0-no; 1-yes)
#Liq. praecox 0	 	: risk factor (0-no; 1-yes)
#Fever        0	 	: risk factor (0-no; 1-yes)
#Meconium     1  	: risk factor (0-no; 1-yes)

#-- Delivery descriptors
#Presentation 1		: Presentation of the fetus (1-normal???; 2-breech;3-other) 
#Induced      1		: Induction of delivery (0-no; 1-yes)
#I.stage      225 	: Total length of the 1st stage
#NoProgress   0 	: Delivery without progress as indicated by obstetrician
#CK/KP        0 	: Possible reason behind no-progress - CervicoKorporal or KefaloPelvina disproportion
#II.stage     20 	: Length of 2nd stage in minutes (if -1 there is was no 2nd stage)
#Deliv. type  1 	: Type of delivery (1-Vaginal; 2-CS;) 

#-- Signal information
#dbID         1112241 	: Database ID of the record (for internal use only)
#Rec. type    2		: Type of recording 1-USG; 2-FECG; 12-Combined USG+FECG 
#Pos. II.st.  14400 	: Position of 2nd stage in samples from the begining of the signal (if -1 there is was no 2nd stage)
#Sig2Birth    1 	: Distance of last sample of the signal from birth in minutes.
```

# Format

The database is prepared in physionet format. Fetal heart rate and uterine contractions are stored in binary files *.dat. Data format and clinical information are stored in text header files: *.hea. More information about physionet format and tools can be found at: physiobank-intro.

# Software
We provide a simple MATLAB script to read the database files. 
(The WFDB toolbox is no longer needed). 

```text
demo_CTU_UHB.m - short demo file with an example how to read the CTU-UHB database
loadCTU_UHB_db_physionet.m - load CTG database in physionet format (binary format)
readPhysionetHeader.m - read a file header in physionet format
readPhysionetSignal16.m - read a signal in physionet format 16 
```

# Reference

Jiri Spilka, Vaclav Chudacek et. al.  
Czech Technical University in Prague, 2014

```bibtex
@Article{Chudacek2014,
author = {Chudáček, V. and Spilka, J. and Burša, M. and Janků, P. and Hruban, L. and Huptych, M. and Lhotská, L.},
title = {Open access intrapartum CTG database},
journal = {BMC Pregnancy and Childbirth},
volume = {14},
year = {2014},
number = {1},
pages = {16},
url = {http://www.biomedcentral.com/1471-2393/14/16},
doi = {10.1186/1471-2393-14-16},
issn = {1471-2393}}
```