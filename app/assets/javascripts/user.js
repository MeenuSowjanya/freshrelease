
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

  let sidebar = document.querySelector(".sidebar");
  let sidebarBtn = document.querySelector(".sidebarBtn");
  sidebarBtn.onclick = function() {
    sidebar.classList.toggle("active");
    if(sidebar.classList.contains("active")){
      sidebarBtn.classList.replace("bx-menu" ,"bx-menu-alt-right");
    }else
      sidebarBtn.classList.replace("bx-menu-alt-right", "bx-menu");
    }

    function ShowHideDiv(chkPassport) {
      var dvPassport = document.getElementById("dvPassport");
      dvPassport.style.display = chkPassport.checked ? "block" : "none";
  }
  