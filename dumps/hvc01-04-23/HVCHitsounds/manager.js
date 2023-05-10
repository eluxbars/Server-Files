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