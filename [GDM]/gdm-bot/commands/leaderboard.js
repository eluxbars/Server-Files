var AsciiTable = require('ascii-table');
const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    fivemexports.ghmattimysql.execute("SELECT * FROM `gdm_leaderboard` ORDER BY kills DESC", [], (result) => {
        if (result) {
            var table = new AsciiTable('Top 10 Kills')
            table.setHeading('Perm ID', 'Kills', 'Deaths', 'K/D')
            for (i = 0; i < result.length; i++) {
                if (i < 10) {
                    table.addRow(result[i].user_id, result[i].kills, result[i].deaths, (result[i].kills/result[i].deaths).toFixed(2))
                }
            }
            message.channel.send('```ascii\n' + table.toString() + '```')
        }
    })
}

exports.conf = {
    name: "leaderboard",
    perm: 0
}