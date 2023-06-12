// Sélectionner l'élément contenant le texte
const textElement = document.getElementById('text2');

// Tableau des mots à afficher
const words = ['Pixy', 'Secure'];

// Index du mot courant
let currentWordIndex = 0;

// Fonction pour changer le mot
function changeWord() {
  // Obtenir le mot suivant dans le tableau
  currentWordIndex = (currentWordIndex + 1) % words.length;
  const nextWord = words[currentWordIndex];

  // Remplacer seulement le mot "Pixy" dans le texte
  const currentText = textElement.textContent;
  const newText = currentText.replace('Pixy', nextWord);

  // Mettre à jour le texte de l'élément
  textElement.textContent = newText;
}

// Appeler la fonction de changement de mot toutes les 5 secondes
setInterval(changeWord, 5000);
