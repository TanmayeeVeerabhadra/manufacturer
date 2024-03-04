// import { HttpAgent } from '@dfinity/agent';
import { manufacturer } from "../../declarations/manufacturer";

document.querySelector('form[name="adp"]').addEventListener('submit', async (event) => {
    event.preventDefault()
    const button = event.target.querySelector("button");
    const productId = document.getElementById('pid').value.toString();
    const productName = document.getElementById('pname').value.toString();
    const manuId = document.getElementById('mid').value.toString();
  
    const newRecord = { productId, productName, manuId };
    button.setAttribute("disabled", true);
    try {
        const result = await manufacturer.AddProduct(newRecord);
        document.getElementById("added").innerText=result;
        console.log(result);
    } catch (error) {
        console.error('An error occurred:', error);
        // You can display the error message to the user here if needed
    } finally {
        button.removeAttribute("disabled");
    }
    return false;
});