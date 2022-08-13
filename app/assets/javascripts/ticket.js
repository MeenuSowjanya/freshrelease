
  function showHideForm(div_id) {
    let div = document.getElementById(div_id)
    console.log(div)
     if (div.style.display == "none") {
       console.log(div)
       div.style.display = "block"
      } else {
        div.style.display = "none"
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

  function imageDiv(value){
    if (value!=""){
        document.getElementById("imageDiv").innerText = "Images chosen successfully";
    }
    else{
        document.getElementById("imageDiv").innerText = "No files chosen"
    }
    

}