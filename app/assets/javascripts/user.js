
function togglePassword(id_ele) {
  let x="";
  if(id_ele=="1" || id_ele=="3"){
    x = document.getElementById("password");
  }
  else if(id_ele=="2"){
    x = document.getElementById("confirm_password");
  }
   if (x.type == "password") {
      document.getElementById(id_ele).innerHTML = "<i class='fa-solid fa-eye-slash'></i>"
      x.type = "text";
    } else {
      document.getElementById(id_ele).innerHTML = "<i class='fa-solid fa-eye'></i>"
      x.type = "password";
    }
  }

  
  