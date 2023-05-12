const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !parseInt(params[0]) || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'setcredits [permid] [amount]')
    }
    fivemexports.vrp.vrpbot('getUserSource', [parseInt(params[0])], function(d) {
        fivemexports.ghmattimysql.execute("UPDATE `vrp_user_moneys` SET bank = ? WHERE user_id = ?", [params[1], params[0]], (result) => {
            if (result) {
                let embed = {
                    "title": "Set Credits",
                    "description": `\nPerm ID: **${params[0]}**\nAmount: **${params[1]}**\n\nAdmin: <@${message.author.id}>`,
                    "color": settingsjson.settings.botColour,
                    "footer": {
                        "text": ""
                    },
                    "timestamp": new Date()
                }
                message.channel.send({ embed })
            } else {
                let embed = {
                    "title": "Failed to set Credits",
                    "description": `\nPerm ID: **${params[0]}**\nAmount: **${params[1]}**`,
                    "color": settingsjson.settings.botColour,
                    "footer": {
                        "text": ""
                    },
                    "timestamp": new Date()
                }
                message.channel.send({ embed })
            }
        })
    })
}

exports.conf = {
    name: "setcredits",
    perm: 5
}