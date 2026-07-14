import os
import io
from flask import Flask, request, render_template, jsonify
from dotenv import load_dotenv
from PIL import Image
from google import genai
from google.genai import types

load_dotenv()

app = Flask(__name__)

client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))
MODEL = "gemini-2.5-flash"


def pil_to_part(pil_img: Image.Image) -> types.Part:
    """Convert PIL Image → inline JPEG Part for the new SDK."""
    buf = io.BytesIO()
    if pil_img.mode in ("RGBA", "P", "LA"):
        pil_img = pil_img.convert("RGB")
    pil_img.save(buf, format="JPEG")
    return types.Part.from_bytes(data=buf.getvalue(), mime_type="image/jpeg")


@app.route("/", methods=["GET"])
def index():
    return render_template("index.html")


@app.route("/generate", methods=["POST"])
def generate():
    if "image" not in request.files or request.files["image"].filename == "":
        return render_template("index.html", error="No image uploaded.")

    try:
        pil_img = Image.open(request.files["image"].stream)
    except Exception as e:
        return render_template("index.html", error=f"Could not read image: {e}")

    prompt = (
    "You are a medical expert. Analyze this image and respond in clean HTML only.\n"
    "Use this exact structure depending on image type:\n\n"
    "For PRESCRIPTION:\n"
    "<div class='section'><h3>🧾 Prescription Details</h3>"
    "<table><tr><th>Medicine</th><th>Dosage</th><th>Frequency</th><th>Duration</th></tr>"
    "... rows ..."
    "</table></div>"
    "<div class='section'><h3>⚠️ Instructions</h3><ul>... key warnings only ...</ul></div>\n\n"
    "For MEDICAL IMAGE (X-ray/scan):\n"
    "<div class='section'><h3>🩻 Image Type</h3><p>...</p></div>"
    "<div class='section'><h3>✅ Normal Findings</h3><ul>... max 4 bullet points ...</ul></div>"
    "<div class='section'><h3>🔴 Abnormalities</h3><ul>... only if any, else write None ...</ul></div>"
    "<div class='section'><h3>📋 Conclusion</h3><p>... 2 lines max ...</p></div>\n\n"
    "Rules:\n"
    "- HTML only, no markdown, no backticks\n"
    "- Keep it SHORT and to the point\n"
    "- No long paragraphs\n"
    "- Professional and clean"
)

    try:
        response = client.models.generate_content(
            model=MODEL,
            contents=[prompt, pil_to_part(pil_img)],
        )
        return render_template("index.html", result=response.text)
    except Exception as e:
        return render_template("index.html", error=f"Unable to generate output: {e}")


if __name__ == "__main__":
    app.run(debug=True)