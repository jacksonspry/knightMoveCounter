function movesAway = knightPathCount(boardX, boardY, kPos, endPos, draw)
    %  knightPathCount(8, 8, [1,1], [8,8], true)
    %  knightPathCount(15, 15, [2,13], [9,3], true)
    %  knightPathCount(300, 300, [1,1], [300,300], false)
    tic
    
    kBoard = zeros(boardX, boardY);
    endBoard = kBoard;
    kBoard(kPos(1), kPos(2)) = -1;
    endBoard(endPos(1), endPos(2)) = -1;
    kMoves = 0;
    endMoves = 0;
    
    while true
        kBoard = step(kBoard, kMoves);
        kMoves = kMoves +1;
        
        if draw
            drawBoard(kBoard, endBoard);
            pause(.5);
        end
        
        if find((kBoard~=0).*(endBoard~=0))
            movesAway = kMoves+endMoves;
            toc
            return;
        end
         
        endBoard = step(endBoard, endMoves);
        endMoves = endMoves +1;
        
        if draw
            drawBoard(kBoard, endBoard);
            pause(.5);
        end
        
        if find((kBoard~=0).*(endBoard~=0))
            movesAway = kMoves+endMoves;
            toc
            return;
        end
    end  
end

function newBoard = step(board, movesAway)
    for x = 1:size(board, 1)
        for y = 1:size(board, 2)
            if movesAway == 0
                if board(x,y) == -1
                    board = branch(board, x, y, movesAway + 1);
                end
            elseif board(x,y) == movesAway
                    board = branch(board, x, y, movesAway + 1);  
            end
        end
    end
    newBoard = board;
end

function newBoard = branch(board, x, y, setMove)
    for a = -2:2
        if a ~= 0
            for b = -1:2:1
                lCoords = [a, b*(1-(abs(a) - 2))];
                try 
                    if board(x+lCoords(1), y+lCoords(2)) == 0
                        board(x+lCoords(1), y+lCoords(2)) = setMove;
                    end
                end
            end
        end      
    end
    newBoard = board;
end

function draw = drawBoard(board1, board2)
    boardX = size(board1, 2);
    boardY = size(board1, 1);
    plotObj = plot([0 boardX], [0 0], 'k-', [0 0], [0 boardY], 'k-', [boardX boardX], [0 boardY], 'k-', [0 boardX], [boardY boardY], 'k-');
    axesObj = plotObj.Parent;
    axesObj.XGrid = 'on';
    axesObj.YGrid = 'on';
    axesObj.GridAlpha = 1;
    xticks(1:boardX);
    yticks(1:boardY);
    xticklabels([]);
    yticklabels([]);
    for x = 1:boardX
        for y = 1:boardY
            if board1(y, x) ~= 0 && board2(y, x) ~=0
                count = board1(y, x)+board2(y, x);
                text(.30 + (x-1), .55 + (y-1),num2str(count),'Color','magenta', 'FontSize', 20);
            elseif board1(y, x) ~= 0
                if board1(y, x) == -1
                    text(.30 + (x-1), .55 + (y-1),'K','Color','black', 'FontSize', 20);
                else
                    text(.30 + (x-1), .55 + (y-1),num2str(board1(y, x)),'Color','red', 'FontSize', 20);
                end
            elseif board2(y, x) ~= 0
                if board2(y, x) == -1
                    text(.30 + (x-1), .55 + (y-1),'E','Color','black', 'FontSize', 20);
                else
                    text(.30 + (x-1), .55 + (y-1),num2str(board2(y, x)),'Color','blue', 'FontSize', 20);
                end
            end
        end
    end
end