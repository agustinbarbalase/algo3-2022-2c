!classDefinition: #CustomerBookError category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CustomerBookError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #AlreadyExists category: 'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #AlreadyExists
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CanNotBeEmpty category: 'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #CanNotBeEmpty
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'asserts' stamp: 'AB 9/24/2022 19:33:30'!
shouldBe: aNumberOfCustomers withACustomerCalled: aNameOfCustomer inBook: customerBook
	self assert: customerBook numberOfCustomers = aNumberOfCustomers.
	self assert: (customerBook includesCustomerNamed: aNameOfCustomer)! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'AB 9/24/2022 20:26:31'!
shouldFail: aBlock withError: anExpectedError andDo: anOtherBlock
	[aBlock value. self fail.] on: anExpectedError do: [[:anError | anOtherBlock] value: anExpectedError].! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'AB 9/24/2022 19:38:22'!
shouldHave: activeCustomers activeCustomersAnd: suspendedCustomers suspendedCustomersInBook: customerBook
	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: (activeCustomers + suspendedCustomers) equals: customerBook numberOfCustomers.! !


!CustomerBookTest methodsFor: 'customers' stamp: 'AB 9/24/2022 20:01:42'!
addASuspendedCustomerCalled: aName inBook: aCustomerBook
	aCustomerBook addCustomerNamed: aName.
	aCustomerBook suspendCustomerNamed: aName.! !

!CustomerBookTest methodsFor: 'customers' stamp: 'AB 9/24/2022 18:03:52'!
johnLennon
	^'John Lennon'! !

!CustomerBookTest methodsFor: 'customers' stamp: 'AB 9/24/2022 18:04:48'!
paulMcCartney
	^'Paul McCartney'! !

!CustomerBookTest methodsFor: 'customers' stamp: 'AB 9/24/2022 19:52:56'!
ringoStartt
	^'Ringo Starr'! !


!CustomerBookTest methodsFor: 'stopwatch' stamp: 'AB 9/24/2022 18:02:02'!
measureTimeExecution: aBlock
	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	^(millisecondsAfterRunning - millisecondsBeforeRunning)! !


!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 19:42:23'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook totalTime |
	
	customerBook := CustomerBook new.
	totalTime := self measureTimeExecution: [customerBook addCustomerNamed: self johnLennon].
	
	self assert: (totalTime) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 19:42:28'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook totalTime |
	
	customerBook := CustomerBook new.
	totalTime := self measureTimeExecution: [customerBook addCustomerNamed: self paulMcCartney].
	
	self assert: (totalTime) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 20:52:57'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook |
			
	customerBook := CustomerBook new.

	self shouldFail: [customerBook addCustomerNamed: ''] withError: CanNotBeEmpty andDo: [
		self assert: customerBook isEmpty
	]
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 20:41:03'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := self johnLennon.
	customerBook addCustomerNamed: johnLennon.
	
	self shouldFail: [customerBook removeCustomerNamed: self paulMcCartney.] 
		withError: NotFound andDo: [self shouldBe: 1 withACustomerCalled: johnLennon inBook: customerBook.].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 20:42:45'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := self paulMcCartney.
	self addASuspendedCustomerCalled: paulMcCartney inBook: customerBook.
	
	self shouldHave: 0 activeCustomersAnd: 1 suspendedCustomersInBook: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 20:08:40'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := self paulMcCartney.
	
	self addASuspendedCustomerCalled: paulMcCartney inBook: customerBook .
	customerBook removeCustomerNamed: paulMcCartney.
	
	self shouldHave: 0 activeCustomersAnd: 0 suspendedCustomersInBook: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 20:28:26'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := self johnLennon.
	customerBook addCustomerNamed: johnLennon.
	
	self shouldFail: [customerBook suspendCustomerNamed: self ringoStartt.] 
		withError: CantSuspend andDo: [self shouldBe: 1 withACustomerCalled: johnLennon inBook: customerBook. ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/24/2022 20:44:41'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := self johnLennon.
	self addASuspendedCustomerCalled: johnLennon inBook: customerBook.

	self shouldFail: [customerBook suspendCustomerNamed: johnLennon.	] 
		withError: CantSuspend andDo: [self shouldBe: 1 withACustomerCalled: johnLennon inBook: customerBook.].! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/24/2022 20:52:23'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [^CanNotBeEmpty signal].
	(self includesCustomerNamed: aName) ifTrue: [^AlreadyExists signal].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/24/2022 19:27:46'!
numberOfCustomers
	^(self numberOfActiveCustomers + self numberOfSuspendedCustomers).! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/24/2022 19:25:42'!
removeCustomerNamed: aName
	^(active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [^NotFound signal]
	]).! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
