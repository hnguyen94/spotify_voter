// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.querySelector('.list-group').addEventListener('click', function(e){
    document.querySelectorAll('.list-group .list-group-item span').forEach(function(element){
        if(e.target === element){
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState === 4 && this.status === 200) {
                    console.log(element.getAttribute('name'))
                }
            };
            xhttp.open('PUT', '/tracks/2B3FCVxi308OK2z8suLD7r?track_id=2B3FCVxi308OK2z8suLD7r', true);
            xhttp.send();
        }
    })
})


/*

 */


