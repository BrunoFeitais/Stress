Simple Stress Test ready to be used on Linux sytems,

Automated install of necessary tools.

User can chose how much time the stress should take and temperature sample time (time between temperature read).
All the temperatures are saved on a txt file in the same directory of the shell script.


ATTENTION:
If you do not get any temperature, change line 43 ->  sensors | grep "temp1:" | tee -a ./StressTemperature.txt  <-. Change the "temp1:" parameter of grep or uncomment line 44 ;)
