$(document).ready(() => {

  $("#login-btn").click((event) => {
    event.preventDefault();

    const email = $("#defaultForm-email").val();
    const password = $("#defaultForm-pass").val();

    $.ajax({
      type: "POST",
      url: "/login",
      data: { email: email, password: password },
      dataType: "json",
      success: (response) => {
        if (response.success) {
          window.location.href = "/";
        } else {
          $("#login-error").text(response.message);
          setTimeout(() => {
            $("#login-error").text(""); 
          }, 3000); 
           
        }
      },
      error: (error) => {
        console.error(error);
        $("#login-error").text("An error occurred. Please try again later.");
      }
    });
  });
});

$(document).ready(() => {

  $("#signup-btn").click((event) => {
    event.preventDefault();
    const name = $("#orangeForm-name").val();
    const email = $("#orangeForm-email").val();
    const password = $("#orangeForm-pass").val();
    $.ajax({
      type: "POST",
      url: "/register",
      data: { name: name, email: email, password: password },
      dataType: "json",
      success: (response) => {
        if (response.success) {
          window.location.href = "/";
        } else {
          $("#signup-error").text(response.message);
          setTimeout(() => {
            $("#signup-error").text(""); 
          }, 3000); 

        }
      },
      error: (error) => {
        console.error(error);
      }
    });
  });
});

// reset sign up modal after clicked close button
$(document).ready(function () {
  $(".modal").on("hidden.bs.modal", function () {

    $("#orangeForm-name").val("");
    $("#orangeForm-email").val("");
    $("#orangeForm-pass").val("");
    $("#signup-error").text("");
  });
});