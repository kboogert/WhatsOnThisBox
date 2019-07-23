# What On This Box

> Utility to save to a file all the stuff installed on this box.  This includes apps install in the /Application folder, as well as stuff install by Homebrew, and npm.

---

## Installation

1. Download this project zip file 

2. Unzip file in your home directory.

3. (Optional) Hide the directory by renaming with a leading period  
  ```shell
  $ mv WhatsOnThisBox .WhatsOnThisBox
  ```
4. (Optional) Add content to update.txt  
    This file will be inserted in the output file

5. Test installation  
    Manually run update.bash  
```shell
 $ bash ~/.WhatsOnThisBox/update.bash
```
- Check output
```shell
 $ cat .WhatsOnThisBox/WhatsOnThisBox.txt 
```

### Clone

- Clone this repo to your local machine using `https://github.com/kboogert/WhatsOnThisBox.git`

### Setup

To update the  WhatsOnThisBox.txt file
 1) To update the file daily at noon
    Put it in cron.  The example runs daily at noon
    ```shell
    $ crontab -e

    add following line (starting with 00)
      00 12 * * * source /Users/[YOUR_HOMEDIR]/.WhatsOnThisBox/update.bash
    ```
 2) To update the file at every login (maybe an overkill)  
     Add in .bash_profile.
 ```shell
     if [ -f "~/.WhatsOnThisBox" ]; then
         source  ~/.WhatsOnThisBox/update.bash
     fi
  ```
 3) Run manually
 ```shel
    $ bash ~/.WhatsOnThisBox/update.bash
```

---

## FAQ

- **Can I get npm install packages that are locally installed?**
    - Yes.  You will need to edit the update.bash and uncomment lines at about 43.  If you want other directorys and want to get the npm install, just add addition blocks like the one given.

  **Will these file fill up my directory?**
    - No. First if the content of the WhatsOnThisBox.txt is the same as the previous run, a new file is not saved.  Also only the 3 most recent output files are saved.  

---


## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2019 © <a href="http://www.boogert.com" target="_blank">Kent Boogert</a>


