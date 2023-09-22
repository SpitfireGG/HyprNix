#!/run/current-system/sw/bin/bash


# Check if GammaStep is running
if pgrep -x "gammastep" >/dev/null; then
	# GammaStep is running, so kill it
	pkill -x gammastep
fi

# Check the provided flag
if [[ $1 == "-s" ]]; then
	# Start flag provided
	gammastep -O 1000 &
elif [[ $1 == "-e" ]]; then
	# End flag provided
    pkill gammastep 
else
	# Invalid flag provided
	echo "Invalid flag provided. Please use '-s' to start or '-e' to end."
fi
