import socket
import cv2
import numpy as np

# IP address and port of the PC
PC_IP = '192.168.0.105'  # Replace with your PC's IP address
PORT = 5001

# Setup the UDP socket to receive data
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((PC_IP, PORT))

cv2.namedWindow('Received Video', cv2.WINDOW_AUTOSIZE)

# Define a buffer to hold the frame data
frame_data = bytearray()

# Define the maximum packet size
MAX_PACKET_SIZE = 1400

while True:
    # Receive data from the Zynq board
    data, addr = sock.recvfrom(MAX_PACKET_SIZE)
    
    if not data:
        continue

    # Append received chunk to the frame buffer
    frame_data.extend(data)

    # Check if we've received the entire frame (simple heuristic: end of JPEG frame)
    if len(data) < MAX_PACKET_SIZE:  # Assuming the last packet will be less than MAX_PACKET_SIZE
        # Decode the received frame
        np_data = np.frombuffer(frame_data, dtype=np.uint8)
        frame = cv2.imdecode(np_data, cv2.IMREAD_COLOR)

        # Clear the buffer for the next frame
        frame_data = bytearray()

        # Display the frame
        if frame is not None:
            cv2.imshow('Received Video', frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

sock.close()
cv2.destroyAllWindows()
