import cv2
import socket

# IP address of the Zynq-7000 board
ZYNQ_IP = '192.168.1.10'  # Replace with your Zynq-7000 IP address
PORT = 5001

# Initialize the camera
cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Error: Could not open camera.")
    exit()

# Setup the UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_address = (ZYNQ_IP, PORT)

# Define the maximum packet size
MAX_PACKET_SIZE = 1400  # Keep it well below the typical MTU of 1500 bytes

try:
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Error: Failed to capture frame.")
            break

        # Encode the frame as JPEG
        ret, buffer = cv2.imencode('.jpg', frame)
        if not ret:
            print("Error: Failed to encode frame.")
            break

        # Convert the buffer to a byte array
        buffer = buffer.tobytes()

        # Break the buffer into chunks and send them
        for i in range(0, len(buffer), MAX_PACKET_SIZE):
            chunk = buffer[i:i+MAX_PACKET_SIZE]
            sock.sendto(chunk, server_address)

        # Display the frame (optional)
        cv2.imshow('Sending Video', frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
finally:
    cap.release()
    cv2.destroyAllWindows()
    sock.close()
