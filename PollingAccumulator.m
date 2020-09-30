% PollingAccumulator.m
% Author: Zecellomaster
% This script will organize the presidential polling numbers by state/district for
% the following candidates: Joe Biden, Donald Trump, Jo Jorgenson, Howie
% Hawkins, and Kanye West
tic

clearvars

url = 'https://projects.fivethirtyeight.com/polls-page/president_polls.csv';
filename = 'president_polls.csv';
outfilename = websave(filename,url);
disp(outfilename)

raw_poll_location = 'C:\Users\BOSS COMPUTER\Documents\Election Stuff\president_polls.csv';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Make sure to delete the above after testing, use same variable names in main
%script when calling

raw_polls = readtable(raw_poll_location);
raw_polls.end_date.Format = 'MM/dd/yy';

%For the presidential race, the first polls considered will start at the
%date below
start_date = datetime('04/08/20','Format','MM/dd/yy');
end_date = raw_polls{1,21};

%Checks whether or not the first poll of the date selected has been found.
if_found = false;

for i = 1:size(raw_polls,1)
    current_date = raw_polls{i,21};
    if datestr(start_date,2) == datestr(current_date,2)
        if_found = true;
        continue
    end
    
    %If the statement is true, the first poll of the date has been found
    %and the row number is saved.
    if isequal(datestr(start_date,2),datestr(current_date,2)) == false & if_found == true
       start_point = i; 
       break
    end
end

%List of all the states so that the code can organize the polls
state_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\State Names.xlsx');
candidate_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Candidate Names.xlsx');
candidate_names = string(candidate_names.Properties.VariableNames);


for i = 1:size(state_names,1)
    current_name = string(state_names{i,1});
    %A refined list of the polls, where candidate totals are on the same
    %line
    poll_list = candidate_names;
    poll_line = strings(1,size(candidate_names,2));
    
    for j = start_point:-1:0
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
        if j == start_point
            old_id = poll_id;
        end
        
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
    end
    
    %For testing purposes, send the data created here into the "Test"
    %folder. In the real runs, send it into "Presidental Polls"
    poll_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polls\'...
        ,current_name,' Polls.csv');
    writematrix(poll_list,poll_location)
end
toc %On the clock, but the party don't stop, no!