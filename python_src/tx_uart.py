import sys
import serial

try:
    ser = serial.Serial('/dev/ttyUSB0', 115200)
    ser.timeout = 5
except:
    sys.stderr.write('An ERROR ocurred while trying open the serial port')
    sys.exit(1)
    
while True:
    str_input = input('Write data to be sent through the serial port')
    ser.write(str_input.encode('ascii'))
