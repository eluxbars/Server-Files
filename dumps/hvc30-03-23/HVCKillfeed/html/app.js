$(function() {

    var zoneContainer = $('.zoneOwner');
    var zoneOwner = $('.zoneTeamText');

    window.addEventListener('message', function(event) {

        var item = event.data;

        if(item.type == "newKill") {
            addKill(item.killer, item.killed, item.weapon, item.killergroup, item.killedgroup, item.container, item.distance, item.duration);   
        } else if(item.type == "newDeath"){
            newDeath(item.killed, item.group, item.container, item.duration);
        }
    })
})

function addKill(killer, killed, weapon, killergroup, killedgroup, container, distance, duration) {
    $('<div class="' + container +'"><span class="' + killergroup + '">' + killer + '</span><img src="img/' + weapon + '.png" class="weapon"><span class="' + killedgroup + '">' + killed + '<span class="distance">' + distance + '</span></div><br class="clear">').appendTo('.kills')
    .delay(duration)
    .queue(function() { $(this).remove(); });
    //$(".kills").append('<div class="killContainer"><span class="killer">' + killer + '</span><img src="https://wiki.rage.mp/images/1/16/Combat-pistol-icon.png" class="weapon"><span class="killed">' + killed + '</span></div><br class="clear">');
}

function newDeath(killed, group, container, duration) {

    $('<div class="' + container +'"><span class=' + group +'>' + killed + '</span><img src="img/suicide.png" class="weapon">').appendTo('.kills')
    .delay(duration)
    .queue(function() { $(this).remove(); });
    //$(".kills").append('<div class="killContainer"><span class="killer">' + killer + '</span><img src="https://wiki.rage.mp/images/1/16/Combat-pistol-icon.png" class="weapon"><span class="killed">' + killed + '</span></div><br class="clear">');
}