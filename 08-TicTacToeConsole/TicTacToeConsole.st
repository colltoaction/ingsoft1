!classDefinition: #TicTacToeTest category: #TicTacToeConsole!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

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

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 6/2/2018 12:05:03'!
test23_lastPlayOfNewGameThrowsException
	| game |
	game _ TicTacToe new.
	
	self
		should: [ game lastPlay ]
		raise: Error - MessageNotUnderstood
		withMessageText: TicTacToe lastPlayNotAvailable.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 6/2/2018 12:13:20'!
test24_lastPlayAfterFirstPlay
	| game |
	game _ self gameWithMovesAt: { 1@1 }.
	
	self assert: game lastPlay player equals: 'X'.
	self assert: game lastPlay position equals: 1@1.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MC 6/2/2018 12:15:10'!
test25_lastPlayAfterOWins
	| game |
	game _ self gameWhereOWinsAtFirstColumn.
	
	self assert: game lastPlay player equals: 'O'.
	self assert: game lastPlay position equals: 3@1.! !


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


!classDefinition: #TicTacToeViewTest category: #TicTacToeConsole!
TestCase subclass: #TicTacToeViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeViewTest methodsFor: 'scenario' stamp: 'MC 6/2/2018 14:03:19'!
aFirstPlayOn: aTicTacToe
	aTicTacToe markWithXAt: 2@2.! !

!TicTacToeViewTest methodsFor: 'scenario' stamp: 'MC 6/2/2018 14:57:18'!
multiplePlaysOn: aTicTacToe
	aTicTacToe markWithXAt: 2@2.
	aTicTacToe markWithOAt: 1@1.
	aTicTacToe markWithXAt: 1@3.! !

!TicTacToeViewTest methodsFor: 'scenario' stamp: 'MC 6/2/2018 14:59:35'!
oPlaysAndWinsOn: aTicTacToe
	aTicTacToe markWithXAt: 2@2.
	aTicTacToe markWithOAt: 1@1.
	aTicTacToe markWithXAt: 2@3.
	aTicTacToe markWithOAt: 1@2.
	aTicTacToe markWithXAt: 3@3.
	aTicTacToe markWithOAt: 1@3.! !

!TicTacToeViewTest methodsFor: 'scenario' stamp: 'MC 6/2/2018 15:02:33'!
playAndTieOn: aTicTacToe
	aTicTacToe markWithXAt: 1@1.
	aTicTacToe markWithOAt: 1@2.
	aTicTacToe markWithXAt: 1@3.
	aTicTacToe markWithOAt: 2@2.
	aTicTacToe markWithXAt: 2@1.
	aTicTacToe markWithOAt: 2@3.
	aTicTacToe markWithXAt: 3@2.
	aTicTacToe markWithOAt: 3@1.
	aTicTacToe markWithXAt: 3@3.! !

!TicTacToeViewTest methodsFor: 'scenario' stamp: 'MC 6/2/2018 15:00:01'!
xPlaysAndWinsOn: aTicTacToe
	aTicTacToe markWithXAt: 2@2.
	aTicTacToe markWithOAt: 1@1.
	aTicTacToe markWithXAt: 1@3.
	aTicTacToe markWithOAt: 1@2.
	aTicTacToe markWithXAt: 3@1.! !


!classDefinition: #TicTacToeLogTest category: #TicTacToeConsole!
TicTacToeViewTest subclass: #TicTacToeLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MC 6/2/2018 12:19:51'!
test01_logIsEmptyBeforePlaying
	| game log |
	game _ TicTacToe	 new.
	log _ TicTacToeLog of: game.
	
	self assert: log asText equals: ''.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MC 6/2/2018 14:02:56'!
test02_logRecordsFirstPlay
	| game log |
	game _ TicTacToe	 new.
	log _ TicTacToeLog of: game.
	
	self aFirstPlayOn: game.
	
	self assert: log asText equals: 
		'X marcó en 2@2', String newLineString,
		'Estado: Jugando O'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MC 6/2/2018 14:57:38'!
test03_logRecordsMultiplePlays
	| game log |
	game _ TicTacToe	 new.
	log _ TicTacToeLog of: game.

	self multiplePlaysOn: game.
	
	self assert: log asText equals: 
		'X marcó en 2@2', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 1@1', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 1@3', String newLineString,
		'Estado: Jugando O'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MC 6/2/2018 14:58:01'!
test04_logRecordsWinOfX
	| game log |
	game _ TicTacToe	 new.
	log _ TicTacToeLog of: game.

	self xPlaysAndWinsOn: game.

	self assert: log asText equals:
		'X marcó en 2@2', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 1@1', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 1@3', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 1@2', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 3@1', String newLineString,
		'Estado: Juego terminado - Ganó X!!'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MC 6/2/2018 14:59:09'!
test05_logRecordsWinOfO
	| game log |
	game _ TicTacToe	 new.
	log _ TicTacToeLog of: game.

	self oPlaysAndWinsOn: game.

	self assert: log asText equals:
		'X marcó en 2@2', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 1@1', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 2@3', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 1@2', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 3@3', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 1@3', String newLineString,
		'Estado: Juego terminado - Ganó O!!'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MC 6/2/2018 15:01:52'!
test06_logRecordsTie
	| game log |
	game _ TicTacToe	 new.
	log _ TicTacToeLog of: game.

	self playAndTieOn: game.

	self assert: log asText equals:
		'X marcó en 1@1', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 1@2', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 1@3', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 2@2', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 2@1', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 2@3', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 3@2', String newLineString,
		'Estado: Jugando O', String newLineString,
		'O marcó en 3@1', String newLineString,
		'Estado: Jugando X', String newLineString,
		'X marcó en 3@3', String newLineString,
		'Estado: Juego terminado - Empate!!'.! !


!classDefinition: #TicTacToeMatrixViewTest category: #TicTacToeConsole!
TicTacToeViewTest subclass: #TicTacToeMatrixViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeMatrixViewTest methodsFor: 'testing' stamp: 'MC 6/2/2018 13:56:37'!
test01_viewOfNewGameIsAnEmptyMatrix
	| game view |
	game _ TicTacToe new.
	view _ TicTacToeMatrixView of: game.
	self
		assert: view asText
		equals: ' | | ' , String newLineString , '-----' , String newLineString , ' | | ' , String newLineString , '-----' , String newLineString , ' | | '.! !

!TicTacToeMatrixViewTest methodsFor: 'testing' stamp: 'MC 6/2/2018 15:08:03'!
test02_viewWithOneX
	| game view |
	game _ TicTacToe new.
	view _ TicTacToeMatrixView of: game.

	self aFirstPlayOn: game.

	self
		assert: view asText
		equals:
		' | | ' , String newLineString ,
		'-----' , String newLineString ,
		' |X| ' , String newLineString ,
		'-----' , String newLineString ,
		' | | '.! !

!TicTacToeMatrixViewTest methodsFor: 'testing' stamp: 'MC 6/2/2018 15:06:34'!
test03_viewWithMultiplePlays
	| game view |
	game _ TicTacToe new.
	view _ TicTacToeMatrixView of: game.

	self multiplePlaysOn: game.

	self
		assert: view asText
		equals:
		'O| |X' , String newLineString ,
		'-----' , String newLineString ,
		' |X| ' , String newLineString ,
		'-----' , String newLineString ,
		' | | '.! !

!TicTacToeMatrixViewTest methodsFor: 'testing' stamp: 'MC 6/2/2018 15:09:21'!
test04_viewWhereXWins
	| game view |
	game _ TicTacToe new.
	view _ TicTacToeMatrixView of: game.

	self xPlaysAndWinsOn: game.

	self
		assert: view asText
		equals:
		'O|O|X' , String newLineString ,
		'-----' , String newLineString ,
		' |X| ' , String newLineString ,
		'-----' , String newLineString ,
		'X| | '.! !

!TicTacToeMatrixViewTest methodsFor: 'testing' stamp: 'MC 6/2/2018 15:10:23'!
test05_viewWhereOWins
	| game view |
	game _ TicTacToe new.
	view _ TicTacToeMatrixView of: game.

	self oPlaysAndWinsOn: game.

	self
		assert: view asText
		equals:
		'O|O|O' , String newLineString ,
		'-----' , String newLineString ,
		' |X|X' , String newLineString ,
		'-----' , String newLineString ,
		' | |X'.! !

!TicTacToeMatrixViewTest methodsFor: 'testing' stamp: 'MC 6/2/2018 15:12:13'!
test06_viewWherePlayersTie
	| game view |
	game _ TicTacToe new.
	view _ TicTacToeMatrixView of: game.

	self playAndTieOn: game.

	self
		assert: view asText
		equals:
		'X|O|X' , String newLineString ,
		'-----' , String newLineString ,
		'X|O|O' , String newLineString ,
		'-----' , String newLineString ,
		'O|X|X'.! !


!classDefinition: #TicTacToe category: #TicTacToeConsole!
Object subclass: #TicTacToe
	instanceVariableNames: 'board gameState lastPlay subscribers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:10'!
hasPlayerOWon
	^gameState hasPlayerOWon.! !

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 5/28/2018 20:12:14'!
hasPlayerXWon
	^gameState hasPlayerXWon.! !

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

!TicTacToe methodsFor: 'inspecting' stamp: 'MC 6/2/2018 12:10:22'!
lastPlay
	lastPlay ifNil: [
		self error: TicTacToe lastPlayNotAvailable.
	].
	^lastPlay.! !


!TicTacToe methodsFor: 'playing' stamp: 'MC 6/2/2018 15:37:54'!
markWithOAt: aPosition
	gameState
		markWithOAt: aPosition
		on: board
		during: self.! !

!TicTacToe methodsFor: 'playing' stamp: 'MC 6/2/2018 15:37:48'!
markWithXAt: aPosition
	gameState
		markWithXAt: aPosition
		on: board
		during: self.! !


!TicTacToe methodsFor: 'turn handling' stamp: 'MC 6/2/2018 15:42:20'!
setState: aGameState forPlay: play
	gameState _ aGameState.
	lastPlay _ play.
	self notifySubscribers! !


!TicTacToe methodsFor: 'events' stamp: 'MC 6/2/2018 15:42:14'!
notifySubscribers
	subscribers do: [ :subscriber | subscriber ticTacToeUpdated ].! !

!TicTacToe methodsFor: 'events' stamp: 'MC 6/2/2018 12:34:54'!
subscribe: aSubscriber
	subscribers add: aSubscriber.! !


!TicTacToe methodsFor: 'initializing' stamp: 'MC 6/2/2018 12:35:15'!
initialize
	board _ TicTacToeBoard new.
	gameState _ TicTacToeGameStateTurnOfX new.
	subscribers _ Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToeConsole!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'error handling' stamp: 'MC 6/2/2018 12:06:01'!
lastPlayNotAvailable
	^'Cannot ask for last play before first move'.! !

!TicTacToe class methodsFor: 'error handling' stamp: 'MC 5/28/2018 19:13:28'!
playOnInvalidPositionMessage
	^'Invalid position'.! !

!TicTacToe class methodsFor: 'error handling' stamp: 'MC 5/28/2018 19:12:33'!
playOnInvalidTurnMessage
	^ 'Move on invalid turn'.! !


!classDefinition: #TicTacToeBoard category: #TicTacToeConsole!
Object subclass: #TicTacToeBoard
	instanceVariableNames: 'xs os'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeBoard methodsFor: 'playing' stamp: 'MC 6/2/2018 15:39:14'!
markWithOAt: aPosition
	self checkPositionIsValid: aPosition.
	os add: aPosition.
	^TicTacToePlay of: 'O' at: aPosition.! !

!TicTacToeBoard methodsFor: 'playing' stamp: 'MC 6/2/2018 15:39:23'!
markWithXAt: aPosition
	self checkPositionIsValid: aPosition.
	xs add: aPosition.
	^TicTacToePlay of: 'X' at: aPosition.! !


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


!classDefinition: #TicTacToeGameState category: #TicTacToeConsole!
Object subclass: #TicTacToeGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

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


!classDefinition: #TicTacToeGameStateOWon category: #TicTacToeConsole!
TicTacToeGameState subclass: #TicTacToeGameStateOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

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


!classDefinition: #TicTacToeGameStateTied category: #TicTacToeConsole!
TicTacToeGameState subclass: #TicTacToeGameStateTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

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


!classDefinition: #TicTacToeGameStateTurnOfO category: #TicTacToeConsole!
TicTacToeGameState subclass: #TicTacToeGameStateTurnOfO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

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


!TicTacToeGameStateTurnOfO methodsFor: 'playing' stamp: 'MC 6/2/2018 15:41:01'!
markWithOAt: aPosition on: aBoard during: aGame
	| play |
	play _ aBoard markWithOAt: aPosition.

	(aBoard hasTicTacToe)
		ifTrue: [ aGame setState: TicTacToeGameStateOWon new forPlay: play ]
		ifFalse: [ aGame setState: TicTacToeGameStateTurnOfX new forPlay: play ].! !

!TicTacToeGameStateTurnOfO methodsFor: 'playing' stamp: 'MC 5/28/2018 20:06:36'!
markWithXAt: aPosition on: aBoard during: aGame
	self error: TicTacToe playOnInvalidTurnMessage.! !


!classDefinition: #TicTacToeGameStateTurnOfX category: #TicTacToeConsole!
TicTacToeGameState subclass: #TicTacToeGameStateTurnOfX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

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

!TicTacToeGameStateTurnOfX methodsFor: 'playing' stamp: 'MC 6/2/2018 15:40:32'!
markWithXAt: aPosition on: aBoard during: aGame
	| play |
	play _ aBoard markWithXAt: aPosition.

	(aBoard hasTicTacToe)
		ifTrue: [ aGame setState: TicTacToeGameStateXWon new forPlay: play]
		ifFalse: [
			(aBoard isComplete)
				ifTrue: [ aGame setState: TicTacToeGameStateTied new forPlay: play ]
				ifFalse: [ aGame setState: TicTacToeGameStateTurnOfO new forPlay: play ] ].! !


!classDefinition: #TicTacToeGameStateXWon category: #TicTacToeConsole!
TicTacToeGameState subclass: #TicTacToeGameStateXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

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


!classDefinition: #TicTacToePlay category: #TicTacToeConsole!
Object subclass: #TicTacToePlay
	instanceVariableNames: 'player position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToePlay methodsFor: 'initialize' stamp: 'MC 6/2/2018 12:00:35'!
withPlayer: aPlayer withPosition: aPosition
	player _ aPlayer.
	position _ aPosition.! !


!TicTacToePlay methodsFor: 'inspecting' stamp: 'MC 6/2/2018 12:13:42'!
player
	^player! !

!TicTacToePlay methodsFor: 'inspecting' stamp: 'MC 6/2/2018 12:14:06'!
position
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToePlay class' category: #TicTacToeConsole!
TicTacToePlay class
	instanceVariableNames: ''!

!TicTacToePlay class methodsFor: 'instance creation' stamp: 'MC 6/2/2018 11:59:52'!
of: aPlayer at: aPosition
	^self new withPlayer: aPlayer withPosition: aPosition.! !


!classDefinition: #TicTacToeView category: #TicTacToeConsole!
Object subclass: #TicTacToeView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeView methodsFor: 'events' stamp: 'MC 6/2/2018 15:13:48'!
ticTacToeUpdated
	self subclassResponsibility.! !


!classDefinition: #TicTacToeLog category: #TicTacToeConsole!
TicTacToeView subclass: #TicTacToeLog
	instanceVariableNames: 'entries game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeLog methodsFor: 'initializing' stamp: 'MC 6/2/2018 12:38:06'!
with: aTicTacToe 
	entries _ OrderedCollection new.
	game _ aTicTacToe.
	game subscribe: self.! !


!TicTacToeLog methodsFor: 'events' stamp: 'MC 6/2/2018 12:53:44'!
ticTacToeUpdated
	| entry gameStateText lastPlayText |
	entry _ game lastPlay.
	lastPlayText _ entry player , ' marcó en ' , entry position asString.
	gameStateText _ 'Estado: ' , self textForGameState.
	entries
		add: lastPlayText;
		add: gameStateText.! !


!TicTacToeLog methodsFor: 'printing' stamp: 'MC 6/2/2018 13:15:45'!
asText
	^(entries inject: '' into: [ :text :entry | text, String newLineString, entry ]) withBlanksTrimmed.! !

!TicTacToeLog methodsFor: 'printing' stamp: 'MC 6/2/2018 13:31:57'!
textForGameState
	game isTied ifTrue: [
		^'Juego terminado - Empate!!'.
	].
	game hasPlayerXWon ifTrue: [
		^'Juego terminado - Ganó X!!'.
	].
	game hasPlayerOWon ifTrue: [
		^'Juego terminado - Ganó O!!'.
	].
	game isPlayingX ifTrue: [
		^'Jugando X'.
	].
	^'Jugando O'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeLog class' category: #TicTacToeConsole!
TicTacToeLog class
	instanceVariableNames: ''!

!TicTacToeLog class methodsFor: 'instance creation' stamp: 'MC 6/2/2018 12:39:53'!
of: aTicTacToe 
	^self new with: aTicTacToe.! !


!classDefinition: #TicTacToeMatrixView category: #TicTacToeConsole!
TicTacToeView subclass: #TicTacToeMatrixView
	instanceVariableNames: 'game matrix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeMatrixView methodsFor: 'initializing' stamp: 'MC 6/2/2018 15:25:30'!
with: aTicTacToe
	matrix _ Dictionary new.
	game _ aTicTacToe.
	game subscribe: self.! !


!TicTacToeMatrixView methodsFor: 'printing' stamp: 'MC 6/2/2018 15:25:23'!
asText
	^(self playerSymbolAt: 1@1), '|',
	(self playerSymbolAt: 1@2), '|',
	(self playerSymbolAt: 1@3), String newLineString,
	'-----',String newLineString,
	(self playerSymbolAt: 2@1), '|',
	(self playerSymbolAt: 2@2), '|',
	(self playerSymbolAt: 2@3), String newLineString,
	'-----',String newLineString,
	(self playerSymbolAt: 3@1), '|',
	(self playerSymbolAt: 3@2), '|',
	(self playerSymbolAt: 3@3).! !

!TicTacToeMatrixView methodsFor: 'printing' stamp: 'MC 6/2/2018 15:24:31'!
playerSymbolAt: position
	^matrix at: position ifAbsent: ' '.! !


!TicTacToeMatrixView methodsFor: 'events' stamp: 'MC 6/2/2018 13:51:04'!
ticTacToeUpdated
	| entry |
	entry _ game lastPlay.
	matrix
		at: entry position
		put: entry player.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeMatrixView class' category: #TicTacToeConsole!
TicTacToeMatrixView class
	instanceVariableNames: ''!

!TicTacToeMatrixView class methodsFor: 'instance creation' stamp: 'MC 6/2/2018 13:37:39'!
of: aTicTacToe 
	^self new with: aTicTacToe.! !
