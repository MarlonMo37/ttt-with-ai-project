class Game

    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
       [0, 1, 2],
       [3, 4, 5],
       [6, 7, 8],
       [0, 3, 6],
       [1, 4, 7],
       [2, 5, 8],
       [0, 4, 8],
       [6, 4, 2],
     ]

     def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
     end

     def current_player
        if @board.turn_count % 2 == 0
            @player_1
        else
            @player_2
        end
     end

     def won?
        WIN_COMBINATIONS.detect do |seq|
            @board.cells[seq[0]] == @board.cells[seq[1]] && @board.cells[seq[1]] == @board.cells[seq[2]] && @board.taken?(seq[0]+1)
        end
     end

     def draw?
        @board.full? && !won?    
     end

     def over?
        won? || draw?
     end

     def winner 
        if seq = won?
            @board.cells[seq.first]
        end
     end

     def turn
        player = current_player
        current_turn = player.move(@board)
        if !@board.valid_move?(current_turn)
         turn
        else 
         @board.display
         @board.update(current_turn, player)
         @board.display
        end
     end

     def play
      while !over?
         turn
      end

      if won?
         puts "Congratulations #{winner}!"
      elsif 
         puts "Cat's Game!"
      end
     end

end