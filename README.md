## Note: This project is still in experimental phase and hasn't been tested for the possible cases. It may cause problems or fail.
# Linked State Machine
## Description:
Linked State Machine is a variation of normal state machine which tackles the most common problem with state machines which is the lack of simultaneous State. State Machine works by running one state at a time. However, in case when multiple states need to runtime simultaneously. Their is no direct way but to create multiple State Machine even then the synchronization is not easy between such state Machines. As such under this idea this Linekd State Machine was developed.

## How it works?
Linked State Works by following the working of tree (Data Structure) or Graph (Data Structure) depending on how you wanna see it. Just like how a tree data structure is made up root node and leave nodes. The Linked State Machine is made up of Linked State root node and Linked State respectively. Just like a normal state machine no state can actively decide if they can or cannot transition to the next state but instead the work is left to the parent node which acts as the state machine node. It receives a transition request from its children linked state nodes and then is responsible for closing the current state, deattaching it from self, starting the next start and then attaching it. The main idea is how each leaf node can be linked to n numbers of more leave nodes. Each Linked state has a property "Linked State" which are states that are linked to that state and it will activate all those states as soon as it itself starts. The overall working can be considered to work like how tree data structure works.

## Thorough Explanation of Working if needed:
Linked state root acts as the main root node like a tree root. It starts its linked states. Which could be just on state or n states. Further states will start their own linked states and the process repeats until all linked states starts. After the tree is constructed all the states will start working and start doing their isolated work. Linked States are not capable (and should ideally be permitted) to directly transition to the next state(s) by themselves instead if they want to go to the next state they send a transition request to the state that started them. Which in term then decides if they can transition or not. They will be responsible for closing the whole branch of the sender state and starting the next states. While sending the transition request the receiving state can also decide to send the request further up in the link instead. The link can keep on travelling up the tree until a node decides either to stop and close the whole branch from which the signal is associated to or until it reaches the root node which does not propagate the signal any further and only performs the transition. If a state has a linked state that was already active. The states prioritize transfer of states before closing them for efficiency. Apart from that their is also the option to select "is always active" for Linked state which will make them act completely as a Linked State root node which has the capabilities of a State (functionalities such as Enter, Exist, Update, StateInput which is not a part of Root Node)

## Some Use Case Examples:
These example are not tried and tested but only thought of as plausible applications


![General Use Case](Readme_Images/General_Use_Case.png "General Use Case")
### General Use Case
![FPS](Readme_Images/FPS_Example.png "FPS Game Example")
### FPS Game Example
![Monster Evolution](Readme_Images/Monster_Evolution_line.png "[Monster Evolution Line")
### Monster Evolution Line
![Survival Game Stats](Readme_Images/Survival_Game_Stat_System.png "Survival Game Stat System")
### Survival Game Stat System

## How to use it?
For now their is no absolute documentation for how to use them but I'll try to add comments wherever seems necessary to make the working more understandable. For now please raise an issue if you don't understand anything from the already existing comments or if they're missing and I'll try to give an explanation as well as update the comments. The explanation can also be found in the Engine docs which has a desciption panel for each declared class.

## What the project already includes?
The project comes with a simple example scene to test how to make the weapon slot/weapon Selection system from the FPS Example diagram which is designed in more of a general sense. It also include a Linked State Tree printer which is a scene and can be used to print the currently active tree for better visualization of whats going on.
