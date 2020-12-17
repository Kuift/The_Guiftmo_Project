The following explain all use cases we want to solve for this mod

# CU01 - Player use a log trap spell

## CU01a - charging up charges

### prerequisite
- None

### postconditions
- New charges are available to cast for the log trap spell
- The spell UI show an greater number of charges on the log trap spell 

### Scenario

1. The player open the spell menu
2. The player press the charge up spell button
3. A typing game begin using onionlang (conlanguage) 
4. Player win the typing game 

### Alternative Scenario

4. Player lose the typing game
5. Player receive damage 

## CU01b - using a charge

### prerequisite
- The player has 1 log trap spell charge available

### postconditions
- One less charge is available to cast for the log trap spell
- The spell UI show an lesser number of charges on the log trap spell
- A trap object is attached to the log near the player

### Scenario

1. The player go near a log and physically touch it
2. The player open the spell menu
3. The player click on the log trap spell button
4. The game show a particle effect to show to the player that the spell worked