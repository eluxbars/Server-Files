const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'kick [permid] [reason]')
    }
    const reason = params.slice(1).join(' ');
    let newval = fivemexports.vrp.vrpbot('saveKickLog', [params[0], message.author.username, `${reason}`])
    fivemexports.vrp.vrpbot('getUserSource', [parseInt(params[0])], function(d) {
        let newval = fivemexports.vrp.vrpbot('kick', [d, `You were kicked from the server for: ${reason} | Admin: ${message.author.username}`])
        let embed = {
            "title": "Kick Successful",
            "description": `\nPerm ID: **${params[0]}**\nReason: **${params[1]}**\n\nAdmin: <@${message.author.id}>`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    })
}

exports.conf = {
    name: "kick",
    perm: 1
}