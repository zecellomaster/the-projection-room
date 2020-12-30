% FinalVoteShare.m
% Author: Zecellomaster
% This script will calculate the forcasted vote share for every state and
% district for the following candidates : Joe Biden,Donald Trump, Jo Jorgenson, Howie Hawkins

clearvars

tic

state_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\State Names.xlsx');
elasticity_matrix = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\State Elasticity.xlsx');
similarity_matrix = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\state_correlation_matrix.csv');
national_avg = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polling Average\National Average.csv');
pvi = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Cook PVI.xlsx');
final_format = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Final Vote Share Format.xlsx');
previous_results = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\ResultsAvg.xlsx');

%This is the starting date for the polls
start_date = datenum('6/6/2020');

starting_weights = [35,25,5,20,15];

for i = 1:size(state_names,1)-1
    
    current_name = string(state_names{i,1});
    avg_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polling Average\'...
    ,current_name,' Average.csv');
    averages = readtable(avg_location);
    
    final_vote_share = [string(final_format.Properties.VariableNames);...
                        strings(size(averages,1),size(final_format,2))];

    
    raw_poll_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polls\'...
    ,current_name,' Polls.csv');
    
    raw_polls = readtable(raw_poll_location);
    
    if ~isempty(raw_polls)
        raw_polls.Date.Format = 'MM/dd/yy';
    end
    
    save_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Final Vote Share\'...
    ,current_name,' Final Vote Share.csv');
    
    for j = 1:size(raw_polls,1) %MATLAB's strict rules on dates is forcing me to
        %do this as well. This code should be good for polls past 1999
        raw_date = datestr(raw_polls{j,1},2);
        raw_year = num2str(round(str2num(raw_date(end-1:end))+ 2000));
        raw_polls{j,1} = datetime(strcat(raw_date(1:end-2),raw_year));
    end
    
    %Trying to find the columns of states that are similar to the current one
    
    if i <= 51
        state_ratings = similarity_matrix{i,2:end};
        
        %This portion sorts the column values by how similar they are to
        %the state
        columns = [];
                
        while size(columns,2) ~= 50
            value = state_ratings(1,1);
            
            for j = 1:size(state_ratings,2)
                if value > state_ratings(1,j)
                    value = state_ratings(1,j);
                end
            end
            
            for j = 1:size(state_ratings,2)
                
                if value == 1
                   value = state_ratings(1,j+1);
                   continue 
                end
                
                if value < state_ratings(1,j) & state_ratings(1,j) ~= 1
                    value = state_ratings(1,j);
                    value_column = j;
                    
                elseif value == state_ratings(1,1) & j == size(state_ratings,2)
                    value_column = 1;
                end
            end
            
            state_ratings(1,value_column) = 0;
            
            columns(1,end+1) = value_column;
            columns(2,end) = value;
        end
        
    end
   
    for j = 1:size(averages,1)
        final_vote_line = strings(1,size(final_vote_share,2));
        final_vote_line(1,1) = averages{j,1};
        %This portion calculates the daily average weights for each
        %candidate and stores the vote share and variance
        for k = 2:3:size(averages,2)-1
            final_weights = zeros(1,size(starting_weights,2));
            %Stores the vote share and standard deviation of the candidates
            candidate_data = zeros(2,size(starting_weights,2));

        %State/District Polls
            state_weight = averages{j,k+2}/0.60;
            
            if state_weight > 1
                state_weight = 1;
            end
            
            final_weights(1) = starting_weights(1)* state_weight;
            candidate_data(1,1) = averages{j,k};
            candidate_data(2,1) = averages{j,k+1};
        
        %Adjusted National
            final_weights(2) = starting_weights(2)* national_avg{j,k+2};
                %* (0.5-(atan(((150-j)-50)/40)/(2*atan(5/2))));
            
        %State Similarity
            avg_state_percent = 0;
            avg_state_var = 0;
            
            if i <= 51 %This only runs for STATES (no CDs)
                percents = [];
                for l = 1:size(columns,2) % Searches for data from each 
                    %similar state
                    name = string(state_names{columns(1,l),1});
                    state_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Polling Average\'...
                            ,name,' Average.csv');
                    state_data = readtable(state_location);
                    
                    %This portion is to save the percents for the
                    %candidates, the variablility,and the weights of the states 
                    if state_data{j,k+2} ~= 0
                        percents(1,end+1) = state_data{j,k};
                        percents(2,end) = state_data{j,k+1};
                        percents(3,end) = columns(2,l);
                        percents(4,end) = state_data{j,k+2};
                    end 
                    
                    if size(percents,2) == 5
                       break 
                    end
                end
                
                if isempty(percents)
                    percents = zeros(4,1);
                end
                
                %This portion calculates the weighted average of both the
                %standard deviation and mean percentage. All of this is weighted
                %by state similarity
                %if k <= 5 %Only runs if the current canidate is Trump or Biden
                sim_weight = ((percents(3,:)/sum(percents(3,:)))+ ...
                    (percents(4,:)/sum(percents(4,:)))/2);
                candidate_data(1,3) = sum(percents(1,:).*sim_weight)/sum(sim_weight);
                candidate_data(2,3) = sum(percents(2,:).*sim_weight)/sum(sim_weight);
                avg_state_sim = sum(percents(3,:).*sim_weight)/sum(sim_weight);
                avg_state_weight = sum(percents(4,:).*sim_weight)/sum(sim_weight);

                
                final_weights(3) = starting_weights(3)*((avg_state_sim + avg_state_weight)/2);  
                %end
            end
        
        %Elasticity (only for Dem and Rep Candidates)
            if k > 5
                final_weights(4) = 0;
            else
                final_weights(4) = starting_weights(4)* averages{j,k+2}/0.60;
            end 
            
        %Previous Results
        %This portion is to calculate the column where the previous result
        %averages are for each candidate
            data_column = round((k/3)+(1/3));
            candidate_data(1,5) = previous_results{i,data_column};
            candidate_data(2,5) = national_avg{j,k+1};
            
            %results_weight = abs((0.80-averages{j,k+2})/0.025);
            if k <= 5 & size(raw_polls,1) >= 2
                final_weights(5) = starting_weights(5) * (0.5+(atan(((150-j)-50)/40)/(2*atan(5/2))));
                
            elseif k <= 5 & size(raw_polls,1) < 2 & i > 51 %Looking at you NE-01
                final_weights(5) =  starting_weights(5) * 2;
                
            else %This will also run for races where there is little to no polling
                final_weights(5) = starting_weights(5);
            end
        %This portion redistribues the weights based on how many points
        %each category has
            final_weights(isnan(final_weights)) = 0; %First remove any NaNs
        
            remaining = sum(starting_weights) - sum(final_weights);
            old_total = sum(final_weights);
            
            for l = 1:size(final_weights,2)
                final_weights(l) = ((((final_weights(l))/old_total))...
                    * remaining) + final_weights(l);
            end
        
    %This portion will make the final calculations for the adjusted
    %national vote and elasticity
        %Adjusted national vote using PVI (Note that is is negative for D+ and positive for R+

            if k == 2 %If the selected candidate is Biden, the PVI value for
                      %the state is subtracted from his total
                adjusted_nat_vote = national_avg{j,k} - pvi{i,2};
                
            elseif k == 5 %If it is Trump, the PVI is added
                adjusted_nat_vote = national_avg{j,k} + pvi{i,2};
                
            else
                adjusted_nat_vote = national_avg{j,k};
            end
            
            candidate_data(1,2) = adjusted_nat_vote;
            candidate_data(2,2) = national_avg{j,k+1};
            
        %Elasticity calculation
            current_date = datenum(averages{j,1});
            last_poll_date = start_date;
            
            %This is to find the last date a poll was taken
            for l = 1:size(raw_polls,1)
                %if final_weights(4) == 0
                %    break
                %end
                
                last_poll_date = datenum(raw_polls{l,1});
                
                if last_poll_date > current_date & (size(raw_polls,1) == 1 | ...
                        l == 1)
                    last_poll_date = start_date;
                    break
                elseif last_poll_date < current_date & size(raw_polls,1) == 1
                    break
                elseif last_poll_date > current_date & size(raw_polls,1) ~= 1
                    last_poll_date = datenum(raw_polls{l-1,1});
                    break
                end
            end
            
                           
            %Basically to make sure that the program doesn't search for
            %an average on a date that hasn't been calculated
            if last_poll_date < start_date
                last_poll_date = start_date;
            end
                            
            %This part sets the index of the national average on the
            %date of the last poll
            days_before = current_date - last_poll_date ;
            average_index = j - days_before;
            
            percent_change = national_avg{j,k}-national_avg{average_index,k};

            candidate_data(1,4) = averages{j,k} + (percent_change*elasticity_matrix{i,2});
            candidate_data(2,4) = averages{j,k+1};
            
            %Sets any NaN values to 0
            candidate_data(isnan(candidate_data)) = 0;
            
            %Finally, onto the calculations
            cat_weights = final_weights/sum(final_weights);
            candidate_percent = sum(candidate_data(1,:).*cat_weights)/sum(cat_weights);
            candidate_b = sum(candidate_data(2,:).*cat_weights)/sum(cat_weights);
            
            %This portion is to calculate the column that the data will be
            %put in
            candidate_column = round(((2/3)*k) + (2/3));
            
            final_vote_line(1,candidate_column) = string(candidate_percent);
            final_vote_line(1,candidate_column+1) = string(candidate_b);
        end
        
        total = 0; 
        valid_candidates = 0;
        
        for k = 2:2:size(final_vote_line,2)
            if isnan(str2double(final_vote_line(1,k)))
                old_value = 0;
            else
                old_value = str2double(final_vote_line(1,k));
                valid_candidates = valid_candidates + 1;
            end
            total = old_value + total;
        end
        
        over = 100 - total;
        
        for k = 2:2:size(final_vote_line,2)
            final_vote_line(1,k) =  string(str2double(final_vote_line(1,k)) + ...
                (over/valid_candidates));
        end
    
         final_vote_share(j+1,:) = final_vote_line;
    end
    writematrix(final_vote_share,save_location);
end

toc
