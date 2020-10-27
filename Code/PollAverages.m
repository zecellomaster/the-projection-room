% PollAverages.m
% Author: Zecellomaster
% This script will calculate the polling averages nationally, as well as
% for every state and district for the following candidates : Joe Biden, 
% Donald Trump, Jo Jorgenson, Howie Hawkins
clearvars
tic
%Set for how far back in time polling averages are needed
days_before = 150;
election_date = datenum('11/03/20','mm/dd/yy');
current_date = floor(datenum(now,2));
start_date = election_date - days_before;

state_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\State Names.xlsx');

for i = 1:size(state_names,1) %This loop selects each state/district 
                               %to calculate the candidates' polling average
    current_name = string(state_names{i,1});
    poll_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polls\'...
    ,current_name,' Polls.csv');
    polls = readtable(poll_location);
    
    save_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polling Average\'...
    ,current_name,' Average.csv');
    
    %Sets up format for the first row of polling average data
    average_format = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polling Average Format.xlsx');
    polling_average = string(average_format.Properties.VariableNames);
    

    
    if isempty(polls) %Only executes if there is no polls for a state/district
        for j = start_date:current_date
            polling_average(j-start_date + 2,:) = string(zeros(1,size(average_format,2)));
            raw_date = datestr(j,2);
            raw_year = num2str(round(str2num(raw_date(end-1:end))+ 2000));
            polling_average(j-start_date + 2,1) = string(strcat(...
                raw_date(1:end-2),raw_year));
        end
        writematrix(polling_average,save_location);
        continue
    end
    
    polls.Date.Format = 'MM/dd/yy';
    
    for j = 1:size(polls,1) %MATLAB's strict rules on dates is forcing me to
        %do this as well. This code should be good for polls past 1999
        raw_date = datestr(polls{j,1},2);
        raw_year = num2str(round(str2num(raw_date(end-1:end))+ 2000));
        polls{j,1} = datetime(strcat(raw_date(1:end-2),raw_year));
    end
    %This part needed since data will be inserted in the column after the
    %last candidate
    last_column = size(polls,2);
    polls{:,last_column+1} = zeros(size(polls,1),1);

    
    for j = 1:size(polls,1)
        %Calculating the weights for each of the polls

        sample = polls{j,4};
        %This portion of the algorithm deals with the sample size weight for
        %national polls
        if i == size(state_names,1)
            multiplier = (atan(sample/350)/atan(5/2));
        else 
        %This portion deals with the sample size weight for state polls
            multiplier = (atan(sample/280)/atan(5/2));
        end
  
        %This portion sets the weight for the grade
        grade = string(polls{j,3});
        
        switch grade
            case {"A+"}
                multiplier = multiplier*1.10;
            
            case{"A"}
                multiplier = multiplier*0.965;
            
            case {"A-"}
                multiplier = multiplier*0.920;
        
            case {"A/B" "B+"}
                multiplier = multiplier*0.88;
        
            case {"B"}
                multiplier = multiplier*0.845;
            
            case {"B-"}
                multiplier = multiplier*0.81;
            
            case {"B/C" "C+"}
                multiplier = multiplier*0.78;
        
            case {"C"}
                multiplier = multiplier*0.745;
            
            case {"C-"}
                multiplier = multiplier*0.71;
            
            case {"C/D" "D+"}
                multiplier = multiplier*0.58;
            
            case {"D"}
                multiplier = multiplier*0.545;
            
            case {"D-"}
                multiplier = multiplier*0.41;
                
            otherwise
                multiplier = multiplier*0.745;
        end
        
        poll_type = string(polls{j,5});
        
        if isequal(poll_type,"lv")
            multiplier = multiplier*1.1;
            
        elseif isequal(poll_type, "rv")
            multiplier = multiplier*1.05;
        end
        
        polls{j,last_column+1} = multiplier;
    end
    
    for j = start_date:current_date
    %This portion selects the valid polls that were taken before the
    %selected date
        for k = 1:size(polls,1)
                    
            poll_date = datenum(polls{k,1});
            
            %This portion sets the weight for the proximity to the current
            %date. This multiplier is set to the column after the
            %previously calculated one
            if (j - poll_date) <= 25
                polls{k,last_column+2} = polls{k,last_column+1} * (1-((j - poll_date)/50));
            
            elseif (j - poll_date) > 25 & (j - poll_date) <= 100
                polls{k,last_column+2} = polls{k,last_column+1} * ((-1/250)*(j - poll_date)) + (3/5);
                
            elseif (j - poll_date) > 100
                polls{k,last_column+2} = polls{k,last_column+1} * 0.2 ;
            end
            %Remember that j represents the selected date to calculate
            %averages
            if j >= poll_date & k ~= size(polls,1)
                continue
            elseif j >= poll_date & k == size(polls,1)
                selected_polls = polls(1:k,:);
                break
            elseif j < poll_date %& k ~= size(polls,1)
                selected_polls = polls(1:k-1,:);
                break
            end
        end

        average_line = strings(1,size(average_format,2));
        average_line(1,1) = string(datestr(j,23));
        
        
        if isempty(selected_polls)
            average_line(1,2:end) = string(zeros(1,size(average_format,2)-1));
            polling_average = [polling_average;average_line];
            continue
        end 
    
        for k = 2:3:size(average_format,2)-1
            %This establishes which of the selected candidate's column number 
            %to the one in the poll matrix's format
            candidate_column = round((k/3)+(16/3));
            
            candidate_data = rmmissing([selected_polls{:,candidate_column},...
                selected_polls{:,last_column+2}],1);
            
            if isempty(candidate_data) %Only runs if a candidate has no data
                average_line(1,k:k+2) = string(zeros(1,3));
                continue
            end
            
            %Calculating the weighted average percentage, the weighted standard
            %deviation and the weighted multiplier for each candidate
            weight = candidate_data(:,2)/sum(candidate_data(:,2));
            average_line(1,k) = string(sum(candidate_data(:,1).*weight)/sum(weight));
            average_line(1,k+1) = string(std(candidate_data(:,1),weight));
            average_line(1,k+2) = string(sum(candidate_data(:,2).*weight)/sum(weight));
        end
        %This part adjusts for the undecided voters by adding together all
        %the candidate's total and subtracting them from 100. If the 3rd
        %party vote share is 0, it is assumed that it is 3%, which is used
        %for calculation
        
        %IMPORTANT: If you change the number of candidates being averaged,
        %you MUST change these column names to the appropriate names/types 
        %of candidates  or else this will break
        third_party_vote = str2double(average_line(8)) + str2double(average_line(11));
        
        if third_party_vote == 0
           third_party_vote = 3; 
        end
        
        main_vote = str2double(average_line(2)) + str2double(average_line(5));
        
        undecided = 100 - (main_vote + third_party_vote);
        
        average_line(1,2) = string(num2str(str2double(average_line(1,2)) +...
            (undecided/2)));
        
        average_line(1,5) = string(num2str(str2double(average_line(1,5)) +...
            (undecided/2)));
        
        polling_average = [polling_average;average_line];
    end
    
    writematrix(polling_average,save_location)
end
toc
