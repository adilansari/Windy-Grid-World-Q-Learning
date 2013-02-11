function mainAlgo()
row = 5;
col = 6;

start.row = 5;
start.col = 1;
start;


goal.row= 5;
goal.col = 5;
goal;

wind = [0 0 0 0 0 0; 0 0 1 1 1 0; 0 0 1 1 1 0; 0 0 1 1 1 0; 0 0 1 1 0 0];
gamma = 0.9;
alpha = 0.1;
epsilon = 0.1;

episodeCount= 30;

Q= zeros(row,col,4);
newQ= ones(row,col,4) * inf; %for convergence
temp= zeros(row,col,8); %temp array for printing purpose


action=0;
iteration = 1;

rewardVector= zeros(1,5000);
for count= 1:5000
    current=start;
    step = 1;
    randN = 0 + (rand(1) * 1); %generating random double between 0 and 1
    
    if(randN > epsilon) %greedy
        [maxQ,action] = max(Q(current.row,current.col,:)); %get next pos
    else
        action = round(1 + (rand(1) * 3)); %random number between 1 and 4
    end
    
    next = start;
    
    while (isOverlap(current,goal) ~= 0 ) %until goal is reached
        if (step > episodeCount) %limited steps 30
            break;
        end
        [next, temp] = getNext(current, action, wind,temp, row, col);
        if(isOverlap(next,goal) ~= 0)
            reward = 0;
        else
            reward = 10;
        end
        [maxQ, nextAction] = max(Q(next.row, next.col, :));
        
        randN = 0 + (rand(1) * 1);
        if(randN <= epsilon)
            nextAction = round(1 + (rand(1) * 3));
        end
        
        currentQ = Q(current.row, current.col, action);
        Q(current.row, current.col, action) = currentQ + alpha* (reward + (gamma*maxQ) - currentQ);
        
        rewardVector(1,iteration) = reward;
        current = next;
        action = nextAction;
        step = step + 1;
    end
    
    
    
    %additional step to be added after goal state reached
    [next, temp] = getNext(current, action, wind,temp, row, col);
        if(isOverlap(next,goal) ~= 0)
            rewardNew = 0;
        else
            rewardNew = 10;
        end
        
    [maxQ, nextAction] = max(Q(next.row, next.col, :));   
    currentQ = Q(current.row, current.col, action);
    Q(current.row, current.col, action) = currentQ + alpha* (rewardNew + (gamma*maxQ) - currentQ);

    %converge here--------------------
    if sum(sum(abs(newQ-Q))) < 0.0001 & sum(sum(Q>0)) & (iteration > 1000)
        printEpisode(Q,row,col,start,goal,wind,iteration);
        figure('Name',sprintf('Graph'), 'NumberTitle','off');
        hold on
        for i= 1 : iteration 
            scatter(i, rewardVector(1,i), '.');
        end
        hold off
        legend('episode','reward');
        break;
    else
        newQ=Q;
    end
    
    iteration = iteration + 1;
end

function var = isOverlap(first,second)
var = first.row - second.row;
if (var == 0)
    var = first.col - second.col;
end

function [pos, temp] = getNext(current, action, wind, temp, row, col)
actIndex = action;
pos = current;
if (wind(current.row, current.col) == 0)
    switch action
        case 1 %east
            pos.col= current.col + 1;
        case 2 %south
            pos.row= current.row + 1;
        case 3 %west
            pos.col= current.col - 1;
        case 4 %north
            pos.row= current.row - 1;
    end
else
    switch action
        case 1 %northeast
            pos.col= current.col + 1;
            pos.row= current.row - 1;
            actIndex = 5;
        case 2 %stay here or hold
            pos.col= current.col;
            actIndex = 7;
        case 3 %northwest
            pos.col= current.col - 1;
            pos.row= current.row - 1;
            actIndex = 8;
        case 4 %double step north
            pos.row= current.row - 2;
    end
end
if(pos.col <= 0)
    pos.col = 1; end
if(pos.col > col)
    pos.col = col; end
if(pos.row <= 0)
    pos.row = 1; end
if(pos.row > row)
    pos.row = row; end

%----- updating temp array for printing purpose
temp(current.row, current.col, actIndex) = 1;
%-------------------------

function printEpisode(Q,row,col,start,goal,wind,iteration)
temp2 = zeros(row,col,8);
current= start;
'Optimal Path :'
'Start'
current
        for i = 1: 100
            [tempMax, act2] = max(Q(current.row,current.col,:));
            [next, temp2] = getNext(current, act2, wind,temp2, row, col);
            act2
            next
            if (isOverlap(next,goal) == 0)
                'Reached Goal'
                break;
            end
            current = next;
        end
        
figure('Name',sprintf('Episode: %d', iteration), 'NumberTitle','off');
ParseArrows(temp2, row, col);
title(sprintf('Windy grid-world, Converges on episode - %d ', iteration));