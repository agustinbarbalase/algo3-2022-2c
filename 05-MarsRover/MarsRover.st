!classDefinition: #TestMarsRover category: 'MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'assertions' stamp: 'AB 10/29/2022 17:56:30'!
assertTheCommandsSequence: aStringOfCommnads produceThePosition: aPoint andTheCardinalPoint: aCardinalPoint
	marsRover executeCommands: aStringOfCommnads.
	self assert: aPoint equals: (marsRover position).
	self assert: aCardinalPoint equals: (marsRover cardinalPoint)! !


!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 18:01:28'!
setUp
	marsRover := MarsRover initializeWithThePosition: (1 @ 3) andTheCardinalPoint: 'N'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 17:57:16'!
test01AEmptyCommandIsValid
	self assertTheCommandsSequence: '' produceThePosition: (1 @ 3) andTheCardinalPoint: 'N'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 17:58:31'!
test02TheCommandForwardChangesThePosition
	self assertTheCommandsSequence: 'f' produceThePosition: (1 @ 4) andTheCardinalPoint: 'N'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 17:58:48'!
test03TheCommandBackwardChangesThePosition
	self assertTheCommandsSequence: 'b' produceThePosition: (1 @ 2) andTheCardinalPoint: 'N'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 17:59:08'!
test04TheCommandLeftChangesTheOrientation
	self assertTheCommandsSequence: 'l' produceThePosition: (1 @ 3) andTheCardinalPoint: 'W'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 17:59:28'!
test05TheCommandRightChangesTheOrientation
	self assertTheCommandsSequence: 'r' produceThePosition: (1 @ 3) andTheCardinalPoint: 'E'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 17:59:52'!
test06ACombinationOfCommandsChangesTheOrientation
	self assertTheCommandsSequence: 'rrl' produceThePosition: (1 @ 3) andTheCardinalPoint: 'E'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 18:00:22'!
test07WhenChangeTheOrientationTheChangeOfPositionIsDifferent
	self assertTheCommandsSequence: 'lf' produceThePosition: (0 @ 3) andTheCardinalPoint: 'W'.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AB 10/29/2022 17:51:41'!
test08AWrongCommandRaiseAnError
	self should: [marsRover executeCommands: 'lfñbr'] 
		raise: Error  
		withExceptionDo: [:anError | self assert: (MarsRover commandInvalidErrorDescription) equals: (anError messageText)].
	self assert: (0 @ 3) equals: (marsRover position).
	self assert: 'W' equals: (marsRover cardinalPoint).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position cardinalPoint listOfCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'AB 10/29/2022 18:38:48'!
initializeCommands
	listOfCommands := Dictionary new.
	
	listOfCommands add: $r->[(cardinalPoint := (MarsRoverPosition initializeWithThePosition: position andCardinalPoint: cardinalPoint) rotateToRight)].
	listOfCommands add: $l->[(cardinalPoint := (MarsRoverPosition initializeWithThePosition: position andCardinalPoint: cardinalPoint) rotateToLeft)].
	listOfCommands add: $b->[(position := (MarsRoverPosition initializeWithThePosition: position andCardinalPoint: cardinalPoint) backward)].
	listOfCommands add: $f->[(position := (MarsRoverPosition initializeWithThePosition: position andCardinalPoint: cardinalPoint) forward)].! !

!MarsRover methodsFor: 'initialization' stamp: 'AB 10/29/2022 18:34:49'!
initializeInitializeWithThePosition: aPoint andTheCardinalPoint: aCardinalPoint 
	position := aPoint.
	cardinalPoint := aCardinalPoint.
	self initializeCommands.! !


!MarsRover methodsFor: 'commands' stamp: 'AB 10/29/2022 18:39:01'!
executeCommand: aCommand
	(listOfCommands includesKey: aCommand) ifFalse: [^self error: (self class commandInvalidErrorDescription)].
	(listOfCommands at: aCommand) value.! !

!MarsRover methodsFor: 'commands' stamp: 'AB 10/29/2022 18:23:32'!
executeCommands: aStringOfCommands
	aStringOfCommands do: [:aCommand | self executeCommand: aCommand].! !


!MarsRover methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:27:07'!
cardinalPoint
	^cardinalPoint asString.! !

!MarsRover methodsFor: 'atributes' stamp: 'AB 10/29/2022 12:31:45'!
position
	^position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 16:40:45'!
initializeWithThePosition: aPoint andTheCardinalPoint: aCardinalPoint 
	^self new 
		initializeInitializeWithThePosition: aPoint 
		andTheCardinalPoint: (MarsRoverCardinalPoint initializeWith: aCardinalPoint). ! !


!MarsRover class methodsFor: 'error description' stamp: 'AB 10/29/2022 15:58:07'!
commandInvalidErrorDescription
	^'Command Invalid'! !


!classDefinition: #MarsRoverCardinalPoint category: 'MarsRover'!
Object subclass: #MarsRoverCardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCardinalPoint methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:28:11'!
asString
	self subclassResponsibility.! !

!MarsRoverCardinalPoint methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:20:43'!
direction
	self subclassResponsibility.! !


!MarsRoverCardinalPoint methodsFor: 'movements' stamp: 'AB 10/29/2022 16:08:19'!
rotateToLeft
	self subclassResponsibility.! !

!MarsRoverCardinalPoint methodsFor: 'movements' stamp: 'AB 10/29/2022 16:08:30'!
rotateToRight
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCardinalPoint class' category: 'MarsRover'!
MarsRoverCardinalPoint class
	instanceVariableNames: ''!

!MarsRoverCardinalPoint class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 16:15:53'!
initializeWith: aCardinalPoint
	self subclasses detect: [:aSubclass | aSubclass isYourCategory: aCardinalPoint] 
		ifFound: [:aFoundClass | ^(aFoundClass new)] 
		ifNone: [^self error: (self thisCardinalPointDoesntExistsErrorDescription)].! !

!MarsRoverCardinalPoint class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 16:16:53'!
isYourCategory
	self subclassResponsibility.! !


!MarsRoverCardinalPoint class methodsFor: 'error descriptions' stamp: 'AB 10/29/2022 16:16:28'!
thisCardinalPointDoesntExistsErrorDescription
	^'This cardinal point doesn`t exists'! !


!classDefinition: #East category: 'MarsRover'!
MarsRoverCardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'movements' stamp: 'AB 10/29/2022 16:06:30'!
rotateToLeft
	^North new.! !

!East methodsFor: 'movements' stamp: 'AB 10/29/2022 16:06:35'!
rotateToRight
	^South new.! !


!East methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:27:25'!
asString
	^'E'! !

!East methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:19:23'!
direction
	^(1 @ 0).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 16:17:20'!
isYourCategory: aPoint
	^(aPoint = 'E')! !


!classDefinition: #North category: 'MarsRover'!
MarsRoverCardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'movements' stamp: 'AB 10/29/2022 16:06:19'!
rotateToLeft
	^West new.! !

!North methodsFor: 'movements' stamp: 'AB 10/29/2022 16:06:13'!
rotateToRight
	^East new.! !


!North methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:27:36'!
asString
	^'N'! !

!North methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:08:16'!
direction
	^(0 @ 1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 16:17:28'!
isYourCategory: aPoint
	^(aPoint = 'N')! !


!classDefinition: #South category: 'MarsRover'!
MarsRoverCardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'movements' stamp: 'AB 10/29/2022 16:07:09'!
rotateToLeft
	^East new.! !

!South methodsFor: 'movements' stamp: 'AB 10/29/2022 16:07:21'!
rotateToRight
	^West new.! !


!South methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:27:45'!
asString
	^'S'! !

!South methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:08:26'!
direction
	^(0 @ -1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 16:17:34'!
isYourCategory: aPoint
	^(aPoint = 'S')! !


!classDefinition: #West category: 'MarsRover'!
MarsRoverCardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'movements' stamp: 'AB 10/29/2022 16:07:43'!
rotateToLeft
	^South new.! !

!West methodsFor: 'movements' stamp: 'AB 10/29/2022 16:07:51'!
rotateToRight
	^North new.! !


!West methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:27:59'!
asString
	^'W'! !

!West methodsFor: 'atributes' stamp: 'AB 10/29/2022 17:08:33'!
direction
	^(-1 @ 0).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 16:17:42'!
isYourCategory: aPoint
	^(aPoint = 'W')! !


!classDefinition: #MarsRoverPosition category: 'MarsRover'!
Object subclass: #MarsRoverPosition
	instanceVariableNames: 'position cardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverPosition methodsFor: 'movements' stamp: 'AB 10/29/2022 17:18:20'!
backward
	^position - (cardinalPoint direction).! !

!MarsRoverPosition methodsFor: 'movements' stamp: 'AB 10/29/2022 17:18:28'!
forward
	^position + (cardinalPoint direction).! !

!MarsRoverPosition methodsFor: 'movements' stamp: 'AB 10/29/2022 17:22:09'!
rotateToLeft
	^cardinalPoint rotateToLeft.! !

!MarsRoverPosition methodsFor: 'movements' stamp: 'AB 10/29/2022 17:22:17'!
rotateToRight
	^cardinalPoint rotateToRight.! !


!MarsRoverPosition methodsFor: 'initialization' stamp: 'AB 10/29/2022 17:06:49'!
initializeWithThePosition: aPoint andCardinalPoint: aCardinalPoint.
	position := aPoint.
	cardinalPoint := aCardinalPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPosition class' category: 'MarsRover'!
MarsRoverPosition class
	instanceVariableNames: ''!

!MarsRoverPosition class methodsFor: 'instance creation' stamp: 'AB 10/29/2022 17:06:11'!
initializeWithThePosition: aPoint andCardinalPoint: aCardinalPoint
	^MarsRoverPosition new initializeWithThePosition: aPoint andCardinalPoint: aCardinalPoint.! !
