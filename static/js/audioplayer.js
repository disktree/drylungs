const player = document.querySelector( 'div.audioplayer' );
const audio = player.querySelector('audio');
const play = player.querySelector('.ic-play');
const stop = player.querySelector('.ic-stop');

audio.oncanplaythrough = e => {
	console.log(e);
}
audio.onended = e => {
	console.log(e);
}
audio.onplay = e => {
	console.log(e);
	player.classList.add('playing');
}
audio.onpause = e => {
	console.log(e);
	player.classList.remove('playing');
}

function playAudio() {
	audio.play();
}

play.onclick = function(e){
	console.log(e);
	playAudio();
}
stop.onclick = function(e){
	console.log(e);
	audio.pause();
}
