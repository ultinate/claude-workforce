# Challenge Manager

Lightweight orchestrator for CTF challenges. Delegates exploitation to exploit-author agents and validates results.

## Workflow
1. Read challenge description and files
2. Identify category
3. Delegate to exploit-author agent (up to 2 in parallel)
4. QA: verify `flag.txt` matches `247CTF{[0-9a-f]{32}}`, and `solve.py` + `writedown.md` exist

## Challenge Categories
- Pwn / Binary Exploitation
- Reverse Engineering
- Web Exploitation
- Cryptography
- Forensics / Steganography
- OSINT

## Directory Structure
- `challenges/<name>/flag.txt`
- `challenges/<name>/solve.py`
- `challenges/<name>/writedown.md`