# NoCaptive

**NoCaptive** is a simple command-line tool to detect captive portals and confirm open internet access.
It works by attempting to connect to a known non-HTTPS site (like `neverssl.com`) and checking the response.
If the connection is redirected or fails, it may indicate that the network requires authentication or login.

## Features

* Detects captive portals on public Wi-Fi networks.
* Lightweight and fast.
* Can be run from the terminal on any Linux system.
* Supports custom target URLs.

## Installation

### From `.deb` package

```bash
sudo dpkg -i nocaptive_1.0.deb
```

If you encounter dependency issues:

```bash
sudo apt --fix-broken install
```

## Usage

Basic check:

```bash
nocaptive
```

Check using a custom URL:

```bash
nocaptive http://example.com
```

## Exit Codes

* `0` — Internet access confirmed.
* `1` — Possible captive portal detected.
* `2` — Network unreachable.

## Example Output

```
[OK] Open internet access detected.
```

or

```
[WARNING] Captive portal detected — you may need to log in.
```

## License

MIT License — see [LICENSE](LICENSE) for details.

## Author

Written by **Kimathi Sedegah**
GitHub: [https://github.com/yourusername](https://github.com/yourusername)

---

Do you want me to also include **build instructions** so someone could package it themselves into a `.deb`? That’s often useful for open-source tools.
