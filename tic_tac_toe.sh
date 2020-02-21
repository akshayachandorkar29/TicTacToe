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

function toss()
{
	toss=$(( RANDOM % 2 ))
	if [[ $toss -eq 1 ]]
	then
		echo Player plays first
	else
		echo Computer plays first
	fi
}

function display_board()
{
	for (( i=1; i<=3; i++ ))
	do
		for (( j=1; j<=3; j++ ))
		do
			echo -n ${board[j]}
		done
		echo ""
	done
}

