import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// var text = document.getElementById('text');
// var splitText = text.innerText.split('');

// text.innerHTML = '';
// i = 0
// setInterval(function(){
//   AddLetters()}
//   , 100 )

// function AddLetters(){
// if(i < splitText.length){
//   text.innerHTML += splitText[i];
//   i++;
// }
// }
