from flask import Flask, jsonify
from google.cloud import vision
import io
import os

app = Flask(__name__)

# Set up Google Cloud Vision credentials
credential_path = "/Users/olivia/Desktop/Python/picSpeaks/picspeaks-a4f0b99603cc.json"
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credential_path

# Create a Google Cloud Vision client
client = vision.ImageAnnotatorClient()


# Simple Hello, World! endpoint
@app.route('/')
def helloworld():
    return 'Hello, World!', 200


# New endpoint to trigger Google Cloud Vision and return full label annotations
@app.route('/vision', methods=['GET'])
def access_vision_api():
    try:
        # Path to the image file (for now, hard-coded)
        image_path = "/Users/olivia/Desktop/Python/picSpeaks/assets/panda.jpg"  # Replace with your image file

        # Read the image file
        with io.open(image_path, 'rb') as image_file:
            content = image_file.read()

        # Create a Vision API image object
        image = vision.Image(content=content)

        # Perform label detection on the image
        response = client.label_detection(image=image)

        # Extract the full label annotations
        label_annotations = response.label_annotations

        # Convert the label annotations into a list of dictionaries to return as JSON
        labels = []
        highest_score_label = None
        highest_score = 0.0  # Initialize highest score

        for label in label_annotations:
            label_info = {
                'mid': label.mid,
                'description': label.description,
                'score': label.score,
                'topicality': label.topicality
            }
            labels.append(label_info)

            # Check if this label has the highest score
            if label.score > highest_score:
                highest_score = label.score
                highest_score_label = label_info['description']  # Store the description

        # Return the full label annotations and the label with the highest score
        return jsonify({
            'labels': labels,
            'highest_score_label': highest_score_label,
            'highest_score': highest_score
        }), 200

    except Exception as e:
        return jsonify({
            'error': str(e)
        }), 500

    # Main block to run the Flask app
if __name__ == '__main__':
    # Host the Flask app on all network interfaces (0.0.0.0) so it can be accessed externally
    app.run(host='0.0.0.0', port=8000)