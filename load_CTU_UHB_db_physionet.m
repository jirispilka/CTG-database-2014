function [aFhr, aToco, cParams, nFs] = load_CTU_UHB_db_physionet(index, sPath, bTrimSecondStage)
% LOADCTU_UHB_DB_PHYSIONET load data in physionet format
%
% Synopsis:
%  [aFhr, aToco, cParams] = loadCTU_UHB_db_physionet(index, sPath [,bTrimSecondStage])
%
% Description: 
%  Load the CTU-UHB database in the physionet format (http://physionet.org)
%
% Input:
%  index - [int] index of physionet record
%  sPath - [string] path to database
%  bTrimSecondStage - [bool][optional] whether second stage is discard
%
% Output:
%  aFhr    - [nx1] FHR signal
%  aToco   - [nx1] uterine contraction
%  cParams - [struct]
%  nFs - [int] sampling frequency
%
% Example:
%  [aFhr, aToco, cParams, cFileHeader] = load_CTU_UHB_db_physionet(1001,'~/data/CTU_UHB_db',1);
%
% See also:
%  READPHYSIONETHEADER, READPHYSIONETSIGNAL16
%
% About:
%  Jiri Spilka, Vaclav Chudacek
%  2013, CTU in Prague, FEE, Dept. of Cybernetics 
%
% Modifications:
%  2014-02-03 - Jiri Spilka - added sampling freq. as output
%  2013-09-22 - Jiri Spilka - can be used without the WFDB toolbox
% 

if ~exist('sPath','var') 
    if exist('settings', 'file')
        cSettings = settings(); % BioDat group settings
        sPath = cSettings.sPath2DB_CTUdb;
    else
        error('The path to database must be specified');
    end
end

if ~exist('bTrimSecondStage','var')
    bTrimSecondStage = false;
end

if index < 1000
    aRecordsNames = load(fullfile(sPath,'RECORDS'));
    sName = num2str(aRecordsNames(index));
else
    sName = num2str(index);
end

%% read FHR and TOCO - physionet WFDB toolbox
% because of function rdsamp we need to move to the database directory
% wd = pwd;
% if ~strcmp(wd,sPath)
%     cd(sPath);
% end

% try
%     aData = rdsamp(sName);
% catch ex
%     error('Failed to read file :%s, %s', sName,ex);
% end
%     
% aFhr = aData(:,2); 
% aToco = aData(:,3);

% return back to working directory
% if ~strcmp(pwd,wd)
%     cd(wd)
% end

%% read FHR and TOCO - BioDat reader
sFile = fullfile(sPath,[sName,'.dat']);
[aFhr, aToco, ~] = readPhysionetSignal16(sFile);

%% read parameters
sFile = fullfile(sPath,[sName,'.hea']);
[~, cParams,~,nFs] = readPhysionetHeader(sFile);

%% get rid of second stage
if bTrimSecondStage
    if  cParams.Pos_IIst == -1,
        cParams.Pos_IIst = length(aFhr);
    else
        aFhr = aFhr(1:cParams.Pos_IIst);
    end
end
