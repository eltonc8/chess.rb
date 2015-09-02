# Ruby Chess

This file demonstrates a ruby implementation of the classic game, Chess.

#### Features

* Interactive display. Select squares changes color upon selection of a piece, showing the selected piece's possible moves.
* Class inheritance reduce code redundancy.
  * Each chess piece is an instance of a class.
  * Types of chess pieces share common methods to DRY code.
* Implementation of I/O functions permit saving and loading of games.
* Special moves, en passant and castling, are implemented in their respective classes, demonstrating effective modularity of code.

#### How to run

* download repository to local file.
* to begin a new game, run `ruby chessgame.rb`
  * use arrow keys to navigate game board.
  * press enter to select, move, or deselect a piece.
* to load a game, run `ruby chessgame.rb [filename]`
* to save a game, during any turns, press `s`

##### en passant
* Special capture move, en passant, is discriminately permitted for only the pawn (f-5) moved in the previous turn, and not for pawn moved at an earlier time (d-5).
![en_passant](https://raw.githubusercontent.com/eltonc88/chess.rb/master/img/en_passant.png)

##### castling
* Special move, castling, is permitted for king and rook pairs that were in original positions.
![castling_1](https://raw.githubusercontent.com/eltonc88/chess.rb/master/img/castling_1.png)

* Castling move is not permitted in the direction of a rook that had been moved.
![castling_2](https://raw.githubusercontent.com/eltonc88/chess.rb/master/img/castling_2.png)
