import cv2
import socket

# Adresa IP a placutei Zynq7000
ZYNQ_IP = '192.168.1.10'  # Se va inclocuii cu adresa IP a placutei Zynq7000
PORT = 5001

# Initializeaza Camera
cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Error: Nu s-a putut deschide camera.")
    exit()

# Setup pentru UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_address = (ZYNQ_IP, PORT)

# Dimensiunea maxima a unui Pachet
MAX_PACKET_SIZE = 1400

try:
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Error: Fail la captarea unui Frame.")
            break

        # Encode the frame as JPEG
        ret, buffer = cv2.imencode('.jpg', frame)
        if not ret:
            print("Error: Fail la Encode a unui Frame.")
            break

        # Conversia a buffer-ului la un vector pe bytes
        buffer = buffer.tobytes()

        # Buffer-ul se va sparge in mai multe bucati si apoi trimise
        for i in range(0, len(buffer), MAX_PACKET_SIZE):
            chunk = buffer[i:i+MAX_PACKET_SIZE]
            sock.sendto(chunk, server_address)

        # Afiasarea fiecarui frame
        cv2.imshow('Sending Video', frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
finally:

    cap.release()
    cv2.destroyAllWindows()
    sock.close()
