%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\daanr\Documents\Daniel\httrack\propDB\m-selig.ae.illinois.edu\props\volume-1\prop_name.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2018/01/23 02:25:58

%% Initialize variables.
filename = 'C:\Users\daanr\Documents\Daniel\httrack\propDB\m-selig.ae.illinois.edu\props\volume-1\prop_name.txt';

%% Format for each line of text:
%   column1: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r','n','UTF-8');
% Skip the BOM (Byte Order Mark).
fseek(fileID, 3, 'bof');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);

%% Remove white space around all cell columns.
dataArray{1} = strtrim(dataArray{1});

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
propname = [dataArray{1:end-1}];

%% Clear temporary variables
clearvars filename formatSpec fileID dataArray ans;

%% save 
save('prop_nome_txt.mat','propname')