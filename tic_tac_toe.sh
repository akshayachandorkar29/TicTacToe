#!/bin/bash -x

echo -----WELCOME to the world of TIC TAC TOE-----

#constant
TOTAL_CELL=9

#variables
winner=0
switchPlayer=0
count=0
player_symbol="O"
computer_symbol="X"
turnChange=$player_symbol
declare -a board

function resetting_board()
{
	board=(. . . . . . . . . .)
}

function check_symbol()
{
	random_number=$(( RANDOM % 2 ))
	if [[ $random_number -eq 0 ]]
	then
		player_symbol="X"
		computer_symbol="O"
	fi
}

function toss()
{
	toss=$(( RANDOM % 2 ))
	if [[ $toss -eq 0 ]]
	then
		switchPlayer=0
		echo Player plays first
	else
		switchPlayer=1
		echo Computer plays first
	fi
}

function display_board()
{
	echo "| ${board[1]} | ${board[2]} | ${board[3]} |"
	echo "- - - - - - -"
	echo "| ${board[4]} | ${board[5]} | ${board[6]} |"
	echo "- - - - - - -"
	echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
}

function switch_player()
{
   if [[ $switchPlayer == 0 ]]
   then
      player_playing
   else
      computer_playing
   fi
	winning_condition $turnChange
}


function player_playing()
{
   echo "PLAYER'S TURN"
   read -p "Enter Position between 1 to 9: " position
	turnChange=$player_symbol
   check_is_empty
   board[$position]=$player_symbol
	switchPlayer=1
}

function computer_playing()
{
   echo "COMPUTER'S TURN"
   position=$(( RANDOM % 9 + 1 ))
   turnChange=$computer_symbol
   check_is_empty
   board[$position]=$computer_symbol
   switchPlayer=0
}

function winning_condition()
{
	#checking ROW wise WIN
	for (( i=1; i<=$TOTAL_CELL;  i=$(( $i+3 )) ))
	do
		if [[ ${board[$i]} == ${board[ $i + 1 ]} && ${board[ $i + 1 ]} == ${board[ $i + 2 ]} && ${board[ $i + 2 ]} == $1 ]]
		then
			winner=1
		fi
	done

	#checking COLUMN wise WIN
	for (( i=1; i<=3; i++ ))
	do
      if [[ ${board[$i]} == ${board[$i+3]} && ${board[$i+3]} == ${board[$i+6]} && ${board[$i]} == $1 ]]
      then
         winner=1
      fi
   done

	#checking DIAGONAL1 wise WIN
	if [[ ${board[1]} == ${board[5]} && ${board[5]} == ${board[9]} && ${board[5]} == $1 ]]
	then
		winner=1
	fi

	#checking DIAGONAL2 wise WIN
	if [[ ${board[3]} == ${board[5]} && ${board[5]} == ${board[7]} && ${board[5]} == $1 ]]
	then
		winner=1
	fi
}

function check_is_empty()
{
	if [[ $position -ge 1 && $position -le 9 ]]
	then
		if [[ ${board[$position]} == '.' ]]
		then
			echo $turnChange is placed at $position
			(( count++ ))
		else
			echo "Position is already filled"
			switch_player
		fi
	else
		echo "Invalid Cell"
		switch_player
	fi
}

function check_game_status()
{
	if [[ $winner == 1 ]]
	then
		echo "Winner is $turnChange"
		exit
	elif [[ $count -ge 9 ]]
	then
		echo "MATCH TIE"
	fi
}

resetting_board
check_symbol
toss
display_board

while [[ $count -ne $TOTAL_CELL ]]
do
	switch_player
	display_board
	check_game_status
done


