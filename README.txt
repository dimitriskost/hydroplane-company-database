===========================================================================================
K29 Hydroplane Airline Database
===========================================================================================
Student: Dimitrios Kostinis
ID: 1112 2021 00235
Class: K29 Design and Use of Databases
Date: March 2026
===========================================================================================

1) Overview
-----------
This project presents the conceptual design and implementation of a robust, 
scalable relational database for K29-Hydro, a fictional hydroplane airline 
company operating in the Greek islands. 

The database is designed to handle the complex operational needs of the airline, 
including fleet management, specialized personnel scheduling, flight routing across 
different regions, customer bookings and loyalty programs.


2) Database Schema & ER Diagram
-------------------------------

The database architecture is built upon a detailed Entity-Relationship (E/R) model, 
carefully structured to avoid data anomalies and ensure scalability. 


3)Key Architectural Highlights
------------------------------

* Employee Management (ISA Hierarchy): A superclass `Employees` is broken down into 
  specialized subclasses (`Pilots`, `Assistants`, `Technicians`, `Admins`), each with 
  specific relationships (e.g., certifications for specific plane types).
* Fleet & Geography: Manages planes, plane types (capacity, speed), and connects them 
  to specific waterports, regions, and island destinations.
* Flight Scheduling: Utilizes aggregation to assign specific planes to flights independently 
  of ground crew assignments, reflecting real-world operational logic.
* Booking System: A robust reservation system that handles individual customers, dependent 
  passengers, and financial transactions.
* Loyalty & Feedback: Includes a tiered club system (Basic, Silver, Platinum) based on 
  kilometers flown, and a customer review tracking system.

