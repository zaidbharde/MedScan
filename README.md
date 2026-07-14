# 💊 Medicine Recognition System

An AI-powered Flask web app that identifies medicines from images and generates detailed, easy-to-understand medical information using Google's Gemini Vision API (`gemini-2.5-flash`).

Upload a photo of a medicine (or capture one live via camera), and the app analyzes it to provide composition, usage, dosage guidance, precautions, and specialist recommendations — with a clean dark-themed UI and bilingual (Hindi/English) support.

![Python](https://img.shields.io/badge/Python-3.10+-blue)
![Flask](https://img.shields.io/badge/Flask-Backend-black)
![Gemini](https://img.shields.io/badge/Google-Gemini%202.5%20Flash-orange)
![License](https://img.shields.io/badge/License-MIT-green)

---

## ✨ Features

- 📷 **Image Upload & Live Camera Capture** — analyze medicines via file upload or your device camera
- 🤖 **AI-Powered Recognition** — uses `gemini-2.5-flash` via the `google-genai` SDK for accurate medical analysis
- 🌗 **Dark/Light Mode** — polished dark-themed UI with toggle support
- 🌐 **Hindi/English Toggle** — view results in your preferred language
- 📜 **Analysis History** — past scans are saved and browsable
- 📄 **PDF Export** — download analysis reports as PDFs
- 🩺 **Specialist Suggestions** — recommends relevant doctor specialization with a direct Google Maps link to nearby options
- 📦 **Portable Setup** — one-click `RUN_ME.bat` installer with offline pip wheel support (no internet needed for install on repeat setups)

---

## 🛠️ Tech Stack

| Layer          | Technology                          |
|----------------|--------------------------------------|
| Backend        | Flask (Python)                      |
| AI Model       | Google Gemini 2.5 Flash (`google-genai` SDK) |
| Frontend       | HTML, CSS, JavaScript               |
| PDF Generation | (your PDF lib, e.g. `reportlab`/`weasyprint`) |
| Packaging      | `RUN_ME.bat` + offline pip wheels    |

---

## 🚀 Getting Started

### Prerequisites
- Python 3.10+
- A Google AI Studio API key ([get one here](https://aistudio.google.com/app/apikey))

### Option 1: Quick Setup (Windows)

1. Clone the repo:
   ```bash
   git clone https://github.com/zaidbharde/medicine-recognition-system.git
   cd medicine-recognition-system
   ```
2. Double-click `RUN_ME.bat` — it handles dependency installation (offline wheels included) and launches the app automatically.

### Option 2: Manual Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/zaidbharde/medicine-recognition-system.git
   cd medicine-recognition-system
   ```

2. **Create a virtual environment** (recommended)
   ```bash
   python -m venv venv
   venv\Scripts\activate      # Windows
   source venv/bin/activate   # macOS/Linux
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Set up your API key** (see below)

5. **Run the app**
   ```bash
   python app.py
   ```

6. Open your browser at `http://localhost:5000`

---

## 🔑 API Key Setup

This project uses the **`google-genai`** SDK with the **`gemini-2.5-flash`** model.

1. Get your API key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2. Create a `.env` file in the project root:
   ```dotenv
   GOOGLE_API_KEY=your_api_key_here
   ```
3. Keep this key private — never commit `.env` to version control.

> **Note:** This project has been migrated from the deprecated `google-generativeai` SDK to the current `google-genai` SDK to avoid 404/401/405/503 errors from older API versions.

---

## 📸 Screenshots

*(Add screenshots of the dark-mode UI, camera capture, and PDF report here)*

---

## 🗺️ Roadmap

- [ ] Add support for multiple medicine detection in a single image
- [ ] Expand specialist database with more granular recommendations
- [ ] Add multi-user login and cloud sync for history

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Found a bug or have a suggestion? Open an issue!

---

## ⚠️ Disclaimer

This tool is intended for **informational purposes only** and does not substitute professional medical advice. Always consult a licensed healthcare provider before making any medical decisions.

---

## 📄 License

Licensed under the [MIT License](LICENSE) — feel free to use, modify, and distribute with attribution.

---

## 📬 Contact

**Zaid Bharde**
GitHub: [@zaidbharde](https://github.com/zaidbharde)
