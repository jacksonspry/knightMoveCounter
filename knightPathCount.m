function movesAway = knightPathCount(boardX, boardY, kPos, endPos)
    
    kBoard = zeros(boardX, boardY);
    endBoard = kBoard;
    kBoard(kPos(1), kPos(2)) = -1;
    endBoard(endPos(1), endPos(2)) = -1;
    kMoves = 0;
    negMoves = 0;
    
    while true
        kBoard = step(kBoard, kMoves);
        kMoves = kMoves +1;
        if find((kBoard~=0).*(endBoard~=0))
            movesAway = kMoves+negMoves; return;
        end
        
        endBoard = step(endBoard, negMoves);
        negMoves = negMoves +1;
        if find((kBoard~=0).*(endBoard~=0))
            movesAway = kMoves+negMoves; return;
        end
        
    end  
end

function newBoard = step(board, movesAway)
    for x = 1:size(board, 1)
        for y = 1:size(board, 2)
            if movesAway == 0
                if board(x,y) == -1
                    newBoard = branch(board, x, y, movesAway + 1);
                end
            elseif board(x,y) == movesAway
                    newBoard = branch(board, x, y, movesAway + 1);  
            end
        end
    end
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