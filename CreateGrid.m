function CreateGrid(row,col)

xsp = 1 / (col + 2);
ysp = 1 / (row + 2);

x = zeros(1, 2*(col + 1));
y = zeros(1, 2*(col + 1));
i = 1;
for xi = xsp:xsp:1 - xsp,
    x(2*i - 1) = xi; x(2*i) = xi;
    if(mod(i , 2) == 0)
        y(2*i - 1) = ysp;y(2*i) = 1-ysp;
    else
        y(2*i - 1) = 1 - ysp;y(2*i) = ysp;
    end
    i = i + 1;
end

x2 = zeros(1, 2*(row + 1));
y2 = zeros(1, 2*(row + 1));
i = 1;
for yi = ysp:ysp:1 - ysp,
    y2(2*i - 1) = yi; y2(2*i) = yi;
    if(mod(i , 2) == 0)
        x2(2*i - 1) = xsp;x2(2*i) = 1-xsp;
    else
        x2(2*i - 1) = 1 - xsp;x2(2*i) = xsp;
    end
    i = i + 1;
end

plot(x, y, '-');
hold on
plot(x2, y2, '-');
axis([0 1 0 1]);
axis off
set(gcf, 'color', 'white');

start.row = 5;
start.col = 1;
start;


goal.row= 5;
goal.col = 5;
goal;
setStart(start.row, start.col, row,col)
setGoal(goal.row, goal.col, row, col)

function setStart(x,y, matrixRow,matrixCol)
xsp = 1 / (matrixCol + 2);
ysp = 1 / (matrixRow + 2);
xcor = ((2*y + 1) / 2) * xsp;
ycor = 1 - (((2*x + 1) / 2) * ysp);
xcor = xcor - xsp/5;
text(xcor,ycor, 'Start')


function setGoal(x,y, matrixRow,matrixCol)
xsp = 1 / (matrixCol + 2);
ysp = 1 / (matrixRow + 2);
xcor = ((2*y + 1) / 2) * xsp;
ycor = 1 - (((2*x + 1) / 2) * ysp);
xcor = xcor - xsp/5;
text(xcor,ycor, 'Goal')

