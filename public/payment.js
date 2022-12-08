$(document).ready(function() {
  $('form').submit(function(event) {
    // Prevent the form from being submitted
    event.preventDefault();

    // Get the input values
    var cardNumber = $('#card-number').val();
    var expirationDate = $('#expiration-date').val();
    var securityCode = $('#security-code').val();

    // Validate the input values
    if (cardNumber.length == 0) {
      alert('Please enter a card number');
      return;
    }
    if (expirationDate.length == 0) {
      alert('Please enter an expiration date');
      return;
    }
    if (securityCode.length == 0) {
      alert('Please enter a security code');
      return;
    }

    // If the input values are valid, submit the payment
    alert('Payment submitted successfully!');
  });
});
