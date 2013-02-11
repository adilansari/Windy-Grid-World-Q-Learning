function ParseArrows(arr, matrixRow, matrixCol)

CreateGrid(matrixRow, matrixCol)

for row = 1:matrixRow
    for col = 1:matrixCol
        for act = 1:8
            if (arr(row,col,act) == 1)
                DrawArrow(act, row, col, matrixRow, matrixCol)
            end
        end
    end
end

function DrawArrow(act, row, col, matrixRow, matrixCol)
rotation = 0;
textToDraw = 'o';

switch act
   case 1 % east
       textToDraw = '\rightarrow';
       rotation = 0;
   case 2 % south
       textToDraw = '\downarrow';
       rotation = 0;
   case 3 % west
       textToDraw = '\leftarrow';
       rotation = 0;
   case 4 % north
       textToDraw = '\uparrow';
       rotation = 0;
   case 5 % northeast 
       textToDraw = '\rightarrow';
       rotation = 45;
   case 6 % southeast 
       textToDraw = '\downarrow';
       rotation = 45;
   case 7 % southwest       %replaced by hold
       textToDraw = 'o';    %textToDraw = '\leftarrow';
       rotation = 0;       %rotation = 45;
   case 8 % northwest
       textToDraw = '\uparrow';
       rotation = 45;
   case 9 % hold
       textToDraw = 'o';
       rotation = 0;
   otherwise
      disp(sprintf('invalid action index: %d', act))
end

xsp = 1 / (matrixCol + 2);
ysp = 1 / (matrixRow + 2);
xcor = ((2*col + 1) / 2) * xsp;
ycor = 1 - (((2*row + 1) / 2) * ysp);
xcor = xcor - xsp/5;
text(xcor, ycor, textToDraw, 'Rotation', rotation)
