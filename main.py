from flask import Flask, jsonify, request
from google.cloud import vision
import io
import os
import base64

app = Flask(__name__)

# Set up Google Cloud Vision credentials
credential_path = "/Users/olivia/Desktop/Python/picSpeaks/picspeaks-a4f0b99603cc.json"
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credential_path

# Create a Google Cloud Vision client
client = vision.ImageAnnotatorClient()

# Endpoint to handle image upload and display it (for testing)
@app.route('/upload', methods=['POST'])
def upload_image():
    try:
        # Get the JSON data from the request
        data = request.get_json()

        # Get the base64-encoded image from the request
        base64_image = data['image']

        # Decode the base64-encoded image
        image_data = base64.b64decode(base64_image)

        # Save the image temporarily for viewing (you can skip this if not needed)
        with open("/Users/olivia/Desktop/Python/picSpeaks/assets/uploaded_image.jpg", "wb") as f:
            f.write(image_data)

        # Create an image object for Google Cloud Vision
        image = vision.Image(content=image_data)

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

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
