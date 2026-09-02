<p align="center">
  <img src="https://github.com/user-attachments/assets/e80e6c1c-e903-418a-9639-5a75bc04e849" alt="game_banner" width="100%" />
</p>
<p align="center">
<img width="856" height="243" alt="crusade image" src="https://github.com/user-attachments/assets/1b59a280-9d7c-4e89-9654-ef5862859a14" />
</p>

<p align="center">
  <a href="https://ultrala.itch.io/crusade?secret=0qNZi4fWMvZbj9LkHpkoDs9k0"><img src="https://img.shields.io/badge/Play_on-Itch.io-ff2449?style=for-the-badge&logo=itch.io&logoColor=white" alt="Play on Itch.io" /></a>
  <img src="https://img.shields.io/badge/Engine-Godot_4.6-478cbf?style=for-the-badge&logo=godotengine&logoColor=white" alt="Godot Engine" />
</p>

---

## About the Game
It is a roguelike action bullet hell with elements from Soulknight and Binding of isaac. Assets are primarily from [Kenney's](https://kenney.nl/assets/desert-shooter-pack) desert shooter asset pack with the rest being left overs from a tutorial I did way before Crusade started.

### Control Scheme
| Action | Mouse and Keyboard |
| :--- | :--- |
| Move | <kbd>W</kbd> <kbd>A</kbd> <kbd>S</kbd> <kbd>D</kbd> or <kbd>Up</kbd> <kbd>Down</kbd> <kbd>Left</kbd> <kbd>Right</kbd> |
| Dash | <kbd>Shift</kbd> |
| Interact | <kbd>R</kbd> |
| Slot 1 attack | <kbd>Left-Click</kbd> |
| Slot 2 attack | <kbd>Right-Click</kbd> |

---

## Procedural Generation
Due to time constraints for the game I ended up going with a Binding of isaac stype procedural generation for the game. Every room is connected to every room by doors and moving from one room to another moves the camera to the center of the new room.

<p align="center">
  <img width="480" height="270" alt="Room Transition gif" src="https://github.com/user-attachments/assets/146cf2c0-3268-446e-8360-31d9027f3cf5" />
</p>

<details>
<summary><b>Indepth details are provided below</b></summary>
<br>

In the dungeon generator script we have variable for the rooms for a given level . We then create a dictionary of room direction from center and the room type of that room. We then take a random direction **`Up`**, **`Down`**, **`Left`**, **`Right`** and adds it to the last known position. So if we started at `{(0,0), Spawn}` we would add a random direction say **`Up`** to get `(0,1)` [using `Vectori.Up` in Godot] and add to the dictionary to get a new direction `{(0,1), Combat}`. 

We do this till we reach the max_rooms for a given level then we do some further assigments ( one shop per room, Breadth first search to get furthest room so that is boss/transition room) and we then spawn the rooms at that location.

While it is fairly simple ( in the context of procedural generation) it does force a lot of level design to be placed on the quality of the rooms themselves since all rooms are the same size.
</details>

---

## Weapons
There are 14 weapons available (more to come) with basically 3 weapon types [`Burst`, `Shotgun`, and `Normal` with plans for `Laser`]. 

Weapons are differentiated by weapons stat, look and projectile type [`Bouncing`, `Cluster`, and `Sine` with plans for `Homing`].
<p align = "center">
<img width="1920" height="1080" alt="Screenshot 2026-09-02 191400" src="https://github.com/user-attachments/assets/55af1775-7423-47d1-af98-0b66c710d199" />
</p>
---

## Game Loop
As of now the player gains coins from killing enemies and uses that to buy more weapons. Since it is a roguelike death means starting over from the beginning. The loop is mainly kill gain money and gain weapons.
Later on i will be planning to add things like Secret levels and achievements.


## Running the Game
To play a demo of the game (i.e the whole game), go to the itch.io site and play the demo or download the crusade.exe file for windows : [Play on itch.io](https://ultrala.itch.io/crusade) 

If this is not available you should be able to get the exe file from Godot. 
Follow the steps below to to directly get the game file from Godot.

### Prerequisites
* **Godot Engine**: Download **Godot 4.6** from the [official Godot website](https://godotengine.org/download/windows/).
* **Git** or [**GitHub Desktop**](https://desktop.github.com/download/): Installed on your computer.

### 1. Clone the Repository
Choose one of the following methods to download the project files:

#### Option A: Using GitHub Desktop (Recommended for beginners)
1. Open **GitHub Desktop**.
2. Click **File > Clone Repository...** in the top menu.
3. Select the repository from your list or click the **URL** tab and paste the repository URL: `https://github.com/Ultralak/Crusade`.
4. Choose a local directory on your computer to save the project files.
5. Click **Clone**.

#### Option B: Using Git Command Line
Open your terminal or command prompt and run:
```bash
git clone [https://github.com/Ultralak/Crusade](https://github.com/Ultralak/Crusade)
cd Crusade
```


### 2. Import the Project into Godot

1. Launch **Godot Engine** to open the Project Manager.
2. Click the **Import** button on the top-right menu.
3. Click **Browse** and navigate to the folder where you cloned the repository.
4. Select the `project.godot` file and click **Open**.
5. Click **Import & Edit** to open the project inside the Godot editor.

### 3. Test and Play in the Editor

* Press **F5** (or click the **Play** button in the top-right corner) to launch the main game scene.
* To test an individual scene (such as a test level or character scene), open the scene file (`.tscn`) in the FileSystem dock and press **F6**.

### 4. Export the Standalone Executable

1. Navigate to **Project > Export...** in the top menu bar.
2. Click **Add...** at the top of the window and select your target platform (e.g., *Windows Desktop*, *macOS*, *Linux*, or *Web*).
3. **Download Export Templates** *(First-time setup only)*: If a warning appears stating templates are missing, click **Manage Export Templates** -> **Download & Install**.
4. Select your target preset and click **Export Project...** at the bottom.
5. Choose an output folder outside your project files, enter a name, and click **Save**.

### 5. Play the Standalone Build

Navigate to your export folder and run the generated application file (`.exe` on Windows, `.x86_64` on Linux, or open `index.html` in a browser for Web exports) to play the game without needing the editor.

```

```
