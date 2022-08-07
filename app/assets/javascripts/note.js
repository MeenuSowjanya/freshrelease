function show_add_note_form(boolean){
    if(boolean==1){
        document.getElementById("add_note_form").style.display = "block";
        document.getElementById("add_note_button").style.display = "none";
    }
   else{
       window.location.reload();
   }
    
 }

 function show_add_canned_form(boolean){
    if(boolean==1){
        document.getElementById("add_canned_form").style.display = "block";
        document.getElementById("add_canned_button").style.display = "none";
    }
   else{
       window.location.reload();
   }
    
 }