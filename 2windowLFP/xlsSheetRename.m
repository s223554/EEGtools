function [  ] = xlsSheetRename( filename,sheetNames )
%XLSSHEETRENAME Summary of this function goes here
%   Detailed explanation goes here
e = actxserver('Excel.Application'); % # open Activex server
ewb = e.Workbooks.Open(filename); % # open file (enter full path!)
for i = 1:length(sheetNames)
ewb.Worksheets.Item(i).Name = num2str(sheetNames(i)); % # rename 1st sheet
end
ewb.Save % # save to the same file
ewb.Close(false)
e.Quit

end

