var rList = new Object();

Object.size = function(obj) {
    var size = 0,
      key;
    for (key in obj) 
    {
      if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

$(document).ready(function(){
    let shown = false
    let currentDays = 0
    var claimedList = new Object();

    $(document).on('keyup', function(e) 
    {
        if (e.key == "Escape") 
        {
            Exit()
        }
    });

    function Exit() 
    {
        $("body").fadeOut();
        shown = false

        $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
    }
    
    window.addEventListener('message', function(event) 
    {
        var data = event.data;

        if (data.type == "rewards") 
        {
            document.getElementById("container").innerHTML = "";
            
            let exitBtn = document.createElement("button");
            exitBtn.id = "exit-button";
            exitBtn.textContent = "❌";
            exitBtn.onclick = function() { Exit() }
            document.getElementById("container").appendChild(exitBtn);

            var totalDays = document.createElement('p');
            document.getElementById("container").appendChild(totalDays);
            totalDays.textContent = "→ " + currentDays + " days in a row.";
            totalDays.id = "reward-desc";

            for (let i = 0; i < data.rwds.length; i++) 
            {
                rList[i] = new Object();

                for (let j = 0; j < data.rwds[i].length; j++) 
                {
                    if (data.rwds[i][j][0] == "Label") rList[i]["Label"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "Description") rList[i]["Description"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "Days") rList[i]["Days"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "UniqueID") rList[i]["UniqueID"] = data.rwds[i][j][1]
                }
            }

            for (let i = 0; i < Object.size(rList); i++) 
            {
                var innerDiv = document.createElement('div');
                innerDiv.className = 'card';
                document.getElementById("container").appendChild(innerDiv);
                innerDiv.id = "card-" + i.toString();
                innerDiv.innerHTML = `
                <p id="reward-title">${rList[i]["Label"]}</p>
                <p id="reward-desc">${rList[i]["Description"]}</p>`;
                
                let btn = document.createElement("button");
                btn.className = "button";

                let alreadyClaimed = false;
                for (let j = 0; j < Object.size(claimedList); j++) 
                {
                    if (claimedList[j] == rList[i]["UniqueID"]) 
                    {
                        alreadyClaimed = true;
                    }
                }

                if (!alreadyClaimed)
                {
                    if (parseInt(rList[i]["Days"], 10) <= currentDays) 
                    {
                        btn.textContent = `CLAIM ✔`;
                        btn.id = "claimable"
                        btn.onclick = function() 
                        {
                            if (currentDays >= parseInt(rList[i]["Days"], 10)) 
                            {
                                Exit()
                                $.post(`https://${GetParentResourceName()}/claim`, JSON.stringify(
                                    {
                                        _uniqueID: rList[i]["UniqueID"]
                                    }
                                ))
                            }
                        };
                    }
                    else 
                    {
                        btn.textContent = "Claimable in " + (parseInt(rList[i]["Days"], 10) - currentDays).toString() + " days";
                    }
                    
                }
                else
                {
                    btn.textContent = `CLAIMED`;
                    btn.id = "claimed";
                }

                document.getElementById("card-" + i.toString()).appendChild(btn);
            }
        }
        else if (data.type == "menu") 
        {
            if (!shown) 
            {
                $("body").fadeIn();
                shown = true
            } 
            else 
            {
                $("body").fadeOut();
                shown = false
            }
        }
        else if (data.type == "days") 
        {
            currentDays = data.days
        }
        else if (data.type == "claimed") 
        {
            claimedList = data.claimed
        }
    });
});