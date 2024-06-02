# Set Card Game Application

Welcome to the Set Card Game application! This project recreates the classic card game "Set" using SwiftUI. In this README, you'll find information about the game rules, features of the application, and details about the UI and animations.

## Game Rules

The game of Set is played with a unique deck of cards. Each card has four attributes:

- **Number**: One, two, or three symbols.
- **Shape**: Diamonds, squiggles, or ovals.
- **Shading**: Solid, striped, or open.
- **Color**: Red, green, or purple.

A *set* consists of three cards that satisfy all of the following conditions:

- They all have the same number or have three different numbers.
- They all have the same shape or have three different shapes.
- They all have the same shading or have three different shadings.
- They all have the same color or have three different colors.

The rule of thumb for determining a set is: *If you can sort a group of three cards into "two of ____ and one of ____", then it is not a set.*

### Example of a Set

The following cards form a set:

- One red striped diamond
- Two red solid diamonds
- Three red open diamonds

## Application Features

### User Interface

The UI of the Set Card Game application is designed to be clean and intuitive. The main components include:

- **Deck**: The pile of cards that players draw from. 
- **Board**: The area where cards are laid out for players to examine and form sets.
- **Discard Pile**: The area where matched sets are placed.

### Animations

Animations are a key feature of this application, providing a smooth and visually appealing experience. Here are the main animations used:

- **Drawing Cards**: When cards are drawn from the deck, they animate by flying from the deck to their positions on the board.
- **Discarding Sets**: When a set is correctly identified and selected, the cards fly from the board to the discard pile.

## Screenshots and GIFs



https://github.com/mattauc/SetGame/assets/63832577/4374b253-874a-477c-9bf5-275b3471f004



## How to Play

1. **Start a New Game**: Tap the "Restart" button to shuffle the deck and deal cards onto the board.
2. **Select Cards**: Tap on any three cards that you believe form a set. If the selection is a valid set, the cards will animate to the discard pile, and new cards will be drawn from the deck to replace them.
3. **Identify Sets**: Continue selecting sets until there are no more sets available on the board or the deck is empty.
