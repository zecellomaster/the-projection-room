% Chance Estimator.m
% Author: Zecellomaster
% This script will calculate the forcasted chance of victory for every state 
% and district for the following candidates : Joe Biden,Donald Trump, 
% Jo Jorgenson, Howie Hawkins

clearvars

tic
state_names = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\State Names.xlsx');
odds_format = readtable('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Odds Format.xlsx');

%Set the number of simulations here
sim_num = 25000;

for i = 1:size(state_names) - 1

    
    %Gets the final vote share numbers
    current_name = string(state_names{i,1});
    vote_share_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Final Vote Share\'...
        ,current_name,' Final Vote Share.csv');
    final_vote = readtable(vote_share_location);
    
    final_odds = [string(odds_format.Properties.VariableNames);...
        strings(size(final_vote,1),size(odds_format,2))];
    
    odds_location = strcat('C:\Users\BOSS COMPUTER\Documents\Election Stuff\Data\Presidential Odds\'...
        ,current_name, ' Odds.csv');
    
    for j = 1:size(final_vote,1)
        odds_line = strings(1,size(odds_format,2));
        odds_line(1,1) = final_vote{j,1};
        candidates_mean = zeros(1,(size(final_vote,2)-1)/2);
        candidates_sd = zeros(1,(size(final_vote,2)-1)/2);
        
        for k = 2:2:size(final_vote,2)
            candidates_mean(1,k/2) = final_vote{j,k};
            candidates_sd(1,k/2)  = final_vote{j,k+1};
        end
        
        %This part initiates the Gaussian Simulation
        num_wins = zeros(1,size(candidates_mean,2));
        for k = 1:sim_num
            projected_vote = zeros(1,size(candidates_mean,2));
            for l = 1:size(candidates_mean,2)
                sd = (candidates_sd(1,l))*1.644854;
                mean = candidates_mean(1,l);
                
                projected_vote(1,l) = (sd*randn + mean);
            end
            
            [M,I] = max(projected_vote);
            
            num_wins(1,I)= num_wins(I) + 1;
        end
        
        
        for k = 2:size(odds_line,2)
            odds_line(1,k) = num_wins(1,k-1)/sim_num;
        end
        final_odds(j+1,:) = odds_line;
    end
    
    writematrix(final_odds,odds_location)
end
toc

% This part calculates the percent chance that a candidate will win
% nationally 
