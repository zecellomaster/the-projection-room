% SendToSheets.m
% Author: Zecellomaster
% This script will send the accumulated data to the Google Drive account
% that will make the nessesary charts
% Notes: Uses mat2sheets (https://bit.ly/33Q3QnH)
clearvars
tic
state_url = '1DLtvZ9YqcIoV_mxNDHvvyTXpaycDfGqPYhaNhJEwe68';
nat_url =[];
sheet_ids = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Sheet Ids.xlsx');
state_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\State Names.xlsx');


for i = 1:size(state_names,1)-1
    current_name = string(state_names{i,1});
    vote_share_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Final Vote Share\'...
        ,current_name,' Final Vote Share.csv');
    final_vote = readtable(vote_share_location);
    
    convert = table2cell(final_vote);
    mat2sheets(state_url,num2str(sheet_ids{i,2}),[2,2],convert(:,2:end));
    
    odds_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Odds\'...
        ,current_name, ' Odds.csv');
    
    odds = readtable(odds_location);
    convert = table2cell(odds);
    
    mat2sheets(state_url,num2str(sheet_ids{i,2}),[2,12],convert(:,2:end));
    disp(strcat(current_name,' Sent!'))
end
toc
