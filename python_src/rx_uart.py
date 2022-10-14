import sys
import serial
from time import sleep

received_data = b''
counter = 0


def to_hexadecimal(value):
    decimal = int(value, 2)
    hexadecimal = hex(decimal)
    return hexadecimal

ser = serial.Serial('/dev/ttyUSB0', 19200)
ser.timeout = 5


while True:
    received_data = received_data + ser.read()
    sleep(.03)

    if counter == 0:
        print('Receiving data: \r\n')
    elif counter == 7:
        ascii_str = chr(int(received_data.decode('ascii'), 2))
        print(f'binary: {received_data}\n' +
              f'hex: {to_hexadecimal(received_data)}\n' +
              f'ascii: {ascii_str}\n', end='')
        received_data = b''
        print("\nFlags received xxxx xxZC:\n")
    elif counter == 15:
        print(f'binary: {received_data}\n')
        counter = -1
        received_data = b''

    counter = counter + 1
