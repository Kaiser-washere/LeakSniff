#  LeakSniff

<p align="center">
A prototype data leak scanner toolkit built with Ruby and Python orchestration.  
LeakSniff unifies multiple modules under a single CLI with banner-styled output and logging.  
</p>

<hr/>

<hr/>

## Features
- **Unified CLI:** `leaksniff.rb` calls all modules through a single menu.  
- **Modules:** Username scan (GitHub), Email leak check (BreachDirectory), Password leak check (PwnedPasswords), Domain exposure, Metadata sniff, Offline CSV scan.  
- **Logging:** Each run is saved into `logs/scan.log`.  
- **Colored output:** ANSI colors + ASCII banner for distinctive CLI identity.  
- **Modular design:** Easily extendable with new sources or modules.  

<hr/>

##  Installation

```bash
git clone https://github.com/yourname/LeakSniff.git
cd LeakSniff

# Ruby gem dependencies
gem install exifr
gem install resolv
```
<hr/>

 Usage
bash
ruby leaksniff.rb
CLI flow:

Banner and menu are displayed.

User selects scan type (username, email, password, domain, metadata, offline CSV).

Selected module runs and prints output.

Results are logged into logs/scan.log.

Python automation (leak.py):

bash
python3 leak.py
1: Add breaches (email, source, date separated by commas).

2: Add subdomains (comma separated).

3: Start (prepare datasets).

<hr/>

⚙️ Requirements
Ruby 3.0+

Python 3.10+

GitHub API Personal Access Token (for username scan module)

<hr/>

📜 License
MIT License

Prototype release — for educational and research purposes only.
Do not use for unauthorized access or illegal activities.

<hr/>

<h1>
⚠️ Notes
This project has not been thoroughly tested.
Several modules contain errors (especially GitHub and BreachDirectory integrations).
The code is not fully developed and has not been optimized for security or performance.
It should only be used for learning and testing purposes.
</h1>

<h1>educational use only</h1>
