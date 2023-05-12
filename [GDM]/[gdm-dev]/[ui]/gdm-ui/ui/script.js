$(document).ready(function(){
    window.addEventListener("message", function(event){
    if(event.data.update == true){
        positionHud(event.data.topLeftAnchor,event.data.yAnchor)
        setMoney(event.data.bank,'#bank-text');
    }
    if(event.data.showhud == false){
        document.getElementById('bank-text').style.display = "none";
        document.getElementById('bighudfam').style.display = "none";
    }
    if(event.data.showhud == true){
        document.getElementById('bank-text').style.display = "block";      
        document.getElementById('bighudfam').style.display = "block";      
    }
    });
    function setMoney(amount, element){
        $(element).text(amount);
    }
    function positionHud(topLeftAnchor,yAnchor){
        $( ".hud" ).css( "left", topLeftAnchor + "px" );
        $( ".hud" ).css( "top", yAnchor + "px" );
    }

    // Clock based on user's local hour
    function updateClock() {
    var now = new Date(),
        time = (now.getHours()<10?'0':'') + now.getHours() + ':' + (now.getMinutes()<10?'0':'') + now.getMinutes();

    document.getElementById('hour').innerHTML = [time];
    setTimeout(updateClock, 1000);
    }
    updateClock();

});