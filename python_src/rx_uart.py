import sys
import serial


def ascii_a_binario(letra):
    # Extraer su valor entero
    valor = ord(letra)
    # Convertirlo a binario
    return "{0:08b}".format(valor)


def binario_a_decimal(binario):
    posicion = 0
    decimal = 0
    # Invertir la cadena porque debemos recorrerla de derecha a izquierda
    # https://parzibyte.me/blog/2019/06/26/invertir-cadena-python/
    binario = binario[::-1]
    for digito in binario:
        # Elevar 2 a la posición actual
        multiplicador = 2**posicion
        decimal += int(digito) * multiplicador
        posicion += 1
    return decimal


def to_hexadecimal(value):
    decimal = int(value, 2)
    hexadecimal = hex(decimal)
    return hexadecimal


ser = serial.Serial('/dev/ttyUSB0', 9600)
ser.timeout = 5

while True:
    received_data = ser.read(1)
    if ((received_data) and (received_data != b'\n')):
        print(f'\rbinary: {ascii_a_binario(received_data)}\t'
              f'Decimal: {binario_a_decimal(ascii_a_binario(received_data))}\t'
              f'Hex:{to_hexadecimal(ascii_a_binario(received_data))}\t',
              end='')
    # print(received_data)
    # if counter == 0:
    #     print('Receiving data: \r\n')
    # elif counter == 7:
    #     ascii_str = chr(int(received_data.decode(), 2))
    #     print(f'binary: {received_data}\n' +
    #           f'hex: {to_hexadecimal(received_data)}\n' +
    #           f'ascii: {ascii_str}\n', end='')
    #     received_data = b''
    #     print("\nFlags received xxxx xxZC:\n")
    # elif counter == 15:
    #     print(f'binary: {received_data}\n')
    #     counter = -1
    #     received_data = b''
    #
    # counter = counter + 1
