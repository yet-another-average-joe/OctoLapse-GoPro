echo
echo
echo "gopro-py-api install script for Octopi/Octoprint"
echo
echo

##########################################
# asksure() function found on :
# https://stackoverflow.com/questions/25809999/press-y-to-continue-any-other-ke$
asksure() {
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
echo -n "This will install gopro-py-api. Do you want to proceed (Y/N)? "

if asksure; then
 echo "Installing gopro-py-api"
else
 echo "Aborting installation..."
 exit
fi

echo "Installing gopro-py-api..."
echo
echo

git clone http://github.com/konradit/gopro-py-api
cd gopro-py-api
sudo python3.6 setup.py install

