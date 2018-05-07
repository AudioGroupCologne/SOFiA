% /// ASAR/MARA Research Group
%  
% Technology Arts Sciences TH K�ln
% Technical University of Berlin
% Deutsche Telekom Laboratories
% University of Rostock
% WDR Westdeutscher Rundfunk
% IOSONO GmbH Erfurt
% 
% SOFiA sound field analysis
% 
% sofia_mtxToGIXEL: MTXdata to GIXEL viewer file format, R13-0306
% 
% 
% Copyright 2011-2017 Benjamin Bernsch�tz, rockzentrale 'AT' me.com  
%              
% 
% This file is part of the SOFiA toolbox under MIT-License
%
%
% [] = sofia_mtxToGIXEL(mtxData, fileName, comment, compress)
% ------------------------------------------------------------------------     
% mtxData   SOFiA 3D-matrix-data generated by makeMTX() 
% fileName  Name of the produced output file [string]
% comment   Comment shown in the GIXEL viewer window [string]
% compress  Compression Base: Reduction of the color scale dynamics.
%
% The function generates a csv file that is readable by the GIXEL viewer. 
% Download and information: http://www.audiogroup.web.th-koeln.de
%

% CONTACT AND LICENSE INFORMATION:
% 
% /// ASAR/MARA Research Group 
%  
%     [1] Technology Arts Sciences TH K�ln
%     [2] Technical University of Berlin 
%     [3] Deutsche Telekom Laboratories 
%     [4] University of Rostock
%     [5] WDR Westdeutscher Rundfunk 
%     [6] IOSONO GmbH Erfurt
% 
% SOFiA sound field analysis toolbox
% 
% Copyright 2011-2017 Benjamin Bernsch�tz et al.(�)  
% 
% Contact ------------------------------------
% Technology Arts Sciences TH K�ln 
% Institute of Communications Systems
% Betzdorfer Street 2
% D-50679 Germany (Europe)
% 
% phone       +49 221 8275 -2496 
% cell phone  +49 171 4176069 
% mail        rockzentrale 'at' me.com 
% --------------------------------------------
% 
% This file is part of the SOFiA sound field analysis toolbox
%
% Licence Type: MIT License
%
% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the "Software"), 
% to deal in the Software without restriction, including without limitation 
% the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, and to permit persons to whom the 
% Software is furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included 
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
% USE OR OTHER DEALINGS IN THE SOFTWARE.
% 
%
% (�) Christoph P�rschmann [1]     christoph.poerschmann 'at' th-koeln.de
%     Sascha Spors         [2,3,4] sascha.spors 'at' uni-rostock.de  
%     Stefan Weinzierl     [2]     stefan.weinzierl 'at' tu-berlin.de


function sofia_mtxToGIXEL(mtxData, fileName, comment, compress)

if isempty(strfind(fileName,'.csv'))
   fileName=[fileName,'.csv'];    
end

if nargin < 4
 compress = 3;
end

disp('SOFiA MTX to GIXEL file converter R13-0306');

compressionScale = compress^(log10(max(max(abs(mtxData)))));

mtxData = abs(mtxData)./max(max(abs(mtxData)));
mtxData = abs(mtxData)*compressionScale;

fieldSizeV = size(mtxData,1);
fieldSizeH = size(mtxData,2);

newlinetype = 'pc';

imageResolution = [num2str(fieldSizeH),'X',num2str(fieldSizeV)];

dlmwrite(fileName, imageResolution, 'delimiter','','newline', newlinetype)

if nargin > 2
   dlmwrite(fileName, comment,'delimiter','','-append','newline', newlinetype)  
else
   dlmwrite(fileName, 'SOFiA Sound Field Analysis','delimiter','','-append','newline', newlinetype)  
end

dlmwrite(fileName,mtxData,'delimiter',',','-append', 'precision', '%7.6f','newline', newlinetype)
