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
           // failed to login 
        }
      },
      error: (error) => {
        console.error(error);
        $("#login-error").text("An error occurred. Please try again later.");
      }
    });
  });
});
