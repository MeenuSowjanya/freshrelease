
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
    function show_add_note_form(div_count,boolean){
        if(boolean==1){
            div_count_str= div_count.toString();
            document.getElementById(`crd${div_count}`).style.display = "block";
            document.getElementById(`add_note_button${div_count}`).style.display = "none";
            document.getElementById(`arrow${div_count}`).innerHTML = "<i class=\"fa-solid fa-angle-up\" onclick=\"show_add_note_form("+div_count_str+",0)\"></i>";
        }
       else{
        document.getElementById(`crd${div_count}`).style.display = "none";
        document.getElementById(`add_note_button${div_count}`).style.display = "block";
        document.getElementById(`arrow${div_count}`).innerHTML = "<i class=\"fa-solid fa-angle-down\" onclick=\"show_add_note_form("+div_count_str+",1)\"></i>";
       }
        
     }