var total = 0;
        
function getTotal(){
        var input = document.getElementsByName("products");
        total = 0
        for (var i = 0; i < input.length; i++) {
          if (input[i].checked) {
            total += parseFloat(input[i].value);
          }
        }
    
    document.getElementsByName("total")[0].value = "₱" + total.toFixed(2);
      
}

function compDisc(){
    var disc_total = total;

    var selectBox = document.getElementById("discid");
    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
    document.getElementsByName("total")[0].value = "₱" + (disc_total.toFixed(2)-(disc_total.toFixed(2)*selectedValue));
}

function checkout(){
    if (total == 0){
        alert("Please select a valid item.")
    }
    else{
        if(confirm("Are you sure?"))
        {   
            alert("Items are checked out.");
        }
    }
    
   
}