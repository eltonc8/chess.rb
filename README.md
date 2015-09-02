# Ruby Chess

This file demonstrates a ruby implementation of the classic game, Chess.

#### Features

* Interactive display. Select squares changes color upon selection of a piece, showing the selected piece's possible moves.
* Class inheritance reduce code redundancy.
  * Each chess piece is an instance of a class.
  * Types of chess pieces share common methods to DRY code.
* Implementation of I/O functions permit saving and loading of games.

#### How to run

* download repository to local file.
* to begin a new game, run `ruby chessgame.rb`
  * use arrow keys to navigate game board.
  * press enter to select, move, or deselect a piece.
* to load a game, run `ruby chessgame.rb [filename]`
* to save a game, during any turns, press `s`

![en_passant]: ./img/en_passant.png
![castling_1]: ./img/castling_1.png
![castling_2]: ./img/castling_2.png
