window.addEventListener("load", function() {
    errdiv = document.createElement("div");
    if (true) { //debug
        errdiv.classList.add("console");
        document.body.appendChild(errdiv);
        window.onerror = function(errorMsg, url, lineNumber, column, errorObj) {
            errdiv.innerHTML += '<br />Error: ' + errorMsg + ' Script: ' + url + ' Line: ' + lineNumber +
                ' Column: ' + column + ' StackTrace: ' + errorObj;
        }
    }

    //init dynamic menu
    //var dynamic_menu = new Menu();
    var wprompt = new WPrompt();
    var requestmgr = new RequestManager();
    var announcemgr = new AnnounceManager();

    requestmgr.onResponse = function(id, ok) {
        $.post("http://hvc/request", JSON.stringify({ act: "response", id: id, ok: ok }));
    }
    wprompt.onClose = function() {
            $.post("http://hvc/prompt", JSON.stringify({ act: "close", result: wprompt.result.substring(0, 1000) }));
        }
        /*dynamic_menu.onClose = function () {
        	$.post("http://hvc/menu", JSON.stringify({act: "close", id: dynamic_menu.id}));
        }
        dynamic_menu.onValid = function (choice, mod) {
        	$.post("http://hvc/menu", JSON.stringify({act: "valid", id: dynamic_menu.id, choice: choice, mod: mod}));
        }*/


    //request config
    $.post("http://hvc/cfg", "");

    //var current_menu = dynamic_menu;
    var pbars = {}
    var divs = {}

    //progress bar ticks (25fps)
    setInterval(function() {
        for (var k in pbars) {
            pbars[k].frame(1 / 25.0 * 1000);
        }

    }, 1 / 25.0 * 1000);

    //MESSAGES
    window.addEventListener("message", function(evt) { //lua actions
        var data = evt.data;

        if (data.act == "cfg") {
            cfg = data.cfg
        } else if (data.act == "open_menu") { //OPEN DYNAMIC MENU
            /*current_menu.close();
            dynamic_menu.open(data.menudata.name, data.menudata.choices);
            dynamic_menu.id = data.menudata.id;

            //customize menu
            var css = data.menudata.css
            if (css.top)
            //dynamic_menu.div.style.top = css.top;
            	if (css.header_color)
            		dynamic_menu.div_header.style.backgroundColor = css.header_color;

            current_menu = dynamic_menu;*/
        } else if (data.act == "close_menu") { //CLOSE MENU
            //current_menu.close();
        }
        // PROGRESS BAR
        else if (data.act == "set_pbar") {
            var pbar = pbars[data.pbar.name];
            if (pbar)
                pbar.removeDom();

            pbars[data.pbar.name] = new ProgressBar(data.pbar);
            pbars[data.pbar.name].addDom();
        } else if (data.act == "set_pbar_val") {
            var pbar = pbars[data.name];
            if (pbar)
                pbar.setValue(data.value);
        } else if (data.act == "set_pbar_text") {
            var pbar = pbars[data.name];
            if (pbar)
                pbar.setText(data.text);
        } else if (data.act == "remove_pbar") {
            var pbar = pbars[data.name]
            if (pbar) {
                pbar.removeDom();
                delete pbars[data.name];
            }
        }
        // PROMPT
        else if (data.act == "prompt") {
            wprompt.open(data.title, data.text);
        }
        // REQUEST
        else if (data.act == "request") {
            requestmgr.addRequest(data.id, data.text, data.time);
        }
        // ANNOUNCE
        else if (data.act == "announce") {
            announcemgr.addAnnounce(data.background, data.content);
        }
        // DIV
        else if (data.act == "set_div") {
            var div = divs[data.name];
            if (div)
                div.removeDom();

            divs[data.name] = new Div(data)
            divs[data.name].addDom();
        } else if (data.act == "set_div_css") {
            var div = divs[data.name];
            if (div)
                div.setCss(data.css);
        } else if (data.act == "set_div_content") {
            var div = divs[data.name];
            if (div)
                div.setContent(data.content);
        } else if (data.act == "div_execjs") {
            var div = divs[data.name];
            if (div)
                div.executeJS(data.js);
        } else if (data.act == "remove_div") {
            var div = divs[data.name];
            if (div)
                div.removeDom();

            delete divs[data.name];
        }
        // CONTROLS
        else if (data.act == "event") { //EVENTS
            if (data.event == "UP") {
                /*if (!wprompt.opened)
                	current_menu.moveUp();*/
            } else if (data.event == "DOWN") {
                /*if (!wprompt.opened)
                	current_menu.moveDown();*/
            } else if (data.event == "LEFT") {
                /*if (!wprompt.opened)
                	current_menu.valid(-1);*/
            } else if (data.event == "RIGHT") {
                /*if (!wprompt.opened)
                	current_menu.valid(1);*/
            } else if (data.event == "SELECT") {
                /*if (!wprompt.opened)
                	current_menu.valid(0);*/
            } else if (data.event == "CANCEL") {
                if (wprompt.opened)
                    wprompt.close();
                /*else
                	current_menu.close();*/

            } else if (data.event == "F5") {
                requestmgr.respond(true);
            } else if (data.event == "F6") {
                requestmgr.respond(false);
            }
        }
    });
});


var persistentNotifs = {};

window.addEventListener('message', function (event) {
    ShowNotif(event.data);
});

function CreateNotification(data) {
    var $notification = $(document.createElement('div'));
    $notification.addClass('notification').addClass(data.type);
    $notification.html(data.text);
    $notification.fadeIn();
    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }

    return $notification;
}

function ShowNotif(data) {
    if (data.persist === undefined) {
        var $notification = CreateNotification(data);
        $('.notif-container').append($notification);
        setTimeout(function() {
            $.when($notification.fadeOut()).done(function() {
                $notification.remove()
            });
        }, data.length != null ? data.length : 2500);
    } else {
        if (data.persist.toUpperCase() == 'START') {
            if (persistentNotifs[data.id] === undefined) {
                var $notification = CreateNotification(data);
                $('.notif-container').append($notification);
                persistentNotifs[data.id] = $notification;
            } else {
                let $notification = $(persistentNotifs[data.id])
                $notification.addClass('notification').addClass(data.type);
                $notification.html(data.text);

                if (data.style !== undefined) {
                    Object.keys(data.style).forEach(function(css) {
                        $notification.css(css, data.style[css])
                    });
                }
            }
        } else if (data.persist.toUpperCase() == 'END') {
            let $notification = $(persistentNotifs[data.id]);
            $.when($notification.fadeOut()).done(function() {
                $notification.remove();
                delete persistentNotifs[data.id];
            });
        }
    }
}



// HITSOUNDS

const audio = [
    { name: "zipper", file: "zipper.ogg", volume: 0.650 },
    { name: "armour", file: "armour.ogg", volume: 1.00 },
    { name: "houseraid", file: "houseraid.ogg", volume: 0.050 },
    { name: "bankhiest", file: "bankhiest.ogg", volume: 1.00 },
    { name: "purchase", file: "purchase.ogg", volume: 1.00 },
    { name: "caralarm", file: "caralarm.ogg", volume: 1.00 },
    { name: "care", file: "care.ogg", volume: 0.05 },
    { name: "opencare", file: "opencare.ogg", volume: 0.25},
    { name: "cod", file: "cod.ogg", volume: 0.75 },
    { name: "codheadshot", file: "codheadshot.ogg", volume: 0.75 },
    { name: "fortnite", file: "fortnite.ogg", volume: 0.75 },
    { name: "fortniteheadshot", file: "fortniteheadshot.ogg", volume: 0.75 },
    { name: "rust", file: "rust.ogg", volume: 1.00 },
    { name: "rustheadshot", file: "rustheadshot.ogg", volume: 1.00 },
    { name: "SanAndreas", file: "SanAndreas.ogg", volume: 1.00 },
    { name: "GTA_Sfx", file: "GTA_Sfx.ogg", volume: 1.00 },
  ]
  
  var audioPlayer = null;
    
  window.addEventListener('message', function (event) {
      if (findAudioToPlay(event.data.transactionType)) {
        let audio = findAudioToPlay(event.data.transactionType)
        if (audioPlayer != null) {
          audioPlayer.pause();
        }
        audioPlayer = new Audio("./sounds/" + audio.file);
        audioPlayer.volume = audio.volume;
        audioPlayer.play();
      }
  });
    
  function findAudioToPlay(name) {
      for (a of audio) {
        if (a.name == name) {
          return a
        }
      }
      return false
  }