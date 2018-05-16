!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.

	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue

	| account |

	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.

	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive

	| account withdrawValue |

	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.

	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions

	| account deposit withdraw |

	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.

	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |

	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.

	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.

 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.

 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf

	| account1 |
	account1 := ReceptiveAccount new.

	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions

	| account1 deposit1 |

	account1 := ReceptiveAccount new.

	deposit1 := Deposit register: 100 on:account1.

	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.

	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	deposit1 := Deposit register: 100 on: account1.

	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.

	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts

	| account1 account2 account3 complexPortfolio |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self
		should: [ complexPortfolio transactionsOf:account3 ]
		raise: Error
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount

	| account1 |

	account1 := ReceptiveAccount new.
	self
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |

    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.

	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.

	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.

	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.

	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).

	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.

	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'JA 5/13/2018 01:55:06'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.

	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new.

	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings :=
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).

	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.

	lines := self accountSummaryLinesOf: fromAccount.

	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.

	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:29'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.

	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.

	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:30'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.

	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.

	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'JA 5/15/2018 19:14:47'!
accountSummaryLinesOf: aReceptiveAccount

	^(AccountSummary of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'JA 5/15/2018 19:40:08'!
accountTransferNetOf: aReceptiveAccount

	^(TransfersNetWorth of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'JA 5/15/2018 20:12:32'!
investmentEarningsOf: aReceptiveAccount

	^(InvestmentEarnings of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'JA 5/15/2018 19:54:47'!
investmentNetOf: aReceptiveAccount

	^(InvestmentNetWorth of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'JA 5/16/2018 17:34:07'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary

	^(PortfolioTree of: aPortfolio withNames: aDictionary) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'JA 5/16/2018 19:58:05'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aDictionary

	^(PortfolioTree of: aPortfolio withNames: aDictionary) reverse.! !


!classDefinition: #AccountQuery category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountQuery
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountQuery methodsFor: 'selecting' stamp: 'JA 5/15/2018 20:01:19'!
transactionsOfType: type
	
	^account transactions select: [:transaction | transaction isKindOf: type].! !


!AccountQuery methodsFor: 'execution' stamp: 'JA 5/16/2018 19:35:07'!
ceritificateOfDepositAnswerOf: transaction

	self subclassResponsibility.! !

!AccountQuery methodsFor: 'execution' stamp: 'JA 5/16/2018 19:35:13'!
depositAnswerOf: transaction

	self subclassResponsibility.! !

!AccountQuery methodsFor: 'execution' stamp: 'JA 5/16/2018 19:35:19'!
transferDepositAnswerOf: transaction

	self subclassResponsibility.! !

!AccountQuery methodsFor: 'execution' stamp: 'JA 5/16/2018 19:35:24'!
transferWithdrawAnswerOf: transaction

	self subclassResponsibility.! !

!AccountQuery methodsFor: 'execution' stamp: 'JA 5/15/2018 20:02:56'!
value

	self subclassResponsibility.! !

!AccountQuery methodsFor: 'execution' stamp: 'JA 5/16/2018 19:35:30'!
withdrawAnswerOf: transaction

	self subclassResponsibility.! !


!AccountQuery methodsFor: 'initialization' stamp: 'JA 5/15/2018 20:05:23'!
withAccount: queryAccount

	account := queryAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountQuery class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountQuery class
	instanceVariableNames: ''!

!AccountQuery class methodsFor: 'instance creation' stamp: 'JA 5/15/2018 20:35:35'!
of: account

	^self new withAccount: account.! !


!classDefinition: #InvestmentQuery category: #'PortfolioTreePrinter-Ejercicio'!
AccountQuery subclass: #InvestmentQuery
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentQuery methodsFor: 'selecting' stamp: 'JA 5/15/2018 20:16:57'!
certificateOfDepositTransactions

	^self transactionsOfType: CertificateOfDeposit.! !


!classDefinition: #InvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentQuery subclass: #InvestmentEarnings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarnings methodsFor: 'execution' stamp: 'JA 5/16/2018 19:36:07'!
certificateOfDepositAnswerOf: transaction

	^transaction value * transaction tna / 360 * transaction numberOfDays.! !

!InvestmentEarnings methodsFor: 'execution' stamp: 'JA 5/16/2018 19:27:23'!
value

	^self certificateOfDepositTransactions inject: 0 into: [:earnings :certificate | earnings + (certificate answerQuery: self)].! !


!classDefinition: #InvestmentNetWorth category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentQuery subclass: #InvestmentNetWorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNetWorth methodsFor: 'execution' stamp: 'JA 5/16/2018 19:36:18'!
certificateOfDepositAnswerOf: transaction

	^transaction value.! !

!InvestmentNetWorth methodsFor: 'execution' stamp: 'JA 5/16/2018 19:27:33'!
value

	^self certificateOfDepositTransactions inject: 0 into: [:netWorth :certificate | netWorth + (certificate answerQuery: self)].! !


!classDefinition: #TransfersNetWorth category: #'PortfolioTreePrinter-Ejercicio'!
AccountQuery subclass: #TransfersNetWorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransfersNetWorth methodsFor: 'execution' stamp: 'JA 5/16/2018 19:36:29'!
transferDepositAnswerOf: transaction

	^transaction transfer value.! !

!TransfersNetWorth methodsFor: 'execution' stamp: 'JA 5/16/2018 19:36:34'!
transferWithdrawAnswerOf: transaction

	^transaction transfer value negated.! !

!TransfersNetWorth methodsFor: 'execution' stamp: 'JA 5/16/2018 19:27:42'!
value

	^self transferTransactions inject: 0 into: [:netWorth :transfer | netWorth + (transfer answerQuery: self)].! !


!TransfersNetWorth methodsFor: 'selecting' stamp: 'JA 5/15/2018 20:34:49'!
transferTransactions

	^(self transactionsOfType: TransferDeposit) union: (self transactionsOfType: TransferWithdraw).! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'JA 5/15/2018 20:45:57'!
balance

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'JA 5/15/2018 20:45:49'!
value

	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'query' stamp: 'JA 5/16/2018 17:55:33'!
answerQuery: query

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |

	withdraw := self for: aValue.
	account register: withdraw.

	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'JA 5/13/2018 01:22:56'!
withValue: certificatesValue withNumberOfDays: certificatesNumberOfDays withTna: certificatesTna withAccount: certificatesAccount

	value := certificatesValue.
	numberOfDays := certificatesNumberOfDays.
	tna := certificatesTna.
	account := certificatesAccount.! !


!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 20:11:27'!
account

	^account.! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 20:40:53'!
balance

	^value negated.! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 20:11:35'!
numberOfDays

	^numberOfDays.! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 20:11:49'!
tna

	^tna.! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 20:11:20'!
value

	^value.! !


!CertificateOfDeposit methodsFor: 'query' stamp: 'JA 5/16/2018 19:38:08'!
answerQuery: query

	^query certificateOfDepositAnswerOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'JA 5/13/2018 01:21:50'!
forAmount: amount forTime: time atRate: rate onAccount: account

	^self new withValue: amount withNumberOfDays: time withTna: rate withAccount: account.! !

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'JA 5/13/2018 01:21:08'!
register: amount during: time at: rate on: account

	| certificate |

	certificate := self forAmount: amount forTime: time atRate: rate onAccount: account.
	account register: certificate.

	^certificate! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:35:37'!
balance

	^value.! !

!Deposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:35:27'!
value

	^value.! !


!Deposit methodsFor: 'query' stamp: 'JA 5/16/2018 19:38:18'!
answerQuery: query

	^query depositAnswerOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |

	withdraw := self for: aValue.
	account register: withdraw.

	^ withdraw! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'correspondingTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'JA 5/15/2018 19:03:47'!
withTransfer: transfer

	correspondingTransfer := transfer.
	correspondingTransfer receiver register: self.! !


!TransferDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:36:45'!
balance

	^correspondingTransfer value.! !

!TransferDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:06:37'!
transfer

	^correspondingTransfer.! !

!TransferDeposit methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:36:36'!
value

	^correspondingTransfer value.! !


!TransferDeposit methodsFor: 'query' stamp: 'JA 5/16/2018 19:38:25'!
answerQuery: query

	^query transferDepositAnswerOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'JA 5/15/2018 19:02:22'!
ofTransfer: transfer

	^self new withTransfer: transfer.! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'correspondingTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'JA 5/15/2018 19:04:41'!
withTransfer: transfer

	correspondingTransfer := transfer.
	correspondingTransfer sender register: self.! !


!TransferWithdraw methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:36:28'!
balance

	^correspondingTransfer value negated.! !

!TransferWithdraw methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:07:47'!
transfer

	^correspondingTransfer.! !

!TransferWithdraw methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:36:08'!
value

	^correspondingTransfer value.! !


!TransferWithdraw methodsFor: 'query' stamp: 'JA 5/16/2018 19:38:32'!
answerQuery: query

	^query transferWithdrawAnswerOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'JA 5/15/2018 19:05:12'!
ofTransfer: transfer

	^self new withTransfer: transfer.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:35:43'!
balance

	^value negated.! !

!Withdraw methodsFor: 'evaluating' stamp: 'JA 5/15/2018 19:35:01'!
value

	^value.! !


!Withdraw methodsFor: 'query' stamp: 'JA 5/16/2018 19:38:39'!
answerQuery: query

	^query withdrawAnswerOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |

	withdraw := self for: aValue.
	account register: withdraw.

	^ withdraw! !


!classDefinition: #HumanReadableAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #HumanReadableAccount
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!HumanReadableAccount methodsFor: 'initialization' stamp: 'JA 5/16/2018 17:32:28'!
withAccount: summaryAccount

	account := summaryAccount.! !


!HumanReadableAccount methodsFor: 'execution' stamp: 'JA 5/16/2018 19:39:55'!
certificateOfDepositAnswerOf: transaction

	self subclassResponsibility.! !

!HumanReadableAccount methodsFor: 'execution' stamp: 'JA 5/16/2018 19:40:20'!
depositAnswerOf: transaction

	self subclassResponsibility.! !

!HumanReadableAccount methodsFor: 'execution' stamp: 'JA 5/16/2018 19:42:23'!
portfolioAnswerOf: account

	self subclassResponsibility.! !

!HumanReadableAccount methodsFor: 'execution' stamp: 'JA 5/16/2018 19:42:39'!
receptiveAccountAnswerOf: account

	self subclassResponsibility.! !

!HumanReadableAccount methodsFor: 'execution' stamp: 'JA 5/16/2018 19:40:33'!
transferDepositAnswerOf: transaction

	self subclassResponsibility.! !

!HumanReadableAccount methodsFor: 'execution' stamp: 'JA 5/16/2018 19:40:46'!
transferWithdrawAnswerOf: transaction

	self subclassResponsibility.! !

!HumanReadableAccount methodsFor: 'execution' stamp: 'JA 5/16/2018 19:40:57'!
withdrawAnswerOf: transaction

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HumanReadableAccount class' category: #'PortfolioTreePrinter-Ejercicio'!
HumanReadableAccount class
	instanceVariableNames: ''!

!HumanReadableAccount class methodsFor: 'instance creation' stamp: 'JA 5/16/2018 17:32:51'!
of: account

	^self new withAccount: account.! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
HumanReadableAccount subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'execution' stamp: 'JA 5/16/2018 19:39:02'!
certificateOfDepositAnswerOf: transaction

	^'Plazo fijo por ', transaction value asString, ' durante ', transaction numberOfDays asString, ' dias a una tna de ', (transaction tna * 100) asString, '%'.! !

!AccountSummary methodsFor: 'execution' stamp: 'JA 5/16/2018 19:39:07'!
depositAnswerOf: transaction

	^'Deposito por ', transaction value asString.! !

!AccountSummary methodsFor: 'execution' stamp: 'JA 5/16/2018 19:39:11'!
transferDepositAnswerOf: transaction

	^'Transferencia por ', transaction value asString.! !

!AccountSummary methodsFor: 'execution' stamp: 'JA 5/16/2018 19:39:15'!
transferWithdrawAnswerOf: transaction

	^'Transferencia por ', transaction transfer value negated asString.! !

!AccountSummary methodsFor: 'execution' stamp: 'JA 5/16/2018 18:07:25'!
value
	^account transactions collect: [:transaction | transaction answerQuery: self].! !

!AccountSummary methodsFor: 'execution' stamp: 'JA 5/16/2018 19:39:20'!
withdrawAnswerOf: transaction

	^'Extraccion por ', transaction value asString.! !


!classDefinition: #PortfolioTree category: #'PortfolioTreePrinter-Ejercicio'!
HumanReadableAccount subclass: #PortfolioTree
	instanceVariableNames: 'accountNames'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTree methodsFor: 'execution' stamp: 'JA 5/16/2018 19:56:29'!
portfolioAnswerOf: portfolio

	^portfolio accounts
		inject: (OrderedCollection with: (accountNames at: portfolio))
		into: [
			:portfolioTree :account |
			portfolioTree addAllLast: ((PortfolioTree of: account withNames: accountNames) value collect: [:node | ' ', node]).
			portfolioTree.
		].! !

!PortfolioTree methodsFor: 'execution' stamp: 'JA 5/16/2018 19:55:26'!
receptiveAccountAnswerOf: account

	^OrderedCollection with: (accountNames at: account).! !

!PortfolioTree methodsFor: 'execution' stamp: 'JA 5/16/2018 19:57:38'!
reverse

	^self value reverse.! !

!PortfolioTree methodsFor: 'execution' stamp: 'JA 5/16/2018 19:54:29'!
value

	^account answerQuery: self.! !


!PortfolioTree methodsFor: 'initialization' stamp: 'JA 5/16/2018 17:35:48'!
withNames: names

	accountNames := names.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTree class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTree class
	instanceVariableNames: ''!

!PortfolioTree class methodsFor: 'instance creation' stamp: 'JA 5/16/2018 17:35:13'!
of: account withNames: names

	^(self of: account) withNames: names.! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'JA 5/16/2018 19:56:02'!
accounts

	^accounts.! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions

	^ accounts
		inject: OrderedCollection new
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ]
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'query' stamp: 'JA 5/16/2018 19:32:51'!
answerQuery: query

	^query portfolioAnswerOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.

	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount |
			(sourceAccount = targetAccount) not ifTrue: [
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription

	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'JA 5/15/2018 19:33:08'!
balance

	^transactions inject: 0 into: [:balance :transaction | balance + transaction balance].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction
! !


!ReceptiveAccount methodsFor: 'query' stamp: 'JA 5/16/2018 19:33:37'!
answerQuery: query

	^query receptiveAccountAnswerOf: self.! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw sender receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'JA 5/15/2018 19:04:18'!
receiver

	^receiver.! !

!Transfer methodsFor: 'initialization' stamp: 'JA 5/15/2018 19:04:11'!
sender

	^sender.! !

!Transfer methodsFor: 'initialization' stamp: 'JA 5/15/2018 19:01:39'!
withValue: transferValue withSender: senderAccount withReceiver: receiverAccount

	value := transferValue.
	sender := senderAccount.
	receiver := receiverAccount.
	TransferWithdraw ofTransfer: self.
	TransferDeposit ofTransfer: self.! !


!Transfer methodsFor: 'evaluating' stamp: 'JA 5/13/2018 01:50:53'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'JA 5/15/2018 18:52:23'!
register: amount from: sender to: receiver

	^self new withValue: amount withSender: sender withReceiver: receiver.! !
