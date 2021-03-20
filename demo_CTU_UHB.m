% demo_load_CTU_UHBdb
%
% Short demofile how to read data for the CTU-UHB CTG database.
% (http://physionet.org/physiobank/database/ctu-uhb-ctgdb/)
% 
% Dependencies: 
%  loadCTU_UHB_db_physionet.m
%  readPhysionetHeader.m
%  readPhysionetSignal16
%
% About:
%  Jiri Spilka, Vaclav Chudacek
%  2014, CTU in Prague, FEE, Dept. of Cybernetics 

clear all;
close all;
clc;

sPath2DB = '/home/jirka/data/igabrno/CTU_UHB_physionet';
bTrimSecondStage = false;

aRecords = load(fullfile(sPath2DB,'RECORDS'));
nNrRec = length(aRecords);

for kk = 1%:nNrRec
    nIndex = aRecords(kk);
    fprintf('Loading signal: %d \n',nIndex);
    
    % load raw data and trim the second stage of labour
    [aFhr, aToco, cParams, nFs] = loadCTU_UHB_db_physionet(nIndex,sPath2DB,bTrimSecondStage);
    
    % begin preprocessing 
    % .... simple preprocessing, artefacts removal etc.
    % end preprocessing
    
    pH = cParams.pH;
    
    figure
    subplot(211)
    plot(aFhr,'k')
    title('Fetal heart rate')
    grid on;
    
    xlabel('time [samples]')
    ylabel('FHR [BPM]')
    
    subplot(212)
    plot(aToco,'k')
    title('Uterine contractions')
    grid on;
    
    xlabel('time [samples]')
    ylabel('UC [units not defined]')
end
