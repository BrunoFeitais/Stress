echo "Welcome to Linux stress test"
echo
echo

# Update the system and install the necessary tools (Lm-sensors and Stress)
apt-get -y install stress
apt-get -y install lm-sensors

# Make Lm-sensors detect all the sensors in the system
yes | sensors-detect

echo
echo
echo
echo " Please say how much time you want the stress test to be (in seconds)"
echo " and temperature sample time (in seconds)"
echo

# Read the time that the user wants the stress to be
read -p "Stress time (s): " tempoTotal
read -p "Sample time (s): " tempoSample

# Save all the stress options in the output temperature file
# StressTemperature.txt will also have all the read temperatures over the stress test
echo "Stress time (s): $tempoTotal seconds" >> ./StressTemperature.txt
echo "Sample time (s): $tempoSample seconds" >> ./StressTemperature.txt
echo "-------------------------------------------------" >> ./StressTemperature.txt
echo "" >> ./StressTemperature.txt
echo "" >> ./StressTemperature.txt

echo
echo "Stress Started"
echo

# The stress test with timout time chosen by the user
stress --cpu 10 --io 6 --vm 4 --vm-bytes 256M --timeout $tempoTotal+s &

# While cycle to read temperatures from the system
# It has a sample time chosen by the user
int=0
while [ $int -le $tempoTotal ]
do
    sensors | grep "temp1:" | tee -a ./StressTemperature.txt
    # sensors | tee -a ./StressTemperature.txt
    sleep $tempoSample
    int=$(( $int + $tempoSample ))
done

# The end 
echo
echo "Stress Completed"
echo

# https://www.youtube.com/watch?v=0FHEeG_uq5Y
