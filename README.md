# image_processor
Image Processing System

Welcome to the Image Processing System! This project processes images from a CSV file, compresses them, and provides status updates via APIs. Follow these steps to set it up from GitHub.

Quick Start

1. Clone the Repository

git clone https://github.com/your-username/image_processor.git
cd image_processor

2. Install Dependencies

npm install

3. Configure Database

Create a MySQL database:

CREATE DATABASE image_processing;

Update .env with your database credentials:

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=image_processing



4. Start Services

5. Run the Project

Worker: node worker.js (in one terminal).
API: node server.js (in another terminal).

6. Test It

Upload a CSV via http://localhost:8000/upload (see SETUP.md for details).

Check status at http://localhost:8000/status/<request_id>.

Requirements

Node.js 16+

MySQL

Redis

Git (optional)

Detailed Setup

See SETUP.md for step-by-step instructions, perfect for beginners!

Project Details

Check PROJECT_DESCRIPTION.md for features, components, and code explanations.

