// QUESTION: why does placing this outside of react component work, but breaks when inside
// with error "The value makeProps can't be found in CarLoan"
type loan = Principal | Interest | Months
@react.component
let make = () => {
  let (principal, setPrincipal) = React.useState(_ => 0.0);
  let (percentInterest, setPercentInterest) = React.useState(_ => 0.0);
  let (numMonths, setNumMonths) = React.useState(_ => 0.0);
  let (payment, setPayment) = React.useState(_ => 0.00)
  let (totalPayments, setTotalPayments) = React.useState(_ => 0.00)
  let (totalInterest, setTotalInterest) = React.useState(_ => 0.00)

let updateForm = (e, loanType: loan) => {
  let val = ReactEvent.Form.currentTarget(e)["value"]
  switch loanType {
  | Principal => setPrincipal(val)
  | Interest => setPercentInterest(val)
  | Months => setNumMonths(val)
  }
}

let calculateMonthlyPayment = (_) => {
  let p = CarLoanCalculator.monthlyPayment(~principal=principal, ~percentInterest=percentInterest, ~numMonths=numMonths)
  let totPay = CarLoanCalculator.totalRepaymentAmount(~monthlyPayment=p, ~numMonths=numMonths)
  let totInt = CarLoanCalculator.totalInterestAmount(~totalRepay=totPay, ~principal=principal)
  // Js.log2(React.string("payment amount"), p);
  setPayment((_) => p) // why can't I set like I am with the input change
  setTotalInterest((_) => totInt)
  setTotalPayments((_) => totPay)
}
  <div>
    <p>{React.string("Principal")}</p>
    <input type_="text" value={Belt.Float.toString(principal)} onChange={(e) => updateForm(e, Principal)} />
    <p>{React.string("Percent Interest")}</p>
    <input type_="text" value={Belt.Float.toString(percentInterest)} onChange={(e) => updateForm(e, Interest)} />
    <p>{React.string("Total Number of Months")}</p>
    <input type_="text" value={Belt.Float.toString(numMonths)} onChange={(e) => updateForm(e, Months)} />
    <button onClick={calculateMonthlyPayment}>{React.string("Get Monthly Payment")}</button>
    <h3>{React.string("Monthly Payment")}</h3>
    <h2>{React.string(Conversions.asCurrency(payment))}</h2>
    <h3>{React.string("Total Payments")}</h3>
    <h2>{React.string(Conversions.asCurrency(totalPayments))}</h2>
    <h3>{React.string("Total Interest")}</h3>
    <h2>{React.string(Conversions.asCurrency(totalInterest))}</h2>
  </div>
}