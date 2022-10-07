!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'testing' stamp: 'IL 10/1/2022 19:24:17'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack new.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'testing' stamp: 'AB 10/7/2022 17:16:00'!
test02StackShouldBePushAElement
	| stack |
	
	stack := Stack new.
	stack push: 0.
	
	self deny: (stack isEmpty).! !

!StackTest methodsFor: 'testing' stamp: 'AB 10/7/2022 18:03:25'!
test03StackShouldBePopAElement
	| stack pushElement |
	stack := Stack new.
	pushElement := 0.
	
	self assert: Stack cannotPopAElement equals: (stack pop).
	
	stack push: pushElement.
	self assert: pushElement equals: (stack pop).! !

!StackTest methodsFor: 'testing' stamp: 'AB 10/7/2022 17:20:37'!
test04StackPushElementAndStackPopElementAreTheSame
	| stack pushElement popElement |
	stack := Stack new.
	pushElement := 0.
	
	stack push: pushElement.
	self deny: (stack isEmpty).
	
	popElement := stack pop.
	self assert: (stack isEmpty).
	self assert: (pushElement = popElement).! !

!StackTest methodsFor: 'testing' stamp: 'AB 10/7/2022 17:36:23'!
test05StackShouldBeLIFO
	| stack firstElement secondElement thirdElement |
	
	stack := Stack new.
	firstElement := 0.
	secondElement := 1.
	thirdElement := 2.
	
	stack push: firstElement.
	stack push: secondElement.
	stack push: thirdElement.
	
	self assert: stack pop equals: thirdElement.
	self assert: stack pop equals: secondElement.
	self assert: stack pop equals: firstElement.! !

!StackTest methodsFor: 'testing' stamp: 'AB 10/7/2022 17:38:02'!
test06StackTopElementIsTheLastPushElement
	| stack pushElement |
	stack := Stack new.
	pushElement := 0.
	
	stack push: pushElement.
	self deny: (stack isEmpty).
	self assert: stack top equals: pushElement.! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'data'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'initialization' stamp: 'AB 10/7/2022 18:40:58'!
createData
	(data = nil) ifTrue: [data := OrderedCollection new].! !


!Stack methodsFor: 'testing' stamp: 'AB 10/7/2022 18:40:41'!
isEmpty
	self createData.
	^(data size = 0)! !


!Stack methodsFor: 'operations' stamp: 'AB 10/7/2022 17:55:58'!
pop
	(self isEmpty) ifTrue: [^self class cannotPopAElement].
	^data removeLast.! !

!Stack methodsFor: 'operations' stamp: 'AB 10/7/2022 18:40:22'!
push: anElement
	self createData.
	data add: anElement.! !

!Stack methodsFor: 'operations' stamp: 'AB 10/7/2022 17:58:44'!
top
	(self isEmpty) ifTrue: [^self class cannotSeeTop].
	^(data at: (data size)).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'StackPrimeraParte'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'error description' stamp: 'AB 10/7/2022 17:30:20'!
cannotPopAElement
	^'Cannot pop a element'! !

!Stack class methodsFor: 'error description' stamp: 'AB 10/7/2022 17:56:30'!
cannotSeeTop
	^'Cannot see top'! !
