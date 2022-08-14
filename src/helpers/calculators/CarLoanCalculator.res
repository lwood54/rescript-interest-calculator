// formula: principal X ((interestRate / 12) / (1 - (1 + interestRate / 12)^-months)  )
let calcInterestRate = (percentInterest) => percentInterest /. 100.0
let rateDivide12 = (rate) => rate /. 12.0
let getRest = (rate12, numMonths) => rate12 /. (1.0 -. Js.Math.pow_float(~base=(1.0 +. rate12), ~exp=-.numMonths))
let finalCalc = (rest, principal) => principal *. rest
let monthlyPayment = (~principal, ~percentInterest, ~numMonths) => percentInterest
		-> calcInterestRate
		-> rateDivide12
		-> getRest(numMonths)
		-> finalCalc(principal)
let totalRepaymentAmount = (~monthlyPayment, ~numMonths) => monthlyPayment *. numMonths
let totalInterestAmount = (~totalRepay, ~principal) => totalRepay -. principal