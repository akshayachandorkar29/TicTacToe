#!/bin/bash -x

echo -----WELCOME to the world of TIC TAC TOE-----

#constant
TOTAL_CELL=9

#variables
winner=0
switchPlayer=0

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

function winningCondition()
{
	#checking ROW wise WIN
	for (( i=1; i<=$TOTAL_CELL;  i=$(( $i+3 )) ))
	do
		if [[ ${board[$i]} == ${board[ $i + 1 ]} && ${board[ $i + 1 ]} == ${board[ $i + 2 ]} ]]
		then
			winner=1
		fi
	done

	#checking COLUMN wise WIN
	for (( i=1; i<=3; i++ ))
	do
      if [[ ${board[$i]} == ${board[$i+3]} && ${board[$i+3]} == ${board[$i+6]} ]]
      then
         winner=1
      fi
   done

	#checking DIAGONAL1 wise WIN
	if [[ ${board[1]} == ${board[5]} && ${board[5]} == ${board[9]} ]]
	then
		winner=1
	fi

	#checking DIAGONAL2 wise WIN
	if [[ ${board[3]} == ${board[5]} && ${board[5]} == ${board[7]} ]]
	then
		winner=1
	fi
}

function switchPlayer()
{
	if [[ $switchPlayer == 0 ]]
	then
		switchPlayer=1
		echo switch player is $switchPlayer
	fi
}

function checkEmpty()
{
	if [[ $position -ge 1 && $position -le 9 ]]
	then
		if [[ ${board[$i]} == '.' ]]
		then
			board[$i]=$player_symbol
			echo ${board[$i]}
		else
			echo "Position is already filled"
		fi
	fi
}

