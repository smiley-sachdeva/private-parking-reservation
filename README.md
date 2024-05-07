# Private Parking Reservation API

Welcome to the Private Parking Reservation API! This API allows you to manage reservations for parking slots in a private parking facility. You can create, update, cancel, and retrieve reservations, as well as manage parking slots and features.

# Getting Started

To get started with the Private Parking Reservation API, follow these steps:

1. Clone the Repository: Clone this repository to your local machine using the following command:

    ```bash
    git clone https://github.com/smiley-sachdeva/private-parking-reservation.git

2. Install Dependencies: Navigate to the project directory and install the dependencies using Bundler:

    ```bash
    cd private-parking-reservation
    bundle install
    
3. Set Up the Database: Run the database migrations to create the necessary tables:
   
    ```bash
    rails db:create
    rails db:migrate
  
4. Start the Server: Start the Rails server to run the API:
      ```bash
      rails server
      
5. Explore the API: The API documentation can be found at [API Documentation](https://documenter.getpostman.com/view/33525206/2sA3JJ82rr).

# API Documentation

For detailed documentation on the API endpoints and how to use them, refer to the [API Documentation file](https://documenter.getpostman.com/view/33525206/2sA3JJ82rr).

# ERD 

![ERD](https://github.com/smiley-sachdeva/private-parking-reservation/blob/main/db_erd.png?raw=true)

# Features

**1. User Authentication:**  Secure user authentication using Devise.

**2. Reservation Management:**  Create, update, cancel, and retrieve reservations for parking slots.

**3. Slot Management:** Manage parking slots, including their availability, features, and pricing.

**4. Feature Filtering:** Filter slots based on features such as shade, accessibility, and more.

**5. Cancellation Policy:** Implement a cancellation policy with different charges based on the time of cancellation.

**6. Check-in and Check-out:** Allow users to check in and check out of reserved parking slots.

# Contact Information:
  **Email:** smiley.smiley199@gmail.com

