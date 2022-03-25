clear,clc

startPosition = [37 75];
goalPosition = [29 27];

%loadmap£¬0 is forbid£¬1 is avaliable
load TT_new.mat
map = TT;

[mapRow, mapCol] = size(map);

if map(startPosition(1), startPosition(2)) ~= 1
    error('Parameters Error! in startPosition');
elseif map(goalPosition(1), goalPosition(2)) ~= 1
    error('Parameters Error! in goalPoaition');
end

%initial open list and close list
closeList = struct('row', 0, 'col', 0, 'g', 0, 'h', 0);
closeListLength = 0;
openList = struct('row', 0, 'col', 0, 'g', 0, 'h', 0);
openListLength = 0;
%scanning target
direction = [0, -1; 0, 1; -1, 0; 1, 0; 1, 1; 1, -1; -1, 1; -1, -1];

openList(1).row = startPosition(1);
openList(1).col = startPosition(2);
openListLength = openListLength + 1;

while openListLength > 0
    
    f = openList(1).g + openList(1).h;
    nodePosition = 1;%record
    for i = 1:openListLength
        if f > openList(i).g + openList(i).h
            f = openList(i).g + openList(i).h;
            nodePosition = i;
        end
    end
    
    %put f smallest into close list
    closeListLength = closeListLength + 1;
    closeList(closeListLength) = openList(nodePosition);
    openListLength = 0;
    
    %if target
    if closeList(closeListLength).row == goalPosition(1) &&...
        closeList(closeListLength).col == goalPosition(2)    
        break;
    end
    
    %8 direcitons node
    for i = 1:8
        newPosition = [closeList(closeListLength).row, closeList(closeListLength).col] ...
                + direction(i, :);
        
        if all(newPosition > 0) && newPosition(1) <= mapRow ...
                && newPosition(2) <= mapCol ...
                && map(newPosition(1), newPosition(2)) == 1
            flag = false;
            for j = 1:closeListLength
                
                if closeList(j).row == newPosition(1)...
                        && closeList(j).col == newPosition(2)
                    flag = true;
                    break;
                end
            end
            
            if flag
                continue;
            end
            
            openListLength = openListLength + 1;
            openList(openListLength).row = newPosition(1);
            openList(openListLength).col = newPosition(2);
            %different cost 
            openList(openListLength).g = closeList(closeListLength).g + sqrt(abs(direction(i,1)) + abs(direction(i,1)));    
            
            openList(openListLength).h = (goalPosition(1) - ...
                openList(openListLength).row)^2 + (goalPosition(2) - ...
                openList(openListLength).col)^2;
        end
    end
end

%draw region and bound
figure;
hold on
for i=1:size(map,1)
	for j=1:size(map,2)
		if(map(i,j) == 1)
			plot(j+.5,size(map,1)-i+1+.5,'.','Color','r');
		elseif(map(i,j) == 3)
			plot(j+.5,size(map,1)-i+1+.5,'.','Color','b');
		end
	end
end

% draw start and target points
scatter(startPosition(2)+0.5,-startPosition(1)+size(map,1)+1+0.5,40,'b','filled');
scatter(goalPosition(2),-goalPosition(1)+size(map,1)+1+0.5,40,'b','filled');

% draw the shortest path
for i = 2:closeListLength-1
    plot(closeList(i).col+0.5,-closeList(i).row+size(map,1)+1+0.5,'g--*');
    pause(0.1);
end


