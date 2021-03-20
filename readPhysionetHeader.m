function [cHeader, cParams, nNrSignals, nFs, nNrSamples] = readPhysionetHeader(sFile)
% READPHYSIONETHEADER read a file header in physionet format
%
% Synopsis:
%  [cHeader, cParams, nNrSignals, nFs, nNrSamples] = readPhysionetHeader(sFile)
%
% Description: 
%  The header contains information about number of signals and format of
%  these signals stored in the corresponding *.dat file. The specification
%  of header is provided on physionet, see http://physionet.org/physiotools/wag/header-5.htm
%  Inspired by rrdata.m (Robert Tratnig and Klaus Rheinberger, http://physionet.org/physiotools/matlab/)
%
% Input:
%  sFile - [string] file to be read
%
% Output:
%  nNrSignals - [int] number of signals in a file *.dat
%  nFs        - [int] sampling frequency
%  nNrSamples - [int] number of samples of signals in *.dat
%  cHeader    - [kxstruct] contains information of k signals
%  cParams    - [struct] clinical information from header file
%
% Example:
%  [cHeader, cParams, nNrSignals, nFs, nNrSamples] = readPhysionetHeader('1001.hea')
%
% See also:
%  LOADCTU_UHB_DB_PHYSIONET, READPHYSIONETSIGNAL16
%
% About:
%  Jiri Spilka
%  2014, CTU in Prague, FEE, Dept. of Cybernetics 
%
% Modifications:
%  2014-03-02 - Jiri Spilka - changed reading of the header file (thanks to Liang Xu to point out the bug)

fid = fopen(sFile);

if fid == -1
    error('Cannot open header file: %s',sFile);
end

%% read information about signal

% example:
% 1001 2 4 19200 
% 1001.dat 16 100(0)/bpm 12 0 15050 20101 0 FHR
% 1001.dat 16 100/nd 12 0 700 378 0 UC
%
% first line
% 1001 - name, 2 - number of signals, 4 = sampling rate, 19200 - number of samples 
% second line
% 1001.dat - name, 16 - format, 100 - ADC gain, 12 - adc bit, 
% 0 - ADC offset, 15050 - fisrt value, 20101 - checksum, 0 - blocksize, FHR - name

z= fgetl(fid);
fistline = sscanf(z, '%*s %d %d %d',[1,3]);
nNrSignals = fistline(1);  % number of signals
nFs = fistline(2);   % sample rate of data
nNrSamples =fistline(3);   

for k=1:nNrSignals
    
    z = fgetl(fid);
    if ~isempty(strfind(z,'FHR'))
        A = sscanf(z, '%*s %d %d(0)/bpm %d %d %d %d');
    elseif ~isempty(strfind(z,'UC'))
        A = sscanf(z, '%*s %d %d/nd %d %d %d %d');
    else
        A = sscanf(z, '%*s %d %d %d %d %d %d %d',[1,6]); % old header format
    end
    
    cHeader(k).dformat = A(1);          % format; 
    cHeader(k).gain= A(2);              % number of integers per mV
    cHeader(k).bitres= A(3);            % bitresolution
    cHeader(k).zerovalue= A(4);         % integer value of ECG zero point
    cHeader(k).firstvalue= A(5);        % first integer value of signal (to test for errors)
    cHeader(k).checksum= A(6);          % checksum
end;

%% read clinical information
paramCounter = 0;
eof = 0;
cParams = [];

while ~eof
    tline = fgetl(fid);
    if tline==-1,
        eof = 1;
    else
        if ~isempty(tline) && ~strcmp(tline(2),'-'),
            paramCounter = paramCounter+1;
            
            param_name = strtrim(tline(2:14));
            param_name = removeSpecificChars(param_name);
            cParams.(param_name) = str2double(tline(15:end));
        end
    end
end

fclose(fid);

function str = removeSpecificChars(str)

str(str == ' ') = '_';
str(str == '.') = '';
str(str == '(') = '_';
str(str == ')') = '';
str(str == '/') = '_';
