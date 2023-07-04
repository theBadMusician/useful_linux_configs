# Useful scripts, configs, and other goodies for Linux environment

---

## Enable global tty read/write privileges for all users

Run the following command in the terminal:
```bash
$ sudoedit /etc/udev/rules.d/50-myusb.rules
```

Add the following lines to the file:
```
KERNEL=="ttyUSB[0-9]*",MODE="0666"
KERNEL=="ttyACM[0-9]*",MODE="0666"
KERNEL=="tty[0-99]*",MODE="0666"
KERNEL=="ttyS[0-99]*",MODE="0666"
```
---

## Install multiple python versions on a Linux machine
Installing multiple versions of Python on a Linux machine can be done through a variety of ways. Here, I'll describe how you can do this using the pyenv utility, which allows you to easily switch between different Python versions.

1. **Install pyenv:**

First, you'll need to install some dependencies for `pyenv` and Python build:

```
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
```

Then, you can install `pyenv` using the `pyenv-installer` script:

```
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
```

2. **Add pyenv to bash so command line knows about it:**

Add `pyenv` to your `~/.bashrc`:

```
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
```

Restart your shell:

```
exec $SHELL
```

3. **Install Python versions:**

Now, you can install the versions of Python you need. For instance, to install Python 3.6.9, you would run:

```
pyenv install 3.6.9
```

Do the same for other versions you want to install. Use `pyenv install --list` to see available versions.

4. **Set Python versions:**

You can set the global Python version default with `pyenv global`. For example:

```
pyenv global 3.6.9
```

This makes Python 3.6.9 the default python when you open a new terminal.

You can also set local Python versions (for individual projects/directories) with `pyenv local`. If you're in a project directory and run:

```
pyenv local 3.8.5
```

Python 3.8.5 would be the default Python for that directory.

To switch between Python versions on the fly, you can use the `pyenv shell` command:

```
pyenv shell 3.8.5
```

Add the following to .bashrc:

```
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

This makes Python 3.8.5 the default Python for the current terminal session.

Remember to replace `3.6.9` and `3.8.5` with the actual versions of Python that you want to use. If you're not sure which versions of Python are installed, you can list them with `pyenv versions`.
