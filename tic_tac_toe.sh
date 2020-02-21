#!/bin/bash -x

echo -----WELCOME to the world of TIC TAC TOE-----

#constant
TOTAL_CELL=9


declare -a board

function resetting_board()
{
	board=(. . . . . . . . . .)
}

function checkSymbol()
{
	random_number=$(( RANDOM % 2 ))
	if [[ $random_number -eq 0 ]]
	then
		player_symbol="O"
	else
		player_symbol="X"
	fi

	echo You have got $player_symbol symbol
}

