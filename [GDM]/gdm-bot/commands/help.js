const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        let embed = {
            "title": "**GDM Bot Help**",
            "description": `**${process.env.PREFIX}help management** (Management only)
            \n**${process.env.PREFIX}help staff** (Staff only)
            \n**${process.env.PREFIX}help user** (Public commands any user can execute)`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    }
    else {
    if (params[0] == 'user') {
        let embed = {
            "title": "GDM Bot Commands",
            "description": `**Public Commands:** \n${process.env.PREFIX}hmc [spawncode] \n${process.env.PREFIX}gco [spawncode] \n${process.env.PREFIX}status \n${process.env.PREFIX}ip \n${process.env.PREFIX}top10 \n${process.env.PREFIX}staffapp \n${process.env.PREFIX}banappeal \n${process.env.PREFIX}locklist`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    }   
    else if (params[0] == 'staff') {
        let embed = {
            "title": "GDM Bot Commands",
            "description": `**Lower Staff Commands:**\n${process.env.PREFIX}ch [permid] \n${process.env.PREFIX}d2p [@user] \n${process.env.PREFIX}p2d [permid] \n${process.env.PREFIX}showf10 [permid] \n${process.env.PREFIX}userinfo [permid] \n${process.env.PREFIX}notes [permid] \n${process.env.PREFIX}addnote [permid] [text] \n${process.env.PREFIX}delnote [note-id]\n\n**Moderator Commands:** \n${process.env.PREFIX}ban [permid] [time (hours)] [reason] \n${process.env.PREFIX}garage [permid]\n\n**Senior Moderator Commands:** \n${process.env.PREFIX}unban [permid] \n${process.env.PREFIX}groups [permid] \n\n**Admin Commands:** \n${process.env.PREFIX}clearf10 [permid]`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    }   
    else if (params[0] == 'management') {
        let embed = {
            "title": "GDM Bot Commands",
            "description": `**Management Commands:** \n${process.env.PREFIX}addcar [permid] \n${process.env.PREFIX}delcar [permid] \n${process.env.PREFIX}addcredits [permid] \n${process.env.PREFIX}setcredits [permid]`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    }   
    else if (params[0] == 'dev') {
        let embed = {
            "title": "GDM Bot Commands",
            "description": `**Developer Commands:** \n*(These commands will interact with the server database, do not run any if unsure of the outcome.)* \n${process.env.PREFIX}clearbans \n${process.env.PREFIX}punishments \n${process.env.PREFIX}delcardb \n${process.env.PREFIX}lockcar`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    }       
    else {
        let embed = {
            "title": "GDM Bot Commands",
            "description": "**Error**, unknown option selected",
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    }
}
}

exports.conf = {
    name: "help",
    perm: 0
}
