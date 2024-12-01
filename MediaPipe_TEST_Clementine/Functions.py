import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist
import mediapipe as mp

# Initialize ROS 2
rclpy.init()

class TeleopNode(Node):
    def __init__(self):
        super().__init__('teleop_node')
        self.publisher = self.create_publisher(Twist, '/cmd_vel', 10)

    def publish_twist(self, linear_x, angular_z):
        twist = Twist()
        twist.linear.x = linear_x
        twist.angular.z = angular_z
        self.publisher.publish(twist)


#teleop node instance
teleop_node = TeleopNode()


mp_hands = mp.solutions.hands

TURN_LIMIT = 0.5
TURN_POWER_TUNING = 0.05

def ProcessHandSteering(frame, hand_landmarks, display, h, w):

    #Get x-coordinates of index and pinky knuckles
    index_kn = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_MCP]
    pinky_kn = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_MCP]

    index_kn_x = int(index_kn.x * w)
    pinky_kn_x = int(pinky_kn.x * w)

    # calculate direction and power
    turn_direction = index_kn_x - pinky_kn_x
    turn_power = max(TURN_LIMIT, abs(turn_direction) * TURN_POWER_TUNING)
    turn_power -= TURN_LIMIT

    if turn_direction > 50:
        turn_dir = 1  
        teleop_node.publish_twist(0.0, 1.0)  # right turn
    elif turn_direction < -50:
        turn_dir = -1 
        teleop_node.publish_twist(0.0, -1.0)  #left turn
    else:
        turn_dir = 0 
        teleop_node.publish_twist(1.0, 0.0)  # slowly move forward

    return turn_power, turn_dir

