import socket
import cv2
import numpy as np

# Adresa IP a portului PC
PC_IP = '192.168.0.105'  # Se inlcuieste cu adresa IP a PC-ului
PORT = 5001

# Se set-uie up un socket UDP pentru a primi date
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((PC_IP, PORT))

cv2.namedWindow('Received Video', cv2.WINDOW_AUTOSIZE)

# Buffer pentru Frame Data
frame_data = bytearray()

# Dimensiunea maxima a unui pachet
MAX_PACKET_SIZE = 1400

while True:
    # Primeste date de la Zynq
    data, addr = sock.recvfrom(MAX_PACKET_SIZE)
    
    if not data:
        continue

    # Adauga bucatile de date primite la Frame Buffer
    frame_data.extend(data)

    # Verificare daca am primit un frame complet
    if len(data) < MAX_PACKET_SIZE:
        # Decodarea ultumului Frame primit
        np_data = np.frombuffer(frame_data, dtype=np.uint8)
        frame = cv2.imdecode(np_data, cv2.IMREAD_COLOR)

        # Clear Buffer pentru urmatorul frame
        frame_data = bytearray()

        # Afisare frame
        if frame is not None:
            cv2.imshow('Received Video', frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

sock.close()
cv2.destroyAllWindows()
