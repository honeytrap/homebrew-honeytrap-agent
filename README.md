homebrew-honeytrap-agent
===============
[![Build Status](https://travis-ci.org/honeytrap/homebrew-honeytrap-agent.svg?branch=master)](https://travis-ci.org/honeytrap/homebrew-honeytrap-agent)

Homebrew formula for honeytrap-agent.

## Usage

```bash
$ brew install honeytrap/stable/honeytrap-agent
```

## Configuration

Edit the file `/usr/local/etc/honeytrap-agent` and configure the server and remote-key.

## Install LaunchDaemon

```
sudo cp /usr/local/Cellar/honeytrap-agent/agent/homebrew.mxcl.honeytrap-agent.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/homebrew.mxcl.honeytrap-agent.plist
```

### Loading the Agent

```
launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.honeytrap-agent.plist
```

### Unloading the Agent

```
launchctl unload -w /Library/LaunchDaemons/homebrew.mxcl.honeytrap-agent.plist
```
