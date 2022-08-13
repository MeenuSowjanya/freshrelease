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
 function bot_div(cur_id_no,nxt_id_no){
   cur_id_string = `bot-icon${cur_id_no}`;
   nxt_id_string = `bot-icon${nxt_id_no}`;
   document.getElementById(cur_id_string).style.display = "none";
   document.getElementById(nxt_id_string).style.display = "block";
 }