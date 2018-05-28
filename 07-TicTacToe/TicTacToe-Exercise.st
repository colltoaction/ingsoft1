!classDefinition: #TicTacToeTest category: #'TicTacToe-Exercise'!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 09:59:04'!
test01

	|game|
	
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:33:28'!
test02

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.
	
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:33:34'!
test03

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: 1 equals: game Os size.
	self assert: (game Os includes: 2@2).
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:34:45'!
test04

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	
	self
	should: [game markWithXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
		].
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:35:06'!
test05

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	self
	should: [game markWithOAt: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:35:19'!
test06

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	self
	should: [game markWithXAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:35:34'!
test07

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	self
	should: [game markWithXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:35:39'!
test08

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	self
	should: [game markWithOAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert:  game Os isEmpty.

		].
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:35:51'!
test09

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	game markWithXAt: 3@3.
	self
	should: [game markWithOAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 3@3).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		
		].
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test10
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 3 @ 3.
	self deny: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test11
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 1 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test12
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test13
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 3 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test14
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 3 @ 1.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test15
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 3 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test16
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 1 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test17
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 1 @ 3.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:38:12'!
test18

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 1@1.	
	game markWithOAt: 2@1.
	game markWithXAt: 1@2.
	game markWithOAt: 3@1.	
	game markWithXAt: 1@3.

	self 
		should: [ game markWithOAt: 3@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:38:51'!
test19

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.	
	game markWithXAt: 2@1.
	game markWithOAt: 1@2.
	game markWithXAt: 3@1.	
	game markWithOAt: 1@3.

	self 
		should: [ game markWithXAt: 3@2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game Xs size.
			self assert: (game Xs includes: 2@2).
			self assert: (game Xs includes: 2@1).
			self assert: (game Xs includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test20
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 2.
	game markWithXAt: 3 @ 3.
	self assert: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
test21
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 3 @ 3.
	self assert: game isOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.! !


!classDefinition: #TicTacToe category: #'TicTacToe-Exercise'!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs turn winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Exercise'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:51:23'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:56:21'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
hasPlayerOWon
	^ winner = #o.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:04'!
hasPlayerXWon
	^ winner = #x.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:02:13'!
hasUpDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:01:53'!
hasWin: positions

	^(self hasCompletedRow: positions)
		or: [(self hasCompletedColumn: positions) 
				or: [(self hasDownDiagonal: positions)
					or: [(self hasUpDiagonal: positions)]]]


! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:22:35'!
initialize
	
	xs:= Set new.
	os:= Set new.
	
	turn:= #x.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:17:25'!
isGameOver
	
	^winner = #x or: [ winner = #o ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:28'!
isOver
	^ self hasPlayerXWon or: [
		self hasPlayerOWon or: [ self isTied ]].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:41:05'!
isTied
	^ xs size = 5 and: [
		os size = 4 and: [ self hasPlayerXWon not ]
		" and: [ self YHasWon not ]]]" ].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:32:58'!
markWithOAt: aPosition
	self isGameOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #o ifFalse: [ self error: self class notXTurnErrorMessage ].
	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	os add: aPosition.
	(self hasWin: os) ifTrue: [ ^ winner _ #o ].
	turn _ #x.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MC 5/28/2018 17:32:16'!
markWithXAt: aPosition
	self isGameOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #x ifFalse: [ self error: self class notXTurnErrorMessage ].
	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	xs add: aPosition.
	(self hasWin: xs) ifTrue: [ ^ winner _ #x ].
	turn _ #o.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #'TicTacToe-Exercise'!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:15:31'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:26:38'!
notXTurnErrorMessage

	^'Not X turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !
