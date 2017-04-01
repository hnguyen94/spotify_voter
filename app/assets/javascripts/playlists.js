// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

vote()
intervalSet()
function intervalSet(){
    window.setInterval(function(){
        checkLastPlayedTrack()
    },5000)
}

function vote(){
    document.querySelector('.list-group').addEventListener('click', function(e){
        document.querySelectorAll('.list-group .list-group-item .glyphicon').forEach(function(element){
           if(e.target === element){
                console.log("click")
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    //console.log(this.status)
                    if (this.readyState === 4 && this.status === 200) {
                        res = xhttp.responseText
                        document.querySelector('html').innerHTML = res
                        vote()

                    }
                };
                xhttp.open('PUT', '/tracks/' + element.parentElement.id, true);
                xhttp.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').getAttribute('content'))
                xhttp.send();
            }

        })
     })

}

function checkLastPlayedTrack(){
    console.log('check last played track')
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        //console.log(this.status)
        if (this.readyState === 4 && this.status === 200) {
            res = xhttp.responseText
            document.querySelector('html').innerHTML = res
            vote()
        }
    };
    xhttp.open('PUT', '/check-last-track', true);
    xhttp.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').getAttribute('content'))
    xhttp.send();
}






