# 🚧 Linked State Machine (Experimental) 🧪

> ⚠️ **Note:**  
> This project is in the experimental phase and has not been tested for all possible cases. It may cause problems or fail.

---

## ❓ What is the Linked State Machine?

The **Linked State Machine** is a new approach to state machines, designed to address the challenge of running multiple states simultaneously.  
Traditional state machines typically execute one state at a time. When you need concurrent states, you usually have to create multiple state machines, which can be hard to synchronize.  
The Linked State Machine solves this by allowing multiple states to run in a linked, tree/graph-like structure.

---

## 🛠️ How Does It Work?

- **🌳 Structure:**  
  The Linked State Machine combines aspects of both trees and graphs. It is organized like a tree (with root and leaf nodes) but allows for more complex linking, similar to a graph.
- **🔗 Nodes:**  
  - **Root node:** The entry point of the state machine.
  - **Linked State nodes:** Each can be linked to multiple other states, which are activated as soon as the parent state starts.
- **🔄 Transitions:**  
  - States cannot transition themselves. Instead, they send transition requests to their parent node.
  - The parent decides whether to close the current branch and start new states or propagate the request further up.
  - If a state is already active, the system prioritizes transferring states instead of closing and reopening them.
- **♾️ Always Active Option:**  
  Any Linked State can be set as "always active," giving it root-like behavior with standard state functions (Enter, Exit, Update, StateInput).

---

## 🔁 How Does the Flow Work?

- The root node starts its linked states (one or more).
- Each state can start its own linked states, building a tree/graph of active states.
- When a state wants to transition, it sends a request up to its parent.
- The parent may handle the transition or pass it further up until the root node is reached.
- The system efficiently handles branches, only closing or transferring states as necessary.

---

## 💡 Potential Use Cases

> 📝 These are **theoretical examples** to show what the Linked State Machine could be used for.  
> **They are not included features or shipped content.**

- **General Use Case:**  
  ![General Use Case](Readme_Images/General_Use_Case.png "General Use Case")
- **FPS Game Example:**  
  ![FPS](Readme_Images/FPS_Example.png "FPS Game Example")
- **Monster Evolution Line:**  
  ![Monster Evolution](Readme_Images/Monster_Evolution_line.png "Monster Evolution Line")
- **Survival Game Stat System:**  
  ![Survival Game Stats](Readme_Images/Survival_Game_Stat_System.png "Survival Game Stat System")

---

## 📚 How to Use

- **📝 Documentation:**  
  There is currently no comprehensive documentation. Inline comments are provided where possible.  
  If you encounter confusion or missing comments, please open an issue and I will clarify and update as needed.
- **📖 Class Descriptions:**  
  Each class includes a description panel in the engine documentation for additional explanation.

---

## 📦 What’s Included in the Project?

- 🕹️ A simple example scene demonstrating a weapon slot/weapon selection system (inspired by the FPS example diagram).
- 🖨️ A Linked State Tree printer scene, which visualizes the currently active state tree for easier debugging and understanding.

---

💬 **If you have questions or suggestions, feel free to open an issue!**
