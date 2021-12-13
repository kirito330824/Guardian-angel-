## pip3 install firebase-admin
import os
import firebase_admin
from firebase_admin import messaging, credentials

def send_to_token(registration_token):
    # [START send_to_token]
    # This registration token comes from the client FCM SDKs.

    message = messaging.Message(
        notification=messaging.Notification(
            title='idinahui',
            body='this probably is the end of the world.',
        ),
        token=registration_token
    )



    # Send a message to the device corresponding to the provided
    # registration token.
    response = messaging.send(message)
    # Response is a message ID string.
    print('Successfully sent message:', response)
    # [END send_to_token]

def send_multicast():
    # [START send_multicast]
    # Create a list containing up to 500 registration tokens.
    # These registration tokens come from the client FCM SDKs.
    registration_tokens = [
        'YOUR_REGISTRATION_TOKEN_1',
        # ...
        'YOUR_REGISTRATION_TOKEN_N',
    ]

    message = messaging.MulticastMessage(
        data={'score': '850', 'time': '2:45'},
        tokens=registration_tokens,
    )
    response = messaging.send_multicast(message)
    # See the BatchResponse reference documentation
    # for the contents of response.
    print('{0} messages were sent successfully'.format(response.success_count))
    # [END send_multicast]


def send_multicast_and_handle_errors():
    # [START send_multicast_error]
    # These registration tokens come from the client FCM SDKs.
    registration_tokens = [
        'YOUR_REGISTRATION_TOKEN_1',
        # ...
        'YOUR_REGISTRATION_TOKEN_N',
    ]

    message = messaging.MulticastMessage(
        data={'score': '850', 'time': '2:45'},
        tokens=registration_tokens,
    )
    response = messaging.send_multicast(message)
    if response.failure_count > 0:
        responses = response.responses
        failed_tokens = []
        for idx, resp in enumerate(responses):
            if not resp.success:
                # The order of responses corresponds to the order of the registration tokens.
                failed_tokens.append(registration_tokens[idx])
        print('List of tokens that caused failures: {0}'.format(failed_tokens))
    # [END send_multicast_error]

path = os.getcwd()

cred = credentials.Certificate(path+"/a1816903/guardian-angel-a-firebase-adminsdk-nvsyj-25c86b0dea.json")
default_app = firebase_admin.initialize_app(cred)

print(default_app.name) 

temp_token = "chnlEpytrVk:APA91bG_cx8-1X7Ngkt2cCX04qOXl0YU3bcrk4BpqC5BREwLzTnlHuN4j4pmHDKECoq2isYd6ykZflG8kcgNvOKtq-yeapD4_NEm4EWAZoCpQgmBPlaXkgNsqqmwUlbDstkxsH1FCb8J" ## Oneplus 5T
temp_token1 = "dSbLOEOwevg:APA91bGvvktl39wN3y8c9OXpPDBq6ZBy1Yr2Fv77SeNFws6sLDsYGjFo2LKk-byav-rLQox_Voo1-ITxmO0YisAIVmLXb3Vw3Ql0w-ZBTjfBkiGpLueKNfrhngWt8F421cvcWrzcJAM5" ## School Phone @ Yan

send_to_token(temp_token1) ## YOUR_REGISTRATION_TOKEN

##https://firebase.google.com/docs/cloud-messaging/manage-tokens
##https://firebase.google.com/docs/cloud-messaging/send-message
## on Android  getToken() 