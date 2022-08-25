import { dbank } from "../../declarations/dbank";

const balanceElt = document.getElementById("value");
const formElt = document.querySelector("form");

window.addEventListener("load", async function () {
  const currentAmount = await dbank.checkBalance();
  balanceElt.innerText = Math.round(currentAmount * 100) / 100;
});

formElt.addEventListener("submit", async function (event) {
  event.preventDefault();
  console.log(event.target);
  const button = document.getElementById("submit-btn");
  const inputAmountElt = document.getElementById("input-amount");
  const outputAmountElt = document.getElementById("withdrawal-amount");

  button.setAttribute("disabled", true);

  if (inputAmountElt.value.length !== 0) {
    await dbank.topUp(parseFloat(inputAmountElt.value));
    inputAmountElt.value = "";
  } else if (outputAmountElt.value.length !== 0) {
    await dbank.withdraw(parseFloat(outputAmountElt.value));
    outputAmountElt.value = "";
  }

  const currentAmount = await dbank.checkBalance();
  balanceElt.innerText = Math.round(currentAmount * 100) / 100;

  await dbank.compound();
  button.removeAttribute("disabled");
});
