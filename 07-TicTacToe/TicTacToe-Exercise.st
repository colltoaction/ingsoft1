!classDefinition: #TicTacToeTest category: #'TicTacToe-Exercise'!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:38:39'!
test01_xStartsPlaying
	| game |
	game _ TicTacToe new.

	self assert: game isPlayingX.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 19:30:53'!
test02_oDoesntStartPlaying
	| game |
	game _ TicTacToe new.
	
	self deny: game isPlayingO.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 18:28:05'!
test03_gameIsNotOverAtStart
	| game |
	game _ TicTacToe new.
	
	self deny: game isOver.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 18:29:43'!
test04_gameIsNotTiedAtStart
	| game |
	game _ TicTacToe new.
	
	self deny: game isTied.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 19:31:02'!
test05_xHasntWonAtStart
	| game |
	game _ TicTacToe new.
	
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 19:31:10'!
test06_oHasntWonAtStart
	| game |
	game _ TicTacToe new.
	
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:38:29'!
test07_oPlaysAfterX
	| game |
	game _ self gameWithMovesAt: {1 @ 1}.

	self assert: game isPlayingO.
	self deny: game isPlayingX.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:38:20'!
test08_xPlaysAfterO
	| game |
	game _ self gameWithMovesAt: {1 @ 1. 1 @ 2}.

	self assert: game isPlayingX.
	self deny: game isPlayingO.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:38:13'!
test09_oCantPlayDuringXsTurn
	| game |
	game _ TicTacToe new.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe playOnInvalidTurnMessage.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:11:21'!
test10_xCantPlayDuringOsTurn
	| game |
	game _ self gameWithMovesAt: {1 @ 1}.

	self
		should: [ game markWithXAt: 1 @ 3 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe playOnInvalidTurnMessage.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:38:04'!
test11_cantPlayOnOccupiedPosition
	| game |
	game _ self gameWithMovesAt: {1 @ 1}.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe playOnInvalidPositionMessage.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 19:33:19'!
test12_cantPlayOutOfBounds
	| game |
	game _ TicTacToe new.

	self
		should: [ game markWithXAt: 1@0 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe playOnInvalidPositionMessage.
	self
		should: [ game markWithXAt: 4@1 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe playOnInvalidPositionMessage.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:34:00'!
test13_xWinsAtFirstRow
	| game |
	game _ self gameWhereXWinsAtFirstRow.

	self assertXWonGame: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:35:37'!
test14_oWinsAtSecondRow
	| game |
	game _ self gameWithMovesAt: {1 @ 1. 2 @ 1. 1 @ 2. 2 @ 2. 3 @ 3. 2 @ 3}.

	self assertOWonGame: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:35:50'!
test15_xWinsAtThirdColumn
	| game |
	game _ self gameWithMovesAt: {1 @ 3. 1 @ 2. 2 @ 3. 2 @ 2. 3 @ 3}.

	self assertXWonGame: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:36:00'!
test16_oWinsAtFirstColumn
	| game |
	game _ self gameWhereOWinsAtFirstColumn.

	self assertOWonGame: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:36:14'!
test17_xWinsAtDownDiagonal
	| game |
	game _ self gameWithMovesAt: {1 @ 1. 2 @ 1. 2 @ 2. 2 @ 3. 3 @ 3}.

	self assertXWonGame: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:36:27'!
test18_oWinsAtUpDiagonal
	| game |
	game _ self gameWithMovesAt: {1 @ 1. 3 @ 1. 2 @ 3. 2 @ 2. 3 @ 3. 1 @ 3}.

	self assertOWonGame: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:09:38'!
test19_gameIsTied
	| game |
	game _ self gameEndingInTie.

	self assert: game isOver.
	self assert: game isTied.
	self deny: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:39:23'!
test20_cantPlayAfterATieResult
	| game |
	game _ self gameEndingInTie.
	self assertPlayersCantPlayBecauseOfInvalidTurn: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:39:23'!
test21_cantPlayAfterXWins
	| game |
	game _ self gameWhereXWinsAtFirstRow.
	self assertPlayersCantPlayBecauseOfInvalidTurn: game.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 5/28/2018 22:39:23'!
test22_cantPlayAfterOWins
	| game |
	game _ self gameWhereOWinsAtFirstColumn.
	self assertPlayersCantPlayBecauseOfInvalidTurn: game.! !


!TicTacToeTest methodsFor: 'helper' stamp: 'MC 5/28/2018 22:35:28'!
assertOWonGame: game 
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'helper' stamp: 'MC 5/28/2018 22:39:23'!
assertPlayersCantPlayBecauseOfInvalidTurn: game
	self
		should: [ game markWithXAt: 1 @ 3 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe playOnInvalidTurnMessage.
	self
		should: [ game markWithOAt: 1 @ 3 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe playOnInvalidTurnMessage.! !

!TicTacToeTest methodsFor: 'helper' stamp: 'MC 5/28/2018 22:34:26'!
assertXWonGame: game 
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'helper' stamp: 'MC 5/28/2018 22:09:58'!
gameEndingInTie
	^self gameWithMovesAt: {1 @ 1. 1 @ 2. 1 @ 3. 2 @ 2. 2 @ 1. 2 @ 3. 3 @ 2. 3 @ 1. 3 @ 3}.! !

!TicTacToeTest methodsFor: 'helper' stamp: 'MC 5/28/2018 22:17:39'!
gameWhereOWinsAtFirstColumn
	^self gameWithMovesAt: {1 @ 3. 1 @ 1. 2 @ 3. 2 @ 1. 2 @ 2. 3 @ 1}.! !

!TicTacToeTest methodsFor: 'helper' stamp: 'MC 5/28/2018 22:15:36'!
gameWhereXWinsAtFirstRow
	^self gameWithMovesAt: {1 @ 1. 2 @ 1. 1 @ 2. 2 @ 2. 1 @ 3}.! !

!TicTacToeTest methodsFor: 'helper' stamp: 'MC 5/28/2018 21:58:16'!
gameWithMovesAt: positions
	| game |
	game _ TicTacToe new.
	(1 to: positions size) do: [ :i |
		i \\ 2 = 1
			ifTrue: [ game markWithXAt: (positions at: i) ]
			ifFalse: [ game markWithOAt: (positions at: i) ]].
	^ game.! !


!classDefinition: #TicTacToe category: #'TicTacToe-Exercise'!
Object subclass: #TicTacToe
	instanceVariableNames: 'board gameState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:10'!
hasPlayerOWon
	^gameState hasPlayerOWon.! !

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:14'!
hasPlayerXWon
	^gameState hasPlayerXWon.! !

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:11:57'!
initialize
	board _ TicTacToeBoard new.
	gameState _ TicTacToeGameStateTurnOfX new.! !

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:22'!
isOver
	^gameState isOver.! !

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:24'!
isPlayingO
	^gameState isPlayingO.! !

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:27'!
isPlayingX
	^gameState isPlayingX.! !

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:30'!
isTied
	^gameState isTied.! !


!TicTacToe methodsFor: 'playing' stamp: 'MC 5/28/2018 20:12:34'!
markWithOAt: aPosition
	gameState
		markWithOAt: aPosition
		on: board
		during: self.! !

!TicTacToe methodsFor: 'playing' stamp: 'MC 5/28/2018 20:12:37'!
markWithXAt: aPosition
	gameState
		markWithXAt: aPosition
		on: board
		during: self.! !


!TicTacToe methodsFor: 'turn handling' stamp: 'MC 5/28/2018 20:12:41'!
setState: aGameState 
	gameState _ aGameState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #'TicTacToe-Exercise'!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'error handling' stamp: 'MC 5/28/2018 19:13:28'!
playOnInvalidPositionMessage
	^'Invalid position'.! !

!TicTacToe class methodsFor: 'error handling' stamp: 'MC 5/28/2018 19:12:33'!
playOnInvalidTurnMessage
	^ 'Move on invalid turn'.! !


!classDefinition: #TicTacToeBoard category: #'TicTacToe-Exercise'!
Object subclass: #TicTacToeBoard
	instanceVariableNames: 'xs os'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeBoard methodsFor: 'playing' stamp: 'MC 5/28/2018 19:45:39'!
markWithOAt: aPosition
	self checkPositionIsValid: aPosition.
	os add: aPosition.! !

!TicTacToeBoard methodsFor: 'playing' stamp: 'MC 5/28/2018 19:45:46'!
markWithXAt: aPosition
	self checkPositionIsValid: aPosition.
	xs add: aPosition.! !


!TicTacToeBoard methodsFor: 'initializing' stamp: 'MC 5/28/2018 19:39:35'!
initialize
	xs _ Bag new.
	os _ Bag new.! !


!TicTacToeBoard methodsFor: 'validating' stamp: 'MC 5/28/2018 19:44:56'!
checkPositionIsValid: aPosition
	self checkPositionIsntOccupied: aPosition.
	self checkPositionIsntOutOfBounds: aPosition.! !

!TicTacToeBoard methodsFor: 'validating' stamp: 'MC 5/28/2018 19:28:49'!
checkPositionIsntOccupied: aPosition
	((xs includes: aPosition) or: [ os includes: aPosition ])
		ifTrue: [ self error: TicTacToe playOnInvalidPositionMessage ]! !

!TicTacToeBoard methodsFor: 'validating' stamp: 'MC 5/28/2018 19:43:32'!
checkPositionIsntOutOfBounds: aPosition
	| vaildXOrYs |
	
	vaildXOrYs _ (1 to: 3) asSet.
	(vaildXOrYs includesAllOf: (Bag with: aPosition x with: aPosition y))
		ifFalse: [ self error: TicTacToe playOnInvalidPositionMessage ].! !


!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:42:12'!
hasTicTacToe
	^#(#hasTicTacToeOnAnyRow #hasTicTacToeOnAnyColumn #hasTicTacToeOnAnyDiagonal)
		anySatisfy: [ :conditionMessage | self perform: conditionMessage ].! !

!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:31:30'!
hasTicTacToeOnAnyColumn
	^(self hasTicTacToeOnAnyColumnFor: xs) or: [ self hasTicTacToeOnAnyColumnFor: os ]! !

!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:35:00'!
hasTicTacToeOnAnyColumnFor: positionsOfPlayer
	^(1 to: 3) anySatisfy: [ :y | (1 to: 3) allSatisfy: [ :x | positionsOfPlayer includes: x@y ] ]! !

!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:46:22'!
hasTicTacToeOnAnyDiagonal
	^(self hasTicTacToeOnAnyDiagonalFor: xs) or: [ self hasTicTacToeOnAnyDiagonalFor: os ].! !

!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 22:19:17'!
hasTicTacToeOnAnyDiagonalFor: positionsOfPlayer
	^(Bag
		with: {1@1. 2@2. 3@3}
		with: {1@3. 2@2. 3@1}
	) anySatisfy: [ :diagonal | positionsOfPlayer includesAllOf: diagonal ].! !

!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:21:27'!
hasTicTacToeOnAnyRow
	^(self hasTicTacToeOnAnyRowFor: xs) or: [ self hasTicTacToeOnAnyRowFor: os ]! !

!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:28:43'!
hasTicTacToeOnAnyRowFor: positionsOfPlayer
	^(1 to: 3) anySatisfy: [ :x | (1 to: 3) allSatisfy: [ :y | positionsOfPlayer includes: x@y ] ]! !

!TicTacToeBoard methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:56:12'!
isComplete
	^xs size = 5! !


!classDefinition: #TicTacToeGameState category: #'TicTacToe-Exercise'!
Object subclass: #TicTacToeGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeGameState methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:54:51'!
hasPlayerOWon
	self subclassResponsibility ! !

!TicTacToeGameState methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:54:53'!
hasPlayerXWon
	self subclassResponsibility ! !

!TicTacToeGameState methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:54:29'!
isOver
	self subclassResponsibility ! !

!TicTacToeGameState methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:54:23'!
isPlayingO
	self subclassResponsibility ! !

!TicTacToeGameState methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:53:15'!
isPlayingX
	self subclassResponsibility ! !

!TicTacToeGameState methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:54:32'!
isTied
	self subclassResponsibility ! !


!TicTacToeGameState methodsFor: 'playing' stamp: 'MC 5/28/2018 20:07:19'!
markWithOAt: aPosition on: aBoard during: aGame
	self subclassResponsibility.! !

!TicTacToeGameState methodsFor: 'playing' stamp: 'MC 5/28/2018 20:07:09'!
markWithXAt: aPosition on: aBoard during: aGame
	self subclassResponsibility.! !


!classDefinition: #TicTacToeGameStateOWon category: #'TicTacToe-Exercise'!
TicTacToeGameState subclass: #TicTacToeGameStateOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeGameStateOWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:25:57'!
hasPlayerOWon
	^true.! !

!TicTacToeGameStateOWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:26:07'!
hasPlayerXWon
	^false.! !

!TicTacToeGameStateOWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:25:34'!
isOver
	^true.! !

!TicTacToeGameStateOWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:47:26'!
isPlayingO
	^false.! !

!TicTacToeGameStateOWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:47:28'!
isPlayingX
	^false.! !

!TicTacToeGameStateOWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:25:44'!
isTied
	^false.! !


!TicTacToeGameStateOWon methodsFor: 'playing' stamp: 'MC 5/28/2018 21:46:54'!
markWithOAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !

!TicTacToeGameStateOWon methodsFor: 'playing' stamp: 'MC 5/28/2018 21:47:01'!
markWithXAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !


!classDefinition: #TicTacToeGameStateTied category: #'TicTacToe-Exercise'!
TicTacToeGameState subclass: #TicTacToeGameStateTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeGameStateTied methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:57:06'!
hasPlayerOWon
	^false.! !

!TicTacToeGameStateTied methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:57:14'!
hasPlayerXWon
	^false.! !

!TicTacToeGameStateTied methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:56:39'!
isOver
	^true.! !

!TicTacToeGameStateTied methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:56:52'!
isTied
	^true.! !


!TicTacToeGameStateTied methodsFor: 'playing' stamp: 'MC 5/28/2018 22:14:33'!
markWithOAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !

!TicTacToeGameStateTied methodsFor: 'playing' stamp: 'MC 5/28/2018 22:14:16'!
markWithXAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !


!classDefinition: #TicTacToeGameStateTurnOfO category: #'TicTacToe-Exercise'!
TicTacToeGameState subclass: #TicTacToeGameStateTurnOfO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeGameStateTurnOfO methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:00:42'!
hasPlayerOWon
	^false.! !

!TicTacToeGameStateTurnOfO methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:00:25'!
hasPlayerXWon
	^false.! !

!TicTacToeGameStateTurnOfO methodsFor: 'inspecting' stamp: 'MC 5/28/2018 19:51:21'!
isOver
	^false.! !

!TicTacToeGameStateTurnOfO methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:48:43'!
isPlayingO
	^true.! !

!TicTacToeGameStateTurnOfO methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:54:08'!
isPlayingX
	^false.! !

!TicTacToeGameStateTurnOfO methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:00:02'!
isTied
	^false.! !


!TicTacToeGameStateTurnOfO methodsFor: 'playing' stamp: 'MC 5/28/2018 20:08:52'!
markWithOAt: aPosition on: aBoard during: aGame
	aBoard markWithOAt: aPosition.
	(aBoard hasTicTacToe)
		ifTrue: [ aGame setState: TicTacToeGameStateOWon new ]
		ifFalse: [ aGame setState: TicTacToeGameStateTurnOfX new ].! !

!TicTacToeGameStateTurnOfO methodsFor: 'playing' stamp: 'MC 5/28/2018 20:06:36'!
markWithXAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !


!classDefinition: #TicTacToeGameStateTurnOfX category: #'TicTacToe-Exercise'!
TicTacToeGameState subclass: #TicTacToeGameStateTurnOfX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeGameStateTurnOfX methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:48:31'!
hasPlayerOWon
	^false.! !

!TicTacToeGameStateTurnOfX methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:48:21'!
hasPlayerXWon
	^false.! !

!TicTacToeGameStateTurnOfX methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:47:08'!
isOver
	^false.! !

!TicTacToeGameStateTurnOfX methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:46:55'!
isPlayingO
	^false.! !

!TicTacToeGameStateTurnOfX methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:53:42'!
isPlayingX
	^true.! !

!TicTacToeGameStateTurnOfX methodsFor: 'inspecting' stamp: 'MC 5/28/2018 18:47:54'!
isTied
	^false.! !


!TicTacToeGameStateTurnOfX methodsFor: 'playing' stamp: 'MC 5/28/2018 20:06:05'!
markWithOAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !

!TicTacToeGameStateTurnOfX methodsFor: 'playing' stamp: 'MC 5/28/2018 21:52:56'!
markWithXAt: aPosition on: aBoard during: aGame
	aBoard markWithXAt: aPosition.
	(aBoard hasTicTacToe)
		ifTrue: [ aGame setState: TicTacToeGameStateXWon new ]
		ifFalse: [
			(aBoard isComplete)
				ifTrue: [ aGame setState: TicTacToeGameStateTied new ]
				ifFalse: [ aGame setState: TicTacToeGameStateTurnOfO new ] ].! !


!classDefinition: #TicTacToeGameStateXWon category: #'TicTacToe-Exercise'!
TicTacToeGameState subclass: #TicTacToeGameStateXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeGameStateXWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:18:25'!
hasPlayerOWon
	^false.! !

!TicTacToeGameStateXWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:18:13'!
hasPlayerXWon
	^true.! !

!TicTacToeGameStateXWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:17:39'!
isOver
	^true.! !

!TicTacToeGameStateXWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:47:37'!
isPlayingO
	^false.! !

!TicTacToeGameStateXWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 21:47:34'!
isPlayingX
	^false.! !

!TicTacToeGameStateXWon methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:17:54'!
isTied
	^false.! !


!TicTacToeGameStateXWon methodsFor: 'playing' stamp: 'MC 5/28/2018 21:46:39'!
markWithOAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !

!TicTacToeGameStateXWon methodsFor: 'playing' stamp: 'MC 5/28/2018 21:46:42'!
markWithXAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !
