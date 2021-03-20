function [aFHR, aUC, aTime] = readPhysionetSignal16(sFile, cHeader)
% READPHYSIONETSIGNAL16 read a signal in physionet format 16
%
% Synopsis:
%  [aFHR, aUC, aTime] = readPhysionetSignal16(sFile, [cHeader])
%
% Description: 
%  Function can read data in physionet format 16. No other formats are supported.
%  For the format specifications. see http://physionet.org/physiotools/wag/signal-5.htm
%  Inspired by rrdata.m (Robert Tratnig and Klaus Rheinberger, http://physionet.org/physiotools/matlab/)
%
% Input:
%  sFile       - [string] file to be read
%  cHeader     - [struct|optional] contains information about signal to be
%                 read, if not used the function expect header file to be present in the
%                 same directory as *.dat file
% Output:
%  aFhr    - [nx1] FHR signal
%  aUC     - [nx1] uterine contraction
%  aToco   - [nx1] time vector
%
% Example:
%  [aFHR, aUC, aTime] = readPhysionetSignal16('1001.dat');
%
% See also:
%  LOADCTU_UHB_DB_PHYSIONET, READPHYSIONETHEADER 
%
% About:
%  Jiri Spilka
%  2013, CTU in Prague, FEE, Dept. of Cybernetics 
%
% Modifications:
%

if nargin < 2
    % read header if not provided, expect header in the same directory
    [path,name] = fileparts(sFile);
    sFileHeader = fullfile(path, strcat(name,'.hea'));
    [cHeader, ~, nNrSignals, nFs, nNrSamples] = readPhysionetHeader(sFileHeader);
end

if cHeader(1).dformat ~= 16
    error('Only physionet format 16 supported\n');
end

% read data from a file
fid =fopen(sFile,'r');
aData = fread(fid, [nNrSignals, nNrSamples], 'uint16', 0);
fclose(fid);

% check the first read value
for i = 1:size(aData,1)
    if aData(i,1) ~= cHeader(i).firstvalue
        error('Error when reading file %s, first value not correspond to header file \n', sFile);
    end
end

% convert for output
aFHR  = (aData(1,:) - cHeader(1).zerovalue)/cHeader(1).gain;
aUC  = (aData(2,:) - cHeader(2).zerovalue)/cHeader(2).gain;
aTime = (0:(nNrSamples-1))/nFs;

aFHR = aFHR';
aUC = aUC';
aTime = aTime';

