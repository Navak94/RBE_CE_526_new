import cv2
import mediapipe as mp
from Functions import ProcessHandSteering


mp_hands = mp.solutions.hands
hands = mp_hands.Hands(max_num_hands=1, min_detection_confidence=0.5, min_tracking_confidence=0.5)


cap = cv2.VideoCapture(0)

while True:
    # frame is each frame
    success, frame = cap.read()
    if success:
        frame = cv2.flip(frame, 1) 
        h, w, _ = frame.shape

  
        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = hands.process(frame_rgb)

        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
		# This is the function that does all the processing
                turn_pwr, turn_dir = ProcessHandSteering(frame, hand_landmarks, False, h, w)
                # Print relevant values
                print(f"Turn Power: {turn_pwr}, Turn Direction: {turn_dir}")


        cv2.imshow('Video', frame)

    # Terminate on any key press
    if cv2.waitKey(1) != -1:
        break


cap.release()
cv2.destroyAllWindows()
