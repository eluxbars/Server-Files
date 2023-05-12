const doc = document;
var shaz = false 
window.addEventListener('load', () => {
    this.addEventListener('message', e => {
        if (e.data.action == 'openScoreboard') {
            doc.getElementById('wrapper').style.display = 'flex';
        }
        if (e.data.action == 'updatePlayers') {
            updateScoreboard(e.data.players, e.data.maxPlayers);
        }
        if (e.data.action == 'destroy') {
            doc.getElementById('wrapper').style.display = 'none';
        }
    })
})


const updateScoreboard = (players, maxPlayers) => {
    const UserIDs = doc.getElementById('cont-UserIDs');
    const names = doc.getElementById('cont-names');
    const times = doc.getElementById('cont-time');
    const killsTable = doc.getElementById('cont-kills');
    const deathsTable = doc.getElementById('cont-deaths');
    const kdTable = doc.getElementById('cont-kd');

    for (let i=doc.getElementsByClassName('currentData').length - 1; i >= 0; i--) {
        doc.getElementsByClassName('currentData')[i].remove()
    }

    players.forEach(player => {
        if (!doc.getElementById(player.playersName)) {
            const UserID = doc.createElement('span');
            const name = doc.createElement('span');
            const time = doc.createElement('span');
            const kills = doc.createElement('span');
            const deaths = doc.createElement('span');
            const kd = doc.createElement('span');

            UserID.textContent = player.UserID;
            time.textContent = player.playersTime;
            name.textContent = player.playersName;
            kills.textContent = player.playersKills;
            deaths.textContent = player.playersDeaths;
            kd.textContent = player.playersKD;

            name.id = player.UserID;
            UserID.classList.add('currentData', players.indexOf(player));
            time.classList.add('currentData', players.indexOf(player));
            name.classList.add('currentData',players.indexOf(player));
            kills.classList.add('currentData',players.indexOf(player));
            deaths.classList.add('currentData',players.indexOf(player));
            kd.classList.add('currentData',players.indexOf(player));

            names.appendChild(name);
            UserIDs.appendChild(UserID)
            times.appendChild(time);
            killsTable.appendChild(kills);
            deathsTable.appendChild(deaths);
            kdTable.appendChild(kd);
        }
    });

    doc.getElementById('players').textContent = maxPlayers;
}


document.onkeyup = function (data) {
    if (data.which == 36 && shaz) {
        $.post('https://PlayerList/exit', JSON.stringify({}));
        shaz = false 
    }
};

document.onkeydown = function (data) {
    if (data.which == 36 && !shaz) {
        shaz = true 
    }
}

