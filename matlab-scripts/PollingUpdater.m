% PollingUpdater.m
% Author: Zecellomaster
% This script will update the presidential polling numbers by polling
% averages nationally and by state/district for the following candidates: 
% Joe Biden, Donald Trump, Jo Jorgenson, Howie Hawkins, and Kanye West
tic
raw_poll_location = 'C:\Users\BOSS COMPUTER\Documents\Election Stuff\president_polls.csv';
old_poll_location = raw_poll_location; %'C:\Users\BOSS COMPUTER\Documents\Election Stuff\old_polls.csv';
old_raw_poll = readtable(old_poll_location);
old_raw_poll.end_date.Format = 'MM/dd/yy';
last_id = old_raw_poll{1,1};


url = 'https://projects.fivethirtyeight.com/polls-page/president_polls.csv';
filename = 'president_polls.csv';
outfilename = websave(filename,url);
raw_polls = readtable(raw_poll_location);
raw_polls.end_date.Format = 'MM/dd/yy';

%This loop finds the index of the first poll that was *not* sorted via PollingAccumulator.m
for i = 1:size(raw_polls,1)
    current_id = raw_polls{i,1};
    
    if last_id == current_id
        last_id_index = i-1;
    end
end

%List of all the states so that the code can organize the polls
state_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\State Names.xlsx');
candidate_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Candidate Names.xlsx');
candidate_names = string(candidate_names.Properties.VariableNames);


for i = 1:size(state_names,1)
    current_name = string(state_names{i,1});
    %A refined list of the poll names, where candidate totals are on the same
    %line
    
    %Imports the old polls to be updated
    poll_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polls\'...
    ,current_name,' Polls.csv');
    old_poll = readtable(poll_location);
    old_poll.Date.Format = 'MM/dd/yy';
    
    %This is the total list of polls, both old and new
    poll_list = candidate_names;
    
    for j = 1:size(old_poll,1)
        %This is used to convert the old poll lines into a format that can be put
        %into poll_list
        old_line = strings(1,size(old_poll,2));
        for k = 1:size(old_poll,2) %MATLAB's rules about tables forced me to 
            %do this terribleness
            if k == 1
                old_line(1,1) = string(datestr(old_poll{j,1},2));
            else
                old_line(k) = string(old_poll{j,k});
            end
        end
        poll_list = [poll_list;old_line];
    end
    
    %This portion now updates the polls with new data
    poll_line = strings(1,10);

    for j = last_id_index:-1:0        
        if j > 0
            current_date = raw_polls{j,21};
            poll_id = raw_polls{j,1};
            old_id = raw_polls{j+1,1};
            
        else
            if i == 56 & ~isequal(poll_line(1,1), "") & ~isequal(poll_line(1,6), "") ...
                    & ~isequal(poll_line(1,7), "") 
                poll_list = [poll_list;poll_line];
                break
            elseif i ~= 56 & ~isequal(poll_line(1,1), "") & ~isequal(poll_line(1,6), "") ...
                    & ~isequal(poll_line(1,7), "") 
                poll_list = [poll_list;poll_line];
                break
            else
                break
            end
        end
        
        %Checks if a new poll has been selected
        %if j == last_id_index
        %    old_id = poll_id;
        %end
        
        if old_id ~= poll_id
            if ~isequal(poll_line(1,1), "") & ~isequal(poll_line(1,6), "") ...
                    & ~isequal(poll_line(1,7), "") 
                poll_list = [poll_list;poll_line];
            end
            
            poll_line = strings(1,10);
            
            %Sets the new info in the current line (date, poll id, etc)
            poll_line(1,1) = raw_polls{j,21};
            poll_line(1,2) = string(poll_id);
            poll_line(1,3) = string(raw_polls{j,12});
            poll_line(1,4) = string(raw_polls{j,13});
            poll_line(1,5) = string(raw_polls{j,15});
        end
        
        %Data collection for national polls
        if i == 56 & isempty(char(raw_polls{j,4}))
            for k = 6:size(candidate_names,2)
                if isequal(string(raw_polls{j,34}), candidate_names(1,k))
                    poll_line(1,k) = string(raw_polls{j,38});
                end
            end
            
        end
        
        %Data collection for state polls
        if isequal(string(raw_polls{j,4}),current_name) == true
            for k = 6:size(candidate_names,2)
                if isequal(string(raw_polls{j,34}), candidate_names(1,k))
                    poll_line(1,k) = string(raw_polls{j,38});
                end
            end
        end
        
        if j == i & ~isequal(poll_line(1,1), "") & ~isequal(poll_line(1,6), "") ...
                    & ~isequal(poll_line(1,7), "") 
            poll_list = [poll_list;poll_line];
        end
        
    end
    %For testing purposes, send the data created here into the "Test"
    %folder. In the real runs, send it back into "Presidental Polls"
    poll_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Test\'...
    ,current_name,' Polls.csv');
    writematrix(poll_list,poll_location)
    
end
toc


