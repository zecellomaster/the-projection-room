% Computerized Realtime Accounting Program (CRAP) v1.0
% Author: Zecellomaster
% Documentation can be found at: https://bit.ly/3htmztN
% Notes: Uses getTableFromWeb_mod
tic
clearvars
%Race order KY Senate-Dem, NY CD 16-Dem, NY CD 17-Dem
url_list = ["https://www.washingtonpost.com/elections/election-results/kentucky-senate-primary-live-results/",...
    "https://www.washingtonpost.com/elections/election-results/new-york-house-primary-live-results/",...
    "https://www.washingtonpost.com/elections/election-results/new-york-house-primary-live-results/"];

%Shows whether or not the expected 
expected_turnout = [true, false, false];
names = ["Charles Booker","Mike Broihier","Amy McGrath","Others/Undecided";...
    "Jamaal Bowman", "Eliot Engel", "Chris Fink","Others/Undecided"];
names_2 = ["David Buchwald","David Carlucci","Evelyn Farkas","Mondaire Jones","Adam Schleifer", "Others"];
table_location = [1,29,33];
forecast_files = ["C:\Users\BOSS COMPUTER\Documents\Election Stuff\KYDemSenate.xlsx", "",""];

should_continue = true;

while should_continue == true
%%
% This portion of the code gathers data such as current vote numbers for
% each of the candidates, percentages, and vote total.
    
    for i = 1:1
    url = url_list(i);
    results_table = getTableFromWeb_mod(url, table_location(1));
    forecast = readtable(forecast_files(i));
    current_names = names(i,:);
    num = size(current_names,2);
    candidate_votes = NaN(1,num);
    candidate_percents = NaN(1,num);
    description_string = results_table{end,1};
    total_votes_location = strfind(description_string," votes reported")-1;
    total_votes = str2num(erase(description_string(1,1:total_votes_location),','));
    
        for j = 1:num
            if j == num
                candidate_votes(j) = total_votes - sum(candidate_votes(1:end-1));
                candidate_percents(j) = (1 - sum(candidate_percents(1:end-1)));
            end
            for k = 2:size(results_table,1)
                ncheck = isempty(strfind(results_table{k,1},current_names(j)));
                if ncheck == false
                    temp_var = erase(results_table{k,2},',');
                    candidate_votes(j) = str2num(temp_var(1:end));
                    temp_var = erase(results_table{k,3},',');
                    candidate_percents(j) = str2num(temp_var(1:end-1))/100;
                    break
                end
            end
        end
        mat2sheets('1BMKeNSRM4k_ESgQ1PIR4RmJZ3Ly_wqv7Iz9HViv7UMM','0',[2,2],candidate_percents);
        
        if expected_turnout(i) == true
            turnout_location = [strfind(description_string,"to be"),...
                strfind(description_string," of expected")-2];
            turnout = str2num(description_string(1,turnout_location(1)+...
                6:turnout_location(2)));   
        else
            turnout_location = [strfind(description_string," from "),...
                strfind(description_string,"% of precincts.")-1];
            turnout = str2num(description_string(1,turnout_location(1)...
                +6:turnout_location(2)));
        end
        
        mat2sheets('1BMKeNSRM4k_ESgQ1PIR4RmJZ3Ly_wqv7Iz9HViv7UMM','0',[2,6],...
            turnout/100);
        multiplier = -atan((50-turnout)/20)/(2*atan(5/2)) + 0.5;
%%
    % Gaussian simulation
        num_wins = zeros(1,num);
        trial = num_wins;
        percent_list = zeros(4,101);
        forecasted_total_votes = (100*total_votes)/turnout;
        whatever = zeros(1,num);
        
        for w = 1:num
        projected_final = candidate_votes(w) + ((multiplier*candidate_percents(w))... 
                        + ((1-multiplier)*(forecast{1,w+1})))*(forecasted_total_votes - total_votes);
        projected_percent = ((projected_final/forecasted_total_votes)*100);
        whatever(w) = projected_percent;
        end

        for k = 1:30000
            com_sim = 100;
            projection_list= zeros(1,num);
            for j = 1:num
                b = forecast{1,j+1} * 100;
                a = forecast{2,2}*100;
                sim_vote =(a*randn + b);
                if com_sim == 0
                    sim_vote = 0;
                end

                %if j == num
                %   sim_vote = com_sim; 
                %end

                while sim_vote > com_sim || sim_vote < 0
                    sim_vote =  (a*randn + b);
                end

                com_sim = com_sim - sim_vote;
                
                projected_final = candidate_votes(j) + ((multiplier*candidate_percents(j))... 
                    + ((1-multiplier)*(sim_vote/100)))*(forecasted_total_votes - total_votes);
                projected_percent = round((projected_final/forecasted_total_votes)*100);
                projection_list(j) = projected_percent;                
                percent_list(j,projected_percent+1) = percent_list(j,projected_percent+1) + 1;
            end
            %Determine winner and records it the number of times each candidate
            %wins
            [value,win_index] = max(projection_list);
            num_wins(win_index) =  num_wins(win_index) + 1;
        end
        
        mat2sheets('1BMKeNSRM4k_ESgQ1PIR4RmJZ3Ly_wqv7Iz9HViv7UMM','0',[9,2],percent_list);       
        mat2sheets('1BMKeNSRM4k_ESgQ1PIR4RmJZ3Ly_wqv7Iz9HViv7UMM','0',[4,2],whatever);
        mat2sheets('1BMKeNSRM4k_ESgQ1PIR4RmJZ3Ly_wqv7Iz9HViv7UMM','0',[6,2],num_wins);
toc
        should_continue = input("Continue? (true/false)");
    end
end
