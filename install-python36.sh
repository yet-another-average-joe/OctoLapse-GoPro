echo
echo
echo "Python install script for Octopi/Octoprint"
echo
echo

##########################################
# asksure() function found on :
# https://stackoverflow.com/questions/25809999/press-y-to-continue-any-other-ke$
asksure() {
echo -n "This will install Python 3.6. Do you want to proceed (Y/N)? "
while read -r -n 1 -s answer; do
  if [[ $answer = [YyNn] ]]; then
    [[ $answer = [Yy] ]] && retval=0
    [[ $answer = [Nn] ]] && retval=1
    break
  fi
done

echo # just a final linefeed, optics...

return $retval
}

### using it
echo
echo
echo

if asksure; then
 echo "Installing Python 3.6"
else
 echo "Aborting installation..."
 exit
fi

echo "Installing Python 3.6..."
echo
echo



##########################################
# commands found on :
# https://liftcodeplay.com/2017/06/30/how-to-install-python-3-6-on-raspbian-linux-for-raspberry-pi/

apt-get update
# check build tools are installed
apt-get install build-essential checkinstall
#install libraries
apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
# change dirctory to /usr/src
cd /usr/src
# donwnload Python 3.6 sources archive
wget wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
# unzip sources
tar xzf Python-3.6.0.tgz
# change directory to sources
cd Python-3.6.0
# configure
bash configure
# compile and link ; -j3 makes compilation 2x faster
# (7:30 vs 15:30 on a RaspBerry Pi 3 B+
make -j3 altinstall
# return to root directory
cd /
echo
echo
echo
echo
echo
echo "test launch Python 3.6 : python3.6 command"
echo "type exit() to quit Python3.6"
echo
echo
python3.6

