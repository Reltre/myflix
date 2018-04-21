var stripe = Stripe('pk_test_61yMW8BG4x48Bp4qLMaxPEMA');

// Create an instance of Elements.
var elements = stripe.elements();

var cardNumber = elements.create('cardNumber');
var cardExp = elements.create('cardExpiry');
var cardCvc = elements.create('cardCvc');

$(document).ready(function() {
  if (window.location.pathname !== '/register') return; 
  cardNumber.mount('#card-number');
  cardExp.mount('#card-exp');
  cardCvc.mount('#card-cvc');

  cardNumber.addEventListener('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  });
  
  cardExp.addEventListener('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  });
  
  cardCvc.addEventListener('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  });

  var form = document.getElementById('registration-form');
  form.addEventListener('submit', function(event) {
    event.preventDefault();
    stripe.createToken(cardNumber).then(function(result) {
      if (result.error) {
        // Inform the customer that there was an error.
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = result.error.message;
      } else {
        // Send the token to your server.
        stripeTokenHandler(result.token);
      }
    }); 
  });

  function stripeTokenHandler(token) {
    // Insert the token ID into the form so it gets submitted to the server
    var form = document.getElementById('registration-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);
  
    // Submit the form
    $(form).submit();
  }
});






