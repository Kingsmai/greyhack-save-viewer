# Roadmap

## Player Information

> Data from Player Database

- [x] Main Information
  - [x] Player ID
  - [x] Computer List
    - [x] First is the main pc (With UUID)
    - [x] Then follow by Rented Server
    - [ ] Double Click and jump to his main computer details
  - [x] Player Location (`infoMapX`, `infoMapY`)
  - [x] Game Over Times
  - [x] Last Connection
  - [x] Bank account
  - [x] Email address
- [x] Player Storage
  - [x] List with computers
    - [x] Different Categories
      - [x] Hard Disk List
      - [x] CPU List
      - [x] GPU List
      - [x] Motherboard List
      - [x] RAM List
      - [x] PSU List
      - [x] Net Devices List
    - [x] Each item's detail
- [ ] Mission List
  - [ ] Target User
  - [ ] Any User? Haven't know what this mean (Maybe for "Getting Credentials")
  - [ ] Type Mission, Need to figure it out every enum's Meaning
  - [ ] Target Computer ID
  - [ ] Reputation (Maybe it is a positive & negative value? since it was `1`)
  - [ ] Karma (Same as above)
- [x] Selling Hardware Shop (List)
- [ ] **No data yet**
  - [x] Wallet ID (Got no data yet, maybe need rep of 2, **Temp write at player detail part**)
  - [x] Wallet Password (Got no data yet, **Temp write at player detail part**)
  - [ ] Stock Info
  - [x] Login Data???(**Temp write at player detail part, as a code block**)
  - [ ] Zero Day Request
  - [ ] Bank Traces (Think it is the 10s ~ 15s temp data, not useful)

### Player Viewer Improvement

- [ ] Item device key translation to more readable
- [ ] Item detail enum translation, progress bar and etc.

## Computer Information

- [x] Computer List (Group by IP, Use the old implementation)
  - [x] List Icon
  - [x] Open with tab
- [x] Computer Details
  - [x] Is Router
  - [x] Is Player
  - [x] Is Rented
  - [x] Is CTF
- [x] File System (Use the old implementation)
- [x] File Details (Use the old implementation)
  - [ ] More File Details
    - [ ] Command
    - [ ] Symlink
    - [ ] Size
    - [ ] Process
    - [ ] serverPath
    - [ ] missionId
    - [ ] typeFile
- [x] File Viewer (Use the old implementation)
- [ ] Open With Option
  - [ ] Parse data from JSON to visualized view
  - [ ] Parse data from XML to visualized view
  - [ ] Prettify source codes
  - [ ] Highlight gdscript, html, json, xml
  - [ ] Decrypt password files
- [ ] Smart Open File (file type detection)
- [x] Installed hardware
  - [x] Hard Disk
  - [x] CPUs (list)
  - [x] RAMs (list)
  - [x] GPU
  - [x] Power Supply
  - [x] Motherboard
  - [x] Network Devices (list)
- [x] Registered User List (Use the old implementation)
  - [x] Username
  - [x] Group (List)
  - [x] Encrypted Password
  - [x] Plain Password
  - [x] Is Deletable
  - [x] Total Experience
  - [x] Karma
    - [x] Current Karma
    - [x] Previous Karma
    - [x] Pending Mission
- [ ] Process List
- [x] Config OS (Raw View)
- [ ] **Huge problem**
  - [ ] Config OS
    - [ ] Analysis for computer ConfigOS
    - [ ] Analysis for router Config OS
    - [ ] Is there any other Config OS?