#!/bin/bash -x

echo -----WELCOME to the world of TIC TAC TOE-----

#constant
TOTAL_CELL=9

#variables
winner=0
switchPlayer=0
count=0
player_symbol=O
computer_symbol=X
turnChange=$player_symbol
temp=$turnChange
temp_player=O
temp_computer=O

block=0
position=1

declare -a board

#function for setting the board
function resetting_board()
{
	board=(. . . . . . . . . .)
}

#this function generates a random number and assign symbol X or O to the player
function check_symbol()
{
	random_number=$(( RANDOM % 2 ))
	if [[ $random_number -eq 0 ]]
	then
		player_symbol=X
		temp_player=$player_symbol
		computer_symbol=O
		temp_computer=$computer_symbol
	fi
}

#toss function to check who playes first
function toss()
{
	toss=$(( RANDOM % 2 ))
	if [[ $toss -eq 0 ]]
	then
		switchPlayer=0
		echo Player plays first
	fi
}

#this function will print the board
function display_board()
{
	echo "- - - - - - -"
	echo "| ${board[1]} | ${board[2]} | ${board[3]} |"
	echo "- - - - - - -"
	echo "| ${board[4]} | ${board[5]} | ${board[6]} |"
	echo "- - - - - - -"
	echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
	echo "- - - - - - -"
	echo "-------------------------------------------------------------------------------"
}

#this function will switch the turns of user and computer
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

#if switch_player returns 0 player will play the game
function player_playing()
{
   echo "PLAYER'S TURN"
   read -p "Enter Position between 1 to 9: " position
	turnChange=$player_symbol
   check_is_empty
   board[$position]=$player_symbol
	switchPlayer=1
}

#this function gets called if switch_player generates 1
function computer_playing()
{
   echo "COMPUTER'S TURN"
	computer_playing_to_win
	computer_playing_to_block
	if [[ $block == 0 ]]
	then
		take_available_corners
	fi
	switchPlayer=0
}

#this function will check winning combinations
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

#this function returns whether the row is empty or not to place the symbol
function check_is_empty()
{
	if [[ $position -ge 1 && $position -le 9 ]]
	then
		if [[ ${board[$position]} == . ]]
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

#computer will traverse whole board to check if he can win
function computer_playing_to_win()
{
	for (( j=1; j<=$TOTAL_CELL; j++ ))
	do
		if [[ ${board[$j]} == . ]]
		then
			#computer will place the symbol and check if he can win
			board[$j]=$computer_symbol
			winning_condition $computer_symbol
			if [[ $winner -eq 1 ]]
			then
				display_board
				echo "WINNNER is COMPUTER"
				#echo "Winner is $computer_symbol"
				exit
			else
				board[$j]="."
				block=0
			fi
		fi
	done
}

#computer will check whether opponent wins by putting his symbol and observing winner value and block if winner is 1
function computer_playing_to_block
{
	for (( k=1; k<=$TOTAL_CELL; k++ ))
	do
		if [[ ${board[$k]} == . ]]
		then
			board[$k]=$player_symbol
			winning_condition $player_symbol
			if [[ $winner -eq 1 ]]
			then
				board[$k]=$computer_symbol
				winner=0
				block=1
				(( count++ ))
				#display_board
				break
			else
				board[$k]="."
			fi
		fi
	done
}

#first computer will check for available corners
function take_available_corners()
{
	for (( l=1; l<=$TOTAL_CELL; l=$l+2 ))
	do
		if [[ $l == 5 ]]
		then
			l=$(( $l+2 ))
		fi
		if [[ ${board[$l]} == . ]]
		then
			board[$l]=$computer_symbol
			local center=1
			(( count++ ))
			break
		fi
	done
	take_center
}

#if corner is not free, computer will go with center
function take_center()
{
	if [[ $center -ne 1 ]]
	then
		local middle=$(( ($TOTAL_CELL + 1) / 2 ))
		if [[ ${board[middle]} == $computer_symbol ]]
		then
			(( count++ ))
		else
			take_available_sides
		fi
	fi
}

#if center is not free, computer places its symbol at any of the sides
function take_available_sides()
{
	for(( m=2; m<=8; m+=2 ))
	do
		if [[ ${board[$m]} == . ]]
		then
			board[$m]=$computer_symbol
			(( count++ ))
			break
		fi
	done
}

#this function will check the status of the game
function check_game_status()
{
	if [[ $winner == 1 ]]
	then
		if [[ $temp == $temp_computer ]]
		then
			echo "WINNER is PLAYER"
		else
			echo "WINNER is COMPUTER"
		fi
		#echo "Winner is $a"
		#echo "Winner is $turnChange"
		exit
	elif [[ $count -ge 9 ]]
	then
		echo "MATCH TIE"
	fi
}

function game()
{
	resetting_board
	check_symbol
	toss
	display_board

	while [[ $count -ne $TOTAL_CELL ]]
	do
		switch_player
		display_board
		#clear
		check_game_status
	done
}

game
